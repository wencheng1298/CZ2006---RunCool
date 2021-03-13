import 'package:flutter/material.dart';
import '../../widgets/InputTextField.dart';
import '../../widgets/InputFieldTextTitles.dart';
import './../../utils/everythingUtils.dart';
import './SignUpUI2.dart';


class SignUpUI1 extends StatefulWidget {
  @override
  SignUpUI1State createState() => SignUpUI1State();
}

class SignUpUI1State extends State<SignUpUI1> {
  void goNextPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpUI2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                InputTextField2(text: 'EMAIL'),
                SizedBox(height: 20),
                InputTextField2(text: 'PASSWORD'),
                SizedBox(height: 20),
                InputTextField2(text: 'PASSWORD CONFIRM'),
                SizedBox(height: 20),
                ButtonType1(onPress: () => goNextPage(), text: 'Sign up!')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
