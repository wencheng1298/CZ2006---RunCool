import 'package:flutter/material.dart';

import './../widgets/navigationBar.dart';

class HomePageUI extends StatefulWidget {
  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Here is the home page',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
