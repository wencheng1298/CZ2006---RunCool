import 'package:flutter/material.dart';
import './SignUpSuccessUI.dart';
import './../../utils/everythingUtils.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:runcool/firebase/ProfileManager.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpUI2 extends StatefulWidget {
  // //SignUpUI2({this.profileDetails});
  final String email;
  final String password;
  SignUpUI2({@required this.email, @required this.password});

  // final Map<String, String> credentials;
  //
  @override
  SignUpUI2State createState() => SignUpUI2State();
}

class SignUpUI2State extends State<SignUpUI2> {
  final AuthenticationManager _auth = AuthenticationManager();
  final profileManager = ProfileManager();
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic> profileDetails = {};
  //SignUpUI2State({this.profileDetails});

  // String name;
  // int age;
  // String gender;
  // String hobbies;
  // String region;
  // String occupation;
  // String insta;
  // String bio;
  File _image;
  String _imageSource;

  void goNextPage() async {
    // final user = await Authentication()
    //     .signUp(widget.credentials['email'], widget.credentials['password']);
    // if (user != null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpSuccessUI()));
    // }
  }

  void createProfile(Map profileDetails) {
    ProfileManager().updateProfile(profileDetails);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpSuccessUI()));
  }

  void getImage() async {
    PickedFile img = await ImagePicker().getImage(
        source: _imageSource == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery);
    setState(() {
      _image = File(img.path);
    });

    String link = await profileManager.uploadPic(_image);
    setState(() {
      profileDetails["image"] = link;
    });
  }

  @override
  Widget build(BuildContext context) {
    String error = '';
    bool loading = false;

    return loading
        ? Loading()
        : Scaffold(
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
                child: Form(
                  key: _formkey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          child: Text(
                            'Help us create your chase profile before we successfully sign you up!',
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
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'Name',

                          onChange: (val) {
                            profileDetails['name'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'age',
                          onChange: (val) {
                            profileDetails['age'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'Gender',

                          onChange: (val) {
                            profileDetails['gender'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'Hobbies',
                          onChange: (val) {
                            profileDetails['hobbies'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'Region',
                          onChange: (val) {
                            profileDetails['region'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'Occupation',
                          onChange: (val) {
                            profileDetails['occupation'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputTextFormFill(
                          //validator: (value) =>
                          //   value.isEmpty ? 'Enter an email' : null,
                          obscure: false,
                          text: 'Instagram Handle',
                          onChange: (val) {
                            profileDetails['instagram'] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: InputTextFormFill(
                            // validator:(value)=> value.isEmpty?'Enter an email' :null,
                            obscure: false,
                            text: 'Bio',
                            onChange: (value) {
                              profileDetails['bio'] = value;
                            }),
                        //autofocus: false,
                        //keyboardType: TextInputType.multiline,
                        //minLines: 3,
                        //maxLines: 10,
                        //style: TextStyle(color: Colors.white),
                        //decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.grey[800].withOpacity(0.5),
                        //contentPadding:
                        //   EdgeInsets.only(left: 14, bottom: 8, top: 8),
                        //focusedBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: kTurquoise, width: 2),
                        // borderRadius: BorderRadius.circular(20),
                        // ),
                        //enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: kTurquoise, width: 2),
                        //borderRadius: BorderRadius.circular(20),
                        // ),
                        //  hintText: "Bio",
                        // hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          "Upload Profile Pic",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Center(
                          child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.grey[800],
                              backgroundImage: _image != null
                                  ? Image.file(_image).image
                                  : null,
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Text("Take a picture"),
                                      value: "camera"),
                                  PopupMenuItem(
                                      child: Text("Upload from gallery"),
                                      value: "gallery")
                                ],
                                child: Icon(
                                  Icons.camera_enhance_rounded,
                                  size: 35,
                                ),
                                onSelected: (result) {
                                  setState(() {
                                    _imageSource = result;
                                  });
                                  getImage();
                                },
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 10, right: 10, bottom: 20),
                        child: ButtonType1(
                            text: 'Create!',
                            onPress: () async {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await profileManager.createUser(
                                  profileDetails,
                                  widget.email,
                                  widget.password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      "Something went wrong. Could not create account. Check all the details and try again.";
                                  loading = false;
                                });
                              } else {
                                goNextPage();
                              }

                              // if(_formkey.currentState.validate()){
                              //   print(email);
                              //   print(password);
                              // }
                              //
                            }),

                        // TinyButton(
                        //     onPress: signUpAndGoNextPage,
                        //     text: "Create",
                        //     colour: kTurquoise),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
