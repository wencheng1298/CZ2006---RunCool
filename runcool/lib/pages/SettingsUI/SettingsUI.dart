import 'package:flutter/material.dart';
import 'package:runcool/pages/ProfileUI.dart';
import './../../utils/everythingUtils.dart';
import '../SignUpUI/LogIn.dart';

class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  void LogIn() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInUI()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        //leading: Container(),
      ),
      body: BackgroundImage(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              InputTextField1(text: 'Current password'),
              SizedBox(height: 10),
              InputTextField1(text: 'New password'),
              SizedBox(height: 10),
              InputTextField1(text: 'New password re-confirm'),
              SizedBox(height: 30),
              ButtonType1(onPress: () => LogIn(), text: 'Update password'),
              SizedBox(height: 70),
              ButtonType1(
                onPress: () => LogIn(),
                text: 'Log Out',
                colour: Colors.red,
              )
              //ButtonType1(onPress: () => goNextPage(), text: 'log out')
            ],
          ),
        ),
      ),
    );
  }
}
