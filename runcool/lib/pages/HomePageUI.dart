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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                print("Menu clicked"); //should change to make it pop up
              },
              color: Colors.white54),
        ],
      ),
      body: SingleChildScrollView( //let the app be scrollable
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'EVENTS FOR YOU',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: const Card(
                    child: Text('Event for you card'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'See what your friends are up to',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: const Card(
                    child: Text('Friends up to card'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
