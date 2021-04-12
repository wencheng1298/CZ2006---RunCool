import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../utils/everythingUtils.dart';
import './../../utils/everythingUtils.dart';
import './SignUpUI2.dart';
import 'package:runcool/firebase/AuthenticationManager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Verify Email'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kBackgroundColor,
        child: BackgroundImage(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "An email has been sent to the email you registered with. Please verify to start exercising with some new friends!",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TinyButton(
                    onPress: () async {
                      User user = FirebaseAuth.instance.currentUser;
                      await user.reload();
                      Phoenix.rebirth(context);
                    },
                    text: "reload",
                    colour: kTurquoise,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TinyButton(
                    onPress: () async {
                      await AuthenticationManager().signOut();
                      Phoenix.rebirth(context);
                    },
                    text: "logout",
                    colour: Colors.redAccent,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
