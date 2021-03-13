import 'package:flutter/material.dart';
import '../../widgets/InputTextField.dart';
import '../../widgets/InputFieldTextTitles.dart';
import '../../utils/constants.dart';
import './../../utils/buttons.dart';
import './../../main.dart';

class SignUpSuccessUI extends StatefulWidget {
  @override
  SignUpSuccessUIState createState() => SignUpSuccessUIState();
}

class SignUpSuccessUIState extends State<SignUpSuccessUI> {
  void goToNavPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RuncoolNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: Container()),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Sign Up!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 20),
              child: TinyButton(
                  onPress: goToNavPage, text: "Go To Home Page", colour: kTurquoise),
            ),
          ],
        ),
      ),
    );
  }
}
