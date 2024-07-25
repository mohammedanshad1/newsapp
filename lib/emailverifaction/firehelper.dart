import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homepage.dart';

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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
  Future<void> loginWithEmail(
      {required String email,
        required String password,
        required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) ;
      {
        // await sendEmailVerification(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => homes(
                  email: _auth.currentUser!.email .toString(),
                )));
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Password Reset Email has been Sent!",
            style: TextStyle(color: Colors.white),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user not found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "No User Found for That Email",
              style: TextStyle(fontSize: 28),
            )));
      }
    }
  }

  /// Google SIGN-IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Store user email in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': googleUser!.email,
      });

      // Navigate to HomePage
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homes(email: googleUser.email.toString())));
    } catch (e) {
      // Handle error
      print(e);
    }
  }
}
