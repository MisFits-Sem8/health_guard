import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await cred.user?.updateDisplayName(name);
      return cred.user?.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Check your email and password.";
      }
    }
  }

  Future<String?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user?.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return 'Check your email and password.';
      } else {
        print(e.code);
        return "Something went wrong!";
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
}
