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
  final AppUser user;
  bool requested;
  ProfileUI1({@required this.user, this.requested});
  ProfileUI1State createState() => ProfileUI1State();
}

class ProfileUI1State extends State<ProfileUI1> {
  
  bool requested;
  
  ProfileUI1State({this.requested});
  
  _initReq(){
    requested = false;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    (requested)??_initReq();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final AppUser currUser = Provider.of<AppUser>(context);
    // print(user.name);
    // String userId = FirebaseAuth.instance.currentUser.uid;
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: ProfileList(
          user: widget.user,
          currUserID: currUser.uid,
          requested: requested,
        ),
      ),
    );
  }
}
