import 'package:flutter/material.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'SignUpUI1.dart';
import './../SettingsUI/SettingsUI.dart';
import '../../firebase/authenticationManager.dart';
import '../RuncoolNavBar.dart';

// import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';
// import 'package:flutter/services.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 15);

class LogInUI extends StatefulWidget {
  @override
  _LogInUIState createState() => _LogInUIState();
}

class _LogInUIState extends State<LogInUI> {
  String email;
  String password;

  // Map<String, dynamic> data;
  //
  // Future<String> loadJsonData() async {
  //   var jsonText = await rootBundle.loadString('assets/gyms-sg-geojson.json');
  //   setState(() => data = json.decode(jsonText));
  //   print(data);
  //   print(data["features"][0]["geometry"]["coordinates"]);
  //
  //   return 'success';
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   this.loadJsonData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundImage(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 100),
              Image(
                image: AssetImage('images/logo.png'),
                height: 300,
              ),
              InputTextField1(
                text: 'EMAIL',
                onChange: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),
              InputTextField1(
                text: 'PASSWORD',
                onChange: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              ButtonType1(
                  onPress: () async {
                    // final user = await Authentication().logIn(email, password);
                    // if (user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RuncoolNavBar()));
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
                          style: TextStyle(color: kTurquoise, fontSize: 15)),
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
            ],
          ),
        ),
      ),
    );
  }
}
