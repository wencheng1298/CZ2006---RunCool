import 'package:flutter/material.dart';

class NotificationUI extends StatefulWidget {
  @override
  NotificationUIState createState() => NotificationUIState();
}

class NotificationUIState extends State<NotificationUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Text('Here are notifications. wc chill plz'),
      ),
    );
  }
}
