import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  // User loggedInUser;
  final _auth = FirebaseAuth.instance;

  Future<User> signUp(String email, String password) async {
    try {
      _auth.signOut();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
    return getCurrUser();
  }

  Future<User> logIn(String email, String password) async {
    try {
      _auth.signOut();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
    return getCurrUser();
  }

  User getCurrUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void logOut() {
    _auth.signOut();
  }
}
