import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/firebase/Service/database.dart';
import 'package:runcool/pages/SignUpUI/SignUpUI2.dart';
import '../ProfileManager.dart';

class AuthenticationManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges();
    // .map((User user) => ProfileManager().getUserFromID(user.uid));
    // .map((User user) => _userFromFirebaseUser(user));
  }

  User getCurrUserFromFirebase() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // User user = result.user;
      // return _userFromFirebaseUser(user);

      return "success";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register a user with email and password
  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new doc for the user with new id
      return user;
      // return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in using email and pw

  //sign in using Fb for eg

  Future signOut() async {
    try {
      print("trying to sign out");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
