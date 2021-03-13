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
      body: SingleChildScrollView( 
        child: Container(
          color: _background,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'UPCOMING EVENTS',
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
                    child: Text('Upcoming events card'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'PAST EVENTS',
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
                    child: Text('Past events card'),
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
