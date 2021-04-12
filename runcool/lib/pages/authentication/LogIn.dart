import 'package:flutter/material.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'SignUpUI1.dart';
import './../SettingsUI/SettingsUI.dart';
import '../RuncoolNavBar.dart';

import 'package:runcool/firebase/AuthenticationManager.dart';
import 'package:runcool/utils/loading.dart';
import 'ForgotPasswordUI.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 15);

class LogInUI extends StatefulWidget {
  @override
  _LogInUIState createState() => _LogInUIState();
}

class _LogInUIState extends State<LogInUI> {
  final _formKey = GlobalKey<FormState>(); // VALIDATE
  final AuthenticationManager _auth = AuthenticationManager();

  String email;
  String password;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundImage(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
          child: Form(
            // VALIDATE
            key: _formKey, // VALIDATE
            child: Column(children: <Widget>[
              SizedBox(height: 100),
              Image(
                image: AssetImage('images/logo.png'),
                height: 300,
              ),
              InputTextFormFill(
                obscure: false,
                text: 'EMAIL',
                onChange: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validate: (val) =>
                    val.isEmpty ? 'Enter an email' : null, // VALIDATE
              ),
              SizedBox(height: 5),
              InputTextFormFill(
                  obscure: true,
                  text: 'PASSWORD',
                  onChange: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validate: (val) => val.isEmpty ? 'Enter a password' : null),
              SizedBox(height: 5),
              ButtonType1(
                  onPress: () async {
                    setState(() {
                      error = '';
                    });
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                        });
                      } else {
                        Phoenix.rebirth(context);
                      }
                    }
                  },
                  text: 'Login'),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to community? ', style: textStyle),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpUI1()));
                      },
                      child: Text('Sign up.',
                          style: TextStyle(
                              color: kTurquoise,
                              fontSize: 15,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResetScreen()));
                },
                child: Text('forgot password?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.underline)),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
