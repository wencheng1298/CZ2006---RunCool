import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class MyActivitiesUI extends StatefulWidget {
  @override
  MyActivitiesUIState createState() => MyActivitiesUIState();
}

class MyActivitiesUIState extends State<MyActivitiesUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'My Activities',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
      ),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 40,
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        EventCard(),
                        EventCard(),
                        EventCard(),
                      ],
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        EventCard(),
                        EventCard(),
                        EventCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
