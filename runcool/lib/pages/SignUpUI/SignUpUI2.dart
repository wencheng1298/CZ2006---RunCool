import 'package:flutter/material.dart';
import './SignUpSuccessUI.dart';
import './../../utils/everythingUtils.dart';
import '../../firebase/authentication.dart';

class SignUpUI2 extends StatefulWidget {
  final Map<String, String> credentials;
  SignUpUI2({this.credentials});
  @override
  SignUpUI2State createState() => SignUpUI2State();
}

class SignUpUI2State extends State<SignUpUI2> {
  void signUpAndGoNextPage() async {
    // final user = await Authentication()
    //     .signUp(widget.credentials['email'], widget.credentials['password']);
    // if (user != null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpSuccessUI()));
    // }
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
                child: InputTextField1(text: "Name", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Age", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Gender", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Hobbies", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Region", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Occupation", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InputTextField1(text: "Instagram Handle", height: 35),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 10,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800].withOpacity(0.5),
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
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
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
                  child: Icon(
                    Icons.camera_enhance_rounded,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 20),
                child: TinyButton(
                    onPress: signUpAndGoNextPage,
                    text: "Create",
                    colour: kTurquoise),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
