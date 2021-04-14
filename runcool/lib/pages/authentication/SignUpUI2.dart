import 'package:flutter/material.dart';
import './SignUpSuccessUI.dart';
import './../../utils/everythingUtils.dart';
import 'package:runcool/controllers/AuthenticationManager.dart';
import 'package:runcool/controllers/ProfileManager.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpUI2 extends StatefulWidget {
  final String email;
  final String password;
  SignUpUI2({@required this.email, @required this.password});

  @override
  SignUpUI2State createState() => SignUpUI2State();
}

class SignUpUI2State extends State<SignUpUI2> {
  final AuthenticationManager _auth = AuthenticationManager();
  final profileManager = ProfileManager();
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic> profileDetails = {};
  String error = '';

  File _image;
  String _imageSource;

  void goNextPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpSuccessUI()));
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

  List<String> genderLevels = ["Others", 'Male', 'Female'];
  List<String> regionLevels = [
    "Central",
    "East",
    "North",
    "North-East",
    "West"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
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

                  // NAME
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: InputTextFormFill(
                      validate: (val) {
                        if (val.isEmpty) {
                          return 'Your profile must have a name!';
                        } else if (val.length < 5) {
                          return 'your name must be at lease 5 characters long.';
                        } else {
                          return null;
                        }
                      },
                      text: 'Name',
                      onChange: (val) {
                        profileDetails['name'] = val;
                      },
                    ),
                  ),

                  // AGE
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: InputTextFormFill(
                      // validator:(value)=> value.isEmpty?'Enter an email' :null,
                      obscure: false,
                      text: 'age',
                      onChange: (val) {
                        try {
                          val = int.parse(val);
                          profileDetails['age'] = val;
                        } catch (error) {
                          profileDetails['age'] = 0;
                        }
                      },
                      validate: (val) {
                        if (val.isEmpty) {
                          return 'Your profile must have an age!';
                        } else {
                          try {
                            val = int.parse(val);
                            if (val > 100 || val < 10) {
                              return "age must be within 10 and 100";
                            } else {
                              return null;
                            }
                          } catch (e) {
                            return "Enter a valid number.";
                          }
                        }
                      },
                    ),
                  ),

                  //GENDER
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: DropdownFormFill(
                        value: profileDetails['gender'],
                        onChange: (newChoice) {
                          setState(() {
                            profileDetails['gender'] = newChoice;
                          });
                        },
                        items: genderLevels,
                        text: "Gender",
                        validate: (val) =>
                            val == null ? 'Choose your gender' : null,
                      )),

                  // HOBBIES
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InputTextFormFill(
                      obscure: false,
                      text: 'Hobbies',
                      onChange: (val) {
                        profileDetails['hobbies'] = val;
                      },
                    ),
                  ),

                  // REGION
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: DropdownFormFill(
                        value: profileDetails['region'],
                        onChange: (newChoice) {
                          setState(() {
                            profileDetails['region'] = newChoice;
                          });
                        },
                        items: regionLevels,
                        text: "Region",
                      )),

                  // OCCUPATION
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InputTextFormFill(
                      obscure: false,
                      text: 'Occupation',
                      onChange: (val) {
                        profileDetails['occupation'] = val;
                      },
                    ),
                  ),

                  // INSTA
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

                  // BIO
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InputTextFormFill(
                        // validator:(value)=> value.isEmpty?'Enter an email' :null,
                        obscure: false,
                        text: 'Bio',
                        onChange: (value) {
                          profileDetails['bio'] = value;
                        }),
                  ),

                  // PICTURE
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
                        backgroundImage:
                            _image != null ? Image.file(_image).image : null,
                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Text("Take a picture"), value: "camera"),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 10, right: 10, bottom: 0),
                    child: ButtonType1(
                        text: 'Create!',
                        onPress: () async {
                          setState(() {
                            error = '';
                          });
                          if (_formkey.currentState.validate()) {
                            dynamic result = await profileManager.createUser(
                                profileDetails, widget.email, widget.password);
                            print("result is");
                            print(result);
                            if (result == null) {
                              setState(() {
                                error =
                                    "Something went wrong. Could not create account. Check all the details and try again.";
                              });
                            } else {
                              goNextPage();
                            }
                          }
                        }),
                  ),
                  // SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
