import 'package:flutter/material.dart';
import '../../widgets/InputTextField.dart';
import '../../widgets/InputFieldTextTitles.dart';
import './../../utils/constants.dart';


class SignUpUI1 extends StatefulWidget {
  @override
  SignUpUI1State createState() => SignUpUI1State();
}

class SignUpUI1State extends State<SignUpUI1> {
  // void goNextPage() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => CreateRunningUI2()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                  child: Text(
                'Sign Up!',
                style: TextStyle(color: Colors.white, fontSize: 36,),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
