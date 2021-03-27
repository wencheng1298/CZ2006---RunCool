import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/firebase/Service/database.dart';
import 'package:runcool/pages/SignUpUI/SignUpUI2.dart';

class AuthService {
  //this class will contains the methods for the different sign in methods

  // String name;
  // int age;
  // String gender;
  // String hobbies;
  // String region;
  // String occupation;
  // String insta;
  // String bio;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
    //  .map(_userFromFirebaseUser);
  }
  //register with email and pw

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new doc for the user with new id
      await DatabaseService(uid: user.uid).updateUserData(
        email,
        password,
        // name,
        // age,
        // gender,
        // hobbies,
        // region,
        // occupation,
        // insta,
        // bio,
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign in using email and pw

  //sign in using Fb for eg

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
