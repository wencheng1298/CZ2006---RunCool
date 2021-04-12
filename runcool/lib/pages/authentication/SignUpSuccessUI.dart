import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/InputFieldTextTitles.dart';
import '../../utils/everythingUtils.dart';
import './../RuncoolNavBar.dart';
import '../../firebase/ProfileManager.dart';
import '../../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SignUpSuccessUI extends StatefulWidget {
  @override
  SignUpSuccessUIState createState() => SignUpSuccessUIState();
}

class SignUpSuccessUIState extends State<SignUpSuccessUI> {
  void goToNavPage() {
    Phoenix.rebirth(context);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => RuncoolNavBar()));
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
      body: BackgroundImage(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                child: Text(
                  'Your Profile has been created!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
                child: Text(
                  'Enjoy our services.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TinyButton(
                    onPress: goToNavPage,
                    text: "Go To Home Page",
                    colour: kTurquoise),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
