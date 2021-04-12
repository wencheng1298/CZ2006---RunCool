import 'package:flutter/material.dart';
import '../../utils/everythingUtils.dart';
import './../../utils/everythingUtils.dart';
import './SignUpUI2.dart';
import 'package:runcool/controllers/AuthenticationManager.dart';

class SignUpUI1 extends StatefulWidget {
  @override
  SignUpUI1State createState() => SignUpUI1State();
}

class SignUpUI1State extends State<SignUpUI1> {
  final AuthenticationManager _auth = AuthenticationManager();
  final _formkey = GlobalKey<FormState>();

  String email;
  String password;
  String error = '';

  void goNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            //builder: (context) => SignUpUI2(credentials: credentials)));
            builder: (context) => SignUpUI2(email: email, password: password)));
  }

  Map<String, String> credentials = {"email": "", "password": ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign Up'),
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
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 60),
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
                InputTextFormFill(
                    validate: (value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value) || value == null)
                        return 'Enter a valid email address';
                      else
                        return null;
                    },
                    obscure: false,
                    text: 'EMAIL',
                    onChange: (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                SizedBox(height: 5),
                InputTextFormFill(
                    obscure: true,
                    text: 'PASSWORD',
                    onChange: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validate: (val) {
                      if (val.isEmpty) {
                        return "Enter a password";
                      } else if (val.length < 8) {
                        return 'Enter a password with at least 8 characters';
                      } else {
                        return null;
                      }
                    }),

                SizedBox(height: 5),
                InputTextFormFill(
                    obscure: true,
                    text: 'CONFIRM PASSWORD',
                    validate: (val) => val == password
                        ? null
                        : 'This does not match with the password you entered.'
                    // onChange: (value) {
                    //   setState(() {
                    //     password = value;
                    //   });
                    // },
                    ),
                SizedBox(height: 20),
                ButtonType1(
                    text: 'Continue',
                    onPress: () async {
                      if (_formkey.currentState.validate()) {
                        goNextPage();
                      }
                      // setState(() {
                      //   error = 'Invalid entry';
                      // });
                      // } else {
                      //   goNextPage();
                      //   // print(result.uid);
                      // }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),

                //=> goNextPage(), text: 'Sign up!'
              ]

                  // TextFormField(
                  //   onChanged: (value) {
                  //     setState(() {
                  //       email = value;
                  //     });
                  //   },
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'password'),
                  //   obscureText: true,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       password = value;
                  //     });
                  //   },
                  // ),
                  // InputTextField1(
                  //   text: 'EMAIL',
                  //   onChange: (value) => credentials['email'] = value,
                  // ),
                  // SizedBox(height: 20),
                  // InputTextField1(
                  //   text: 'PASSWORD',
                  //   onChange: (value) => credentials['password'] = value,
                  //  ),
                  // SizedBox(height: 20),
                  // InputTextField1(text: 'PASSWORD CONFIRM'),

                  ),
            ),
          ),
        ),
      ),
    );
  }
}
