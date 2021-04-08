import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runcool/pages/RuncoolNavBar.dart';
import 'package:runcool/pages/SignUpUI/LogIn.dart';
import 'package:runcool/models/User.dart';

import 'pages/HomePageUI.dart';
import 'pages/SignUpUI/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase/authenticationManager.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return LogInUI();
    } else {
      return RuncoolNavBar();
    }

    //this will either return home or login ui
    //return HomePageUI();
    //return AuthenticationManager().getCurrUserFromFirebase() == null
    //    ? LogInUI()
    //    : RuncoolNavBar();
  }
}
