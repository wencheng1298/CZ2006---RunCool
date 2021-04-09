import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../models/User.dart';
import './../../utils/everythingUtils.dart';

class FriendEventsList extends StatefulWidget {
  @override
  _FriendEventsListState createState() => _FriendEventsListState();
}

class _FriendEventsListState extends State<FriendEventsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final List<dynamic> eventsForYou = Provider.of<List<dynamic>>(context);
    List<Widget> eventWidget = [];

    eventsForYou.forEach((event) {
      if (event.participants.any((person) => user.friends.contains(person))) {
        eventWidget.add(EventCard(event: event));
      }
    });

    return (eventWidget.isEmpty)
        ? Align(
            alignment: Alignment.topCenter,
            child: Text('Your friends have not joined any events / You have no friends',
                style: TextStyle(color: Colors.white)))
        : ListView(
            scrollDirection: Axis.horizontal,
            children: eventWidget,
          );
  }
}
