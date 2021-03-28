import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';
import './SettingsUI/SettingsUI.dart';
import './SettingsUI/EditProfileUI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/firebase/Service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/firebase/Service/database.dart';
import 'package:provider/provider.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // return FutureBuilder<DocumentSnapshot>(
    //   future: users.doc(documentId).get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data.data();
    //       return Text(
    //         " ${data['name']}",
    //         style: TextStyle(
    //             fontSize: 30, color: kTurquoise, fontWeight: FontWeight.bold),
    //       );
    //     }
    //
    //     return Text("loading");
    //   },
    // );
  }
}

class ProfileUI extends StatefulWidget {
  @override
  ProfileUIState createState() => ProfileUIState();
}

class ProfileUIState extends State<ProfileUI> {
  final _auth = FirebaseAuth.instance;

  double fontMainSize = 15;
  void Settings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsUI()));
  }

  void Edit() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfileUI()));
  }

  @override
  Widget build(BuildContext context) {
    String uid;
    // String name;
    // int age;
    // String gender;
    // String hobbies;
    // String region;
    // String occupation;
    // String insta;
    // String bio;

    String email;

    // var user = _auth.currentUser;
    // if (user != null) {
    //   //TODO create a static var for UID. This should be in authentication pg. use dot set

    //   uid = user.uid;
    //   // name = user.name;
    //   // age = user.age;
    //   // gender = user.gender;
    //   // hobbies = user.hobbies;
    //   // region = user.region;
    //   // occupation = user.occupation;
    //   // insta = user.insta;
    //   // bio = user.bio;
    //   email = user.email;
    // }
    final user = Provider.of<AppUser>(context);

    // String userId = FirebaseAuth.instance.currentUser.uid;
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Settings(),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child:
                  IconButton(icon: Icon(Icons.edit), onPressed: () => Edit()),
            ),

            //leading: Container(),
          ]),
      body: BackgroundImage(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: CircleAvatar(
                  radius: 55,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                //child: GetUserName(userId),
                child: Text(
                  //'user input',
                  user.uid,

                  //name,
                  style: TextStyle(
                      fontSize: 30,
                      color: kTurquoise,
                      fontWeight: FontWeight.bold),
                )
                //GetUserName(uid),
                //'HZVHv7uJAbaZJk54FiamoGriJTs2'
                //users.getId()
                //users.doc().toString()
                //users.parent.toString()
                //'Noah',
                // style: TextStyle(
                //     fontSize: 30,
                //     color: kTurquoise,
                //     fontWeight: FontWeight.bold),
                ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.face, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Age',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    //age.toString(),
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.insert_emoticon,
                        size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',

                    // gender,
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.directions_run, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enjoys',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',

                    //hobbies,
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.home, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lives in',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    //region,
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.card_travel, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Occupation:',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    //occupation,
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.fitness_center, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Fitness level',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.directions_run, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'user input',
                      //insta,
                      style: TextStyle(
                          fontSize: fontMainSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.assignment_ind, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'user input',
                      //bio,
                      style: TextStyle(
                          fontSize: fontMainSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Friends',
                      style: TextStyle(
                          fontSize: 30,
                          color: kTurquoise,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  ),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
