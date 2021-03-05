import 'package:flutter/material.dart';

class CreateRunningUI1 extends StatefulWidget {
  @override
  _CreateRunningUI1State createState() => _CreateRunningUI1State();
}

class _CreateRunningUI1State extends State<CreateRunningUI1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Route',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Text("Here is running UI 1"),
      ),
    );
  }
}
