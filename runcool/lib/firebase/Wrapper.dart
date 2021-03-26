import 'package:flutter/material.dart';
import 'package:runcool/pages/RuncoolNavBar.dart';
import 'package:runcool/pages/SignUpUI/LogIn.dart';

import '../pages/HomePageUI.dart';
import 'authenticationManager.dart';
import 'authenticationManager.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //this will either return home or login ui
    //return HomePageUI();
    return AuthenticationManager().getCurrUserFromFirebase() == null
        ? LogInUI()
        : RuncoolNavBar();
  }
}
