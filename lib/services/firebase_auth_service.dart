import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email and Password
  Future<void> createUserWithEmailAndPassword(
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Login with Email and Password
  Future<void> loginUserWithEmailAndPassword(
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Get the Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
