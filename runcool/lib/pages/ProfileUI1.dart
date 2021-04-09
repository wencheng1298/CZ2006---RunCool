import 'package:flutter/material.dart';
import 'package:runcool/firebase/ProfileManager.dart';
import 'package:runcool/pages/profile/profileList.dart';
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

class ProfileUI1 extends StatefulWidget {
  @override
  final String userID;
  ProfileUI1({this.userID});
  ProfileUI1State createState() => ProfileUI1State();
}

class ProfileUI1State extends State<ProfileUI1> {
  @override
  void initState() {
    // _fillFriends();
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
    // final AppUser user = Provider.of<AppUser>(context);
    // print(user.name);
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
        child: StreamBuilder<AppUser>(
            stream: ProfileManager().getUserFromID(widget.userID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AppUser user = snapshot.data;
                return ProfileList(user: user);
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}
