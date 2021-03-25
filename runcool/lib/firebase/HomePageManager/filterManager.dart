import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final eventsRef = FirebaseFirestore.instance.collection('events');

class FilterManager {
  String eventType;
  String startTime;
  String location;

  FilterManager({this.eventType, this.startTime, this.location});

/*   getEvents() {
    eventsRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc["startTime"]);
        print(doc["eventType"]);
        print(doc["location"]);
      });
    });
} */
}

/* class FilterManager extends StatefulWidget {
  @override
  _FilterManagerState createState() => _FilterManagerState();
}

class _FilterManagerState extends State<FilterManager> {
  @override
  void initState() {
    getEvents();
    super.initState();
  }

  getEvents() {
    eventsRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc["startTime"]);
        print(doc["eventType"]);
        print(doc["location"]);
      });
    });

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Notifications',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Container(
            height: 200,
            width: 100,
            color: Colors.yellow,
          ),
        ),
      );
    }
  }
} */
