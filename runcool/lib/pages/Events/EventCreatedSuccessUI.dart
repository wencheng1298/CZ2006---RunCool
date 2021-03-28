import 'package:flutter/material.dart';
import './../../utils/everythingUtils.dart';
import 'EventPage.dart';

class EventCreatedSuccessUI extends StatefulWidget {
  final String eventName;
  EventCreatedSuccessUI({this.eventName});

  @override
  EventCreatedSuccessUIState createState() => EventCreatedSuccessUIState();
}

class EventCreatedSuccessUIState extends State<EventCreatedSuccessUI> {
  void viewEvent() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EventPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'SUCCESS',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: Container(),
        ),
        body: BackgroundImage(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(26),
                    child: Text(
                      "Your Event: ${widget.eventName} - has been created successfully!",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: OutlinedButton(
                      child: Text(
                        'See Event Details',
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () => viewEvent(),
                      style: TextButton.styleFrom(
                          backgroundColor: kTurquoise,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              )),
        ));
  }
}
