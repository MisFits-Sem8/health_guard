import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user?.email;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        return e.message;
      }
    }
    return null;
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
      print('ERROR: ${e.code}');
      return 'Check your email and password.';
    } catch (e) {
      return "Something went wrong!";
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
