import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../models/Event.dart';
import './../../utils/everythingUtils.dart';
import './../Events/EventPage.dart';
import './../../models/User.dart';

class PastEventsList extends StatefulWidget {
  @override
  _PastEventsListState createState() => _PastEventsListState();
}

class _PastEventsListState extends State<PastEventsList> {
  void goEventPage(event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventPage(
                  eventID: event.eventID,
                )));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> eventWidget = [];
    final List<dynamic> pastEventsList =
        Provider.of<List<dynamic>>(context) ?? [];
    final user = Provider.of<AppUser>(context);

    pastEventsList.forEach((element) {
      if (element.participants.contains(user.uid) &&
          element.startTime.isBefore(DateTime.now())) {
        eventWidget
            .add(EventCard(event: element, fn: () => goEventPage(element)));
      }
    });

    return (eventWidget.isEmpty)
        ? Align(
            alignment: Alignment.topCenter,
            child: Text('You have not attended any events',
                style: TextStyle(color: Colors.white)))
        : ListView(
            scrollDirection: Axis.horizontal,
            children: eventWidget,
          );
  }
}
