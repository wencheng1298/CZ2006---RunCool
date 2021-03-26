import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //this class will contains the methods for the different sign in methods

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anonymously. This will be removed later, just for testing purposes
  //might be wrong, check agn later
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in using email and pw

  //sign in using Fb for eg

}
