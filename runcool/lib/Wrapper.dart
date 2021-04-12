import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runcool/firebase/AuthenticationManager.dart';
import 'package:runcool/pages/RuncoolNavBar.dart';
import 'package:runcool/pages/authentication/LogIn.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/pages/authentication/Verification.dart';
import 'firebase/ProfileManager.dart';

import 'pages/HomePageUI.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // final user = AuthenticationManager().getCurrUserFromFirebase();
    User user = FirebaseAuth.instance.currentUser;
    // print(user);
    if (user == null) {
      return LogInUI();
    } else if (!user.emailVerified) {
      return Verification();
    } else {
      // return Verification();
      return RuncoolNavBar();
    }

    //this will either return home or login ui
    //return HomePageUI();
    //return AuthenticationManager().getCurrUserFromFirebase() == null
    //    ? LogInUI()
    //    : RuncoolNavBar();
  }
}
