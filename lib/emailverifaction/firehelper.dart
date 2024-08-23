// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firestoreproject/emailverifaction/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/news_view.dart';

class firebase {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  firebase(this._auth);

  /// Email SIGNUP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
      
      // Store user email in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  /// Email LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homes()),
      );
      // Check if the email is verified
      if (userCredential.user != null && userCredential.user!.emailVerified) {
      } else {
        showSnackBar(context, "Logging Successfull");
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException has a code and message property
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided.");
      } else {
        showSnackBar(context, "Error: ${e.message}");
      }
    } catch (e) {
      // Catch any other errors
      showSnackBar(context, "An unexpected error occurred. Please try again.");
    }
  }

  /// Email VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email Verification sent!");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar(context, "Password Reset Email has been Sent!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showSnackBar(context, "No User Found for That Email");
      }
    }
  }

  /// Google SIGN-IN

  /// Google SIGN-IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        showSnackBar(context, "Google sign-in was cancelled.");
        return;
      } else {
        showSnackBar(context, "Logging Successfull");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': googleUser.email,
      });

      // Store email and profile picture URL in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', googleUser.email);
      await prefs.setString('userProfilePic', googleUser.photoUrl ?? '');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homes()),
      );
    } catch (e) {
      showSnackBar(context, "Failed to sign in with Google: $e");
    }
  }
}
