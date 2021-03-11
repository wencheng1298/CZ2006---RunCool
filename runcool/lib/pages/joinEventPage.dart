import 'package:flutter/material.dart';
import '../widgets/EventTextTitle.dart';
import '../widgets/EventTextDetails.dart';

class joinEventPage extends StatefulWidget {
  @override
  joinEventPageState createState() => joinEventPageState();
}

class joinEventPageState extends State<joinEventPage> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Event Name', //need to make this dynamic
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: _background,
        child: Column(children: [
          Text(
            'You have successfully joined: ',
            style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.justify,
          ),
          EventTextTitle('Event Name'),
          Align(
            alignment: Alignment.bottomCenter, //er not at the bottom.
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Event Page'),
            ),
          )
        ]),
      ),
    );
  }
}
