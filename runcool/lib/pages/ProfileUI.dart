import 'package:flutter/material.dart';

class ProfileUI extends StatefulWidget {
  @override
  ProfileUIState createState() => ProfileUIState();
}

class ProfileUIState extends State<ProfileUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Text('Here is the profile.'),
      ),
    );
  }
}