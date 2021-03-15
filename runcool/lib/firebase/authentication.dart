import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  String email;
  String password;
  User loggedInUser;
  final _auth = FirebaseAuth.instance;

  Authentication({this.email, this.password});

  Future<User> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return getCurrUser();
    } catch (e) {
      print(e);
    }
  }

  Future<User> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return getCurrUser();
    } catch (e) {
      print(e);
    }
  }

  User getCurrUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        return loggedInUser;
      }
    } catch (e) {
      print(e);
    }
    // return loggedInUser;
  }
}
