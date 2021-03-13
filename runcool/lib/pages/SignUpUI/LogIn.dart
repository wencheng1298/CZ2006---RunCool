import 'package:flutter/material.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'SignUpUI1.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 15);

class LogInUI extends StatefulWidget {
  @override
  _LogInUIState createState() => _LogInUIState();
}

class _LogInUIState extends State<LogInUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 100),
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 300,
                ),
                InputTextField2(text: 'EMAIL'),
                SizedBox(height: 20),
                InputTextField2(text: 'PASSWORD'),
                SizedBox(height: 20),
                ButtonType1(onPress: () {}, text: 'Login'),
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
      ),
    );
  }
}
