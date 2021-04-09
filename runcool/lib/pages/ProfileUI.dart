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
import 'profile/profileList.dart';

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

  List<String> friends = [
    'Paula',
    'Eugene',
    'Sarah',
    'Bob',
    'Ho',
    'RERE',
    'BIZ'
  ];
  List<Widget> friendsWidgets = [];

  void _fillFriends() {
    setState(() {
      friends.forEach((element) {
        friendsWidgets
            .add(Icon(Icons.account_circle, size: 70, color: kTurquoise));
      });
    });
  }

  @override
  void initState() {
    _fillFriends();
    super.initState();
  }

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
    final AppUser user = Provider.of<AppUser>(context);
    // print(user.name);
    // String userId = FirebaseAuth.instance.currentUser.uid;
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return (user == null)
        ? Loading()
        : Scaffold(
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
                    child: IconButton(
                        icon: Icon(Icons.edit), onPressed: () => Edit()),
                  ),

                  //leading: Container(),
                ]),
            body: BackgroundImage(
              child: ProfileList(user: user),
            ),
          );
  }
}
