import 'package:flutter/material.dart';
import '../../widgets/InputTextField.dart';
import '../../utils/constants.dart';
import './../../utils/backgroundImage.dart';
import './../../utils/buttons.dart';
import './SignUpSuccessUI.dart';


class SignUpUI2 extends StatefulWidget {
  @override
  SignUpUI2State createState() => SignUpUI2State();
}

class SignUpUI2State extends State<SignUpUI2> {
  void goNextPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpSuccessUI()));
  }

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
      body: BackgroundImage(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Container(
                  child: Text(
                    'Thank you for signing up with The Chase!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  child: Text(
                    'Before we get your started, help us create your chase profile.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Name"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Age"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Gender"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Hobbies"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Region"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Occupation"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField(hint: "Instagram Handle"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 10,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                        EdgeInsets.only(left: 14, bottom: 8, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kTurquoise, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kTurquoise, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Bio",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  "Upload Profile Pic",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey[800],
                  child: Icon(Icons.camera_enhance_rounded, size: 35,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30, left:10, right: 10, bottom: 20),
                child: TinyButton(onPress: goNextPage, text: "Create", colour: kTurquoise),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
