import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../models/Event.dart';
import './../../utils/everythingUtils.dart';

class EventsForYouList extends StatefulWidget {
  @override
  _EventsForYouListState createState() => _EventsForYouListState();
}

class _EventsForYouListState extends State<EventsForYouList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> eventWidget = [];
    final List<dynamic> eventsForYou =
        Provider.of<List<dynamic>>(context);

    eventsForYou.forEach((element) {
      eventWidget.add(EventCard(event: element));
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: eventWidget,
    );
  }
}
