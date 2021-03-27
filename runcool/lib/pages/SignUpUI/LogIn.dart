import 'package:flutter/material.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'SignUpUI1.dart';
import './../SettingsUI/SettingsUI.dart';
import '../../firebase/authenticationManager.dart';
import '../RuncoolNavBar.dart';
import 'package:runcool/firebase/Authenticate/authenticate.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:runcool/utils/loading.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 15);

class LogInUI extends StatefulWidget {
  @override
  _LogInUIState createState() => _LogInUIState();
}

// final Function toggleView;
// Register({this.toggleView});

class _LogInUIState extends State<LogInUI> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email;
  String password;
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: BackgroundImage(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
                child: Form(
                  key: _formKey,
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
                        }),

                    SizedBox(height: 20),

                    InputTextFormFill(
                      obscure: true,
                      text: 'PASSWORD',
                      onChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),

                    // TextFormField(
                    //   decoration: InputDecoration(hintText: 'email'),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       email = value;
                    //     });
                    //   },
                    // ),
                    // TextFormField(
                    //   obscureText: true,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       password = value;
                    //     });
                    //   },
                    // ),

                    // InputTextField1(
                    //   text: 'EMAIL',
                    //   onChange: (value) {
                    //     email = value;
                    //   },
                    // ),
                    // SizedBox(height: 20),
                    // InputTextField1(
                    //   text: 'PASSWORD',
                    //   onChange: (value) {
                    //     password = value;
                    //   },
                    // ),
                    SizedBox(height: 20),
                    ButtonType1(
                        onPress: () async {
                          setState(() {
                            loading = true;
                          });
                          print(email);
                          print(password);
                          // final user = await Authentication().logIn(email, password);
                          // if (user != null) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials';
                              loading = false;
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RuncoolNavBar()));
                          }
                          // }
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
                                style:
                                    TextStyle(color: kTurquoise, fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('forgot passsword');
                      },
                      child: Text('forgot password?', style: textStyle),
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
