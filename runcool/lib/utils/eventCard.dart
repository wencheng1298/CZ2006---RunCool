import 'package:flutter/material.dart';
import 'constants.dart';
import './GoogleMapPlacement.dart';

class EventCard extends StatelessWidget {
  final Function fn;
  final dynamic event;

  EventCard({this.event, this.fn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.fn,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 340,
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800],
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: kBackgroundColor,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (event.startTime != null)
                        ? '${event.startTime.day}/${event.startTime.month}/${event.startTime.year}'
                        : '', //date
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    (event.eventType != null)
                        ? event.eventType.toString()
                        : '', //Event Type
                    style: TextStyle(color: kTurquoise),
                  ),
                  Text(
                    (event.startTime != null)
                        ? (event.startTime.hour.toString().padLeft(2, '0')) +
                            ":" +
                            (event.startTime.minute.toString().padLeft(2, '0'))
                        : "", // Time
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Text(
              (event.name != '') ? event.name : '',
              style: TextStyle(fontSize: 24, color: kTurquoise),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: GoogleMapPlacement(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      (event.eventType == 'Running')
                          ? event.estDistance + "km"
                          : '', // Time
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  (event.difficulty == 'Difficult')
                  ? Row(children:[
                    Icon(Icons.bolt, size: 20, color: kTurquoise),
                    Icon(Icons.bolt, size: 20, color: kTurquoise),
                    Icon(Icons.bolt, size: 20, color: kTurquoise)
                    ])
                  : (event.difficulty == 'Medium') 
                    ? Row(children: [
                      Icon(Icons.bolt, size: 20, color: kTurquoise),
                      Icon(Icons.bolt, size: 20, color: kTurquoise),
                      ])
                    :Icon(Icons.bolt, size: 20, color: kTurquoise),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  (event.noOfParticipants != null)
                      ? event.noOfParticipants.toString() + " pax"
                      : '3 pax',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "To fill in creator name",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.account_circle, size: 20, color: kTurquoise)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
