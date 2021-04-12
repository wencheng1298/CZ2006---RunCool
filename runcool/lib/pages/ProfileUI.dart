import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';
import './SettingsUI/SettingsUI.dart';
import './SettingsUI/EditProfileUI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/models/User.dart';
import 'package:provider/provider.dart';
import 'profile/profileList.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    // return FutureBuilder<DocumentSnapshot>(
    //   future: users.doc(documentId).get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
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
  void settings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsUI()));
  }

  void edit() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfileUI()));
  }

  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<AppUser>(context);

    return (user == null)
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => settings(),
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
                        icon: Icon(Icons.edit), onPressed: () => edit()),
                  ),

                  //leading: Container(),
                ]),
            body: BackgroundImage(
              child: ProfileList(
                user: user,
                currUserID: user.uid,
              ),
            ),
          );
  }
}
