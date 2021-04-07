import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class MyActivitiesUI extends StatefulWidget {
  @override
  MyActivitiesUIState createState() => MyActivitiesUIState();
}

class MyActivitiesUIState extends State<MyActivitiesUI> {
  Container EventCards(String heading, String subHeading) {
    return Container(
      width: 300,
      child: Card(
        child: Wrap(
          children: <Widget>[
            ListTile(
              title: Text(heading),
              subtitle: Text(subHeading),
            ),
          ],
        ),
      ),
    );
  }

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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        EventCards("Upcoming events card", "Event 1"),
                        EventCards("Upcoming events card", "Event 2"),
                        EventCards("Upcoming events card", "Event 3"),
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
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        EventCards("Past events card", "Event 1"),
                        EventCards("Past events card", "Event 2"),
                        EventCards("Past events card", "Event 3"),
                      ],
                    ),
                  ),
                ),
                /*Container(
                  color: Colors.black,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: const Card(
                      child: Text('Past events card'),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
