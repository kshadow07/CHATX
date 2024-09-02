import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign up
  Future<UserCredential> signinwithemailandpass(
      String email, pass, username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);

      // save user info
      Future.delayed(const Duration(milliseconds: 500),
          () => const Center(child: CircularProgressIndicator()));
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  // sign in
  Future<UserCredential> loginwithemailandpass(String email, pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      // save user info
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  //sign out
  Future<void> logout() async {
    try {
      return _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

// errors
}
