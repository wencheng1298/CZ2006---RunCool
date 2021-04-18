import 'package:flutter/material.dart';

import 'package:runcool/pages/NavBar.dart';
import 'package:runcool/pages/authentication/LogIn.dart';

import 'package:runcool/pages/authentication/Verification.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return LogInUI();
    } else if (!user.emailVerified) {
      return Verification();
    } else {
      return RuncoolNavBar();
    }
  }
}
