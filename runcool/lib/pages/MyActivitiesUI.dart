import 'package:flutter/material.dart';

class MyActivitiesUI extends StatefulWidget {
  @override
  MyActivitiesUIState createState() => MyActivitiesUIState();
}

class MyActivitiesUIState extends State<MyActivitiesUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'My Activities',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Text('Here are the upcoming activities.'),
      ),
    );
  }
}
