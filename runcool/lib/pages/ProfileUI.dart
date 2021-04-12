import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';
import 'profileDependancies/SettingsUI.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:runcool/pages/profileDependancies/profileList.dart';

class ProfileUI extends StatefulWidget {
  @override
  ProfileUIState createState() => ProfileUIState();
}

class ProfileUIState extends State<ProfileUI> {
  final _auth = FirebaseAuth.instance;

  double fontMainSize = 15;
  void settings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsUI()));
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
              // actions: <Widget>[
              //   Padding(
              //     padding: EdgeInsets.only(right: 20.0),
              //     child: IconButton(
              //         icon: Icon(Icons.edit), onPressed: () => edit()),
              //   ),
              // ],
            ),
            body: BackgroundImage(
              child: ProfileList(
                user: user,
                currUserID: user.uid,
              ),
            ),
          );
  }
}
