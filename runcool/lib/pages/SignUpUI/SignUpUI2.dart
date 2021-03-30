import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/User.dart';
import './SignUpSuccessUI.dart';
import './../../utils/everythingUtils.dart';
import '../../firebase/authenticationManager.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:runcool/firebase/Service/database.dart';
import 'package:runcool/firebase/ProfileManager.dart';

class SignUpUI2 extends StatefulWidget {
  Map profileDetails;
  //SignUpUI2({this.profileDetails});

  // final Map<String, String> credentials;
  // SignUpUI2({this.credentials});
  @override
  SignUpUI2State createState() => SignUpUI2State();
}

class SignUpUI2State extends State<SignUpUI2> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  Map profileDetails;
  //SignUpUI2State({this.profileDetails});

  String name;
  int age;
  String gender;
  String hobbies;
  String region;
  String occupation;
  String insta;
  String bio;

  void signUpAndGoNextPage() async {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

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
          child: Form(
            key: _formkey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                  child: ButtonType1(
                      text: 'Create!',
                      onPress: () async {
                        //print(profileDetails);
                        ProfileManager().updateUser(profileDetails);
                        print(user.uid);
                        signUpAndGoNextPage();

                        // ProfileManager().updateProfile(profileDetails);

                        // if(_formkey.currentState.validate()){
                        //   print(email);
                        //   print(password);
                        // }
                        //
                        // dynamic result =
                        //     await DatabaseService.updateExtraUserData(
                        //         name,
                        //         age,
                        //         gender,
                        //         hobbies,
                        //         region,
                        //         occupation,
                        //         insta,
                        //         bio);
                      }),

                  // TinyButton(
                  //     onPress: signUpAndGoNextPage,
                  //     text: "Create",
                  //     colour: kTurquoise),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
