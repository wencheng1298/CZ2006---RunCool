import 'package:flutter/material.dart';
import 'package:runcool/firebase/Service/auth.dart';
import './../utils/everythingUtils.dart';

class MyActivitiesUI extends StatefulWidget {
  @override
  MyActivitiesUIState createState() => MyActivitiesUIState();
}

class MyActivitiesUIState extends State<MyActivitiesUI> {
  List<Widget> upcomingEventsWidgets = [];
  List<Widget> pastEventsWidgets = [];
  List<String> events = ['Event 1', 'Event 2', 'Event 3'];

  void _fillEventsList() {
    setState(() {
      // Replace this by checking event dates
      events.forEach((element) {
        upcomingEventsWidgets.add(EventCard());
        pastEventsWidgets.add(EventCard());
      });
    });
  }

  @override
  void initState() {
    _fillEventsList();
    super.initState();
    // print(Authentication().getCurrUser().email);
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
          child: Expanded(
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
                        children: upcomingEventsWidgets),
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
                      children: pastEventsWidgets,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
