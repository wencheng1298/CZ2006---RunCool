import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/everythingUtils.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

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
          child: Form(
            key: _formkey,
            //margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  ButtonType1(
                      text: 'Reset now',
                      onPress: () async {
                        // if(_formkey.currentState.validate()){
                        //   print(email);
                        //   print(password);
                        // }
                        await _auth.sendPasswordResetEmail(email: email);
                        Navigator.of(context).pop();
                      }),

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
    );
  }
}
