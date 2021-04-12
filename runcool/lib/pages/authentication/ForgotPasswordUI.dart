import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/everythingUtils.dart';
import 'package:runcool/controllers/AuthenticationManager.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String error = '';
  Color color = Colors.red;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kBackgroundColor,
        child: BackgroundImage(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Form(
              key: _formkey,
              // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InputTextFormFill(
                        validate: (value) =>
                            value.isEmpty ? 'Enter an email' : null,
                        obscure: false,
                        text: 'EMAIL',
                        onChange: (value) {
                          setState(() {
                            email = value;
                          });
                        }),
                    SizedBox(height: 20),
                    ButtonType1(
                        text: 'Reset now',
                        onPress: () async {
                          setState(() {
                            error = '';
                          });
                          if (_formkey.currentState.validate()) {
                            dynamic result = await AuthenticationManager()
                                .forgetPassword(email);
                            String err;
                            if (result == null) {
                              err =
                                  "Could not send reset email. Ensure the email provided corresponds to a valid user.";
                            } else {
                              err = "email sent to ${email} to reset password.";
                              color = Colors.green;
                            }
                            setState(() {
                              error = err;
                            });
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color, fontSize: 14.0),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
