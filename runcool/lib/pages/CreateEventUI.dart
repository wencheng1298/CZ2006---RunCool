import 'package:flutter/material.dart';

class CreateEventUI extends StatefulWidget {
  @override
  CreateEventUIState createState() => CreateEventUIState();
}

class CreateEventUIState extends State<CreateEventUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'New Event',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Text('Create your events here.'),
      ),
    );
  }
}
