import 'package:flutter/material.dart';
import '../../utils/everythingUtils.dart';
import './../../utils/everythingUtils.dart';
import './SignUpUI2.dart';
import 'package:runcool/firebase/Service/auth.dart';

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
      resizeToAvoidBottomInset: false,
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
            //margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
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
                        // validator:(value)=> value.isEmpty?'Enter an email' :null,
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
                    SizedBox(height: 20),
                    InputTextFormFill(
                      obscure: true,
                      text: 'CONFIRM PASSWORD',
                      onChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ButtonType1(
                        text: 'Sign up!',
                        onPress: () async {
                          // if(_formkey.currentState.validate()){
                          //   print(email);
                          //   print(password);
                          // // }
                          // dynamic result = await _auth
                          //     .registerWithEmailAndPassword(email, password);
                          if (email == null || password == null) {
                            setState(() {
                              error = 'Invalid entry';
                            });
                          } else {
                            goNextPage();
                            // print(result.uid);
                          }
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
