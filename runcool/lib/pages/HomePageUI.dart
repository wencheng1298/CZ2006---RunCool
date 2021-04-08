import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:runcool/pages/FilterUI/SelectItemsFIlterUI.dart';
import '../firebase/authenticationManager.dart';
import './../firebase/EventManagers/EventManager.dart';
import 'package:provider/provider.dart';
import 'package:runcool/firebase/Service/database.dart';
import './../utils/everythingUtils.dart';

class HomePageUI extends StatefulWidget {
  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  List<Widget> eventsForYouWidgets = [];
  List<Widget> friendEventsWidgets = [];
  List<String> events = ['Event 1', 'Event 2'];

  void _fillEventsList() {
    setState(() {
      events.forEach((element) {
        eventsForYouWidgets.add(EventCard());

        friendEventsWidgets
            .add(EventCard()); //Replace this to check if friend is in event
      });
    });
  }

  @override
  void initState() {
    _fillEventsList();
    super.initState();
    // print(Authentication().getCurrUser().email);
  }

  void FilterItem() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectItemsFIlterUI()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: EventManager().eventsSnapshots,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: Container(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => FilterItem(),
            )
          ],
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
                      'EVENTS FOR YOU',
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
                        children: eventsForYouWidgets,
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 340,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: friendEventsWidgets,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
