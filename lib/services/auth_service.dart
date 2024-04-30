import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:health_app/services/database.dart';
import 'package:health_app/models/user.dart';
import 'package:http/http.dart' as http;
import '../view/message/message.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: cred.user!.uid).addUserName(name);
      return UserModel(email: cred.user?.email, uid: cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return UserModel(email: "The account already exists for that email.");
      } else {
        return UserModel(email: "Check your email and password.");
      }
    }
  }

  Future<UserModel> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel(email: cred.user?.email, uid: cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return UserModel(email: 'Check your email and password.');
      } else {
        print(e.code);
        return UserModel(email: "Something went wrong!");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong!");
      }
    }
  }

  Future<void> addUserData(int height, int weight, int age, double water,
      double workout, double sleep, String gender) async {
    try {
      final user = _auth.currentUser;
      await DatabaseService(uid: user!.uid)
          .addUserdata(height, weight, age, water, workout, sleep, gender);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<UserDataModel?> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final data = await DatabaseService(uid: user.uid).userData.first;
        if (data.exists) {
          final userData = data.data() as Map<String, dynamic>;
          return UserDataModel(
            userData["name"],
            userData["age"],
            userData["height"],
            userData["weight"],
            userData["sleep"],
            userData["workout"],
            userData["water"],
            userData["gender"],
          );
        } else {
          print("User data doesn't exist.");
          return null;
        }
      } else {
        print("User is not logged in");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    }
  }

  Future<List<Message>> sendText(String text, List<Message> messages) async {
    try {
      var responseText = "";
      String prompt =
          "As 'HealthGuard', your role is to be a virtual health advisor, providing guidance on topics like sleep, exercise, hydration, and more. When users seek advice on their health, respond in a friendly and concise manner, aiming to encourage healthier habits. Keep your answers simple, short and helpful, promoting the importance of prioritizing health and well-being.\n\nExample Conversation Format:\nUser: I'm feeling tired. \nHealthGuard: Are you getting enough sleep?\n";

      if (messages != []) {
        prompt += "\nPrevious conversation: ";
        for (Message message in messages) {
          if (message.isSentByMe) {
            prompt += "\nUser: ${message.text} ";
          } else {
            prompt += "\nHealthGuard: ${message.text} ";
          }
        }
      }

      prompt +=
          "\n\nProvide your single, short response only to the following message, focusing on offering practical advice and support. \nUser: ${text}";

      Message newMessage = Message(
          text: text,
          date: DateTime.now(),
          isSentByMe: true);

      messages.add(newMessage);

      final user = _auth.currentUser;
      final response = await http.post(
        Uri.parse('https://flask-chat.vercel.app/chat'),
        body: json.encode({'message': prompt}),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var out = json.decode(response.body);
        responseText = out['response'];
        print(responseText);
        Message responseMessage = Message(
          text: responseText,
          date: DateTime.now(),
          isSentByMe: false,
        );
        messages.add(responseMessage);

        await DatabaseService(uid: user!.uid).addMessageToChat(newMessage);
        await DatabaseService(uid: user.uid).addMessageToChat(responseMessage);
      }
      return messages;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return messages;
    }
  }

  Future<List<Message>> getUserMessages() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return await DatabaseService(uid: user.uid).getMessages();
      } else {
        print("User data doesn't exist.");
        return [];
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e.code);
      } else {
        print('Error: $e');
      }
      return [];
    }
  }
}
