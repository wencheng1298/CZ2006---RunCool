import 'package:flutter/material.dart';
import 'constants.dart';
import './GoogleMapPlacement.dart';

class EventCard extends StatelessWidget {
  final Function fn;

  EventCard({this.fn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.fn,
      child: Container(
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
                    "30/2/20", //date
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Run", //Event Type
                    style: TextStyle(color: kTurquoise),
                  ),
                  Text(
                    "10am", // Time
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Text(
              "Anchorvale Horizon",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "3.7km", // Time
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.bolt, size: 20, color: kTurquoise)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "8 pax",
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
                    "Chakra ABC",
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
