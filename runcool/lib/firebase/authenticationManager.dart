// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Authenticate extends StatefulWidget {
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }
//
// class _AuthenticateState extends State<Authenticate> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('authenticate'),
//     );
//   }
// }
//
// class AuthenticationManager {
//   String email;
//   String password;
//   static User loggedInUser;
//   final _auth = FirebaseAuth.instance;
//
//   AuthenticationManager({this.email, this.password});
//
//   Future<User> signUp(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return getCurrUserFromFirebase();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<User> logIn(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return getCurrUserFromFirebase();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   User getCurrUserFromFirebase() {
//     // try {
//     //   final user = _auth.currentUser;
//     //   return _auth.currentUser;
//     // } catch (e) {
//     //   print(e);
//     // }
//     return loggedInUser;
//     // return loggedInUser;
//   }
//
//   // User getCurrUser() {
//   //   return loggedInUser;
//   // }
// }
