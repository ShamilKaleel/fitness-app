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

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error in resetPassword: $e");
      rethrow;
    }
  }

  // Update Email
  Future<void> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.updateEmail(newEmail);
    } catch (e) {
      print("Error in updateEmail: $e");
      rethrow;
    }
  }

  // Update Password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      print("Error in updatePassword: $e");
      rethrow;
    }
  }
}
