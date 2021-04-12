import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../models/User.dart';
import './../../utils/everythingUtils.dart';
import './../EventPage.dart';

class UpcomingEventsList extends StatefulWidget {
  @override
  _UpcomingEventsListState createState() => _UpcomingEventsListState();
}

class _UpcomingEventsListState extends State<UpcomingEventsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final List<dynamic> upcomingEvents =
        Provider.of<List<dynamic>>(context) ?? [];
    List<Widget> eventWidget = [];

    void goEventPage(event) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventPage(
                    eventID: event.eventID,
                  )));
    }

    upcomingEvents.forEach((event) {
      if (event.participants.contains(user.uid) || event.creator == user.uid) {
        if (DateTime.now().isBefore(event.startTime)) {
          eventWidget
              .add(EventCard(event: event, fn: () => goEventPage(event)));
        }
      }
    });

    return (eventWidget.isEmpty)
        ? Align(
            alignment: Alignment.topCenter,
            child: Text('Your have no upcoming events',
                style: TextStyle(color: Colors.white)))
        : ListView(
            scrollDirection: Axis.horizontal,
            children: eventWidget,
          );
  }
}
