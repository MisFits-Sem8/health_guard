import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:health_app/services/database.dart';
import 'package:health_app/models/user.dart';

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

}
