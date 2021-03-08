import 'package:flutter/material.dart';

class EventCreatedSuccessUI extends StatefulWidget {
  @override
  EventCreatedSuccessUIState createState() => EventCreatedSuccessUIState();
}

class EventCreatedSuccessUIState extends State<EventCreatedSuccessUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

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
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: _background,
            child: Column(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: Text(
                    "Your Event: The Nice Tour - has been created successfully!",
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
                    onPressed: null,
                    style: TextButton.styleFrom(
                        backgroundColor: _turqoise,
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
              ],
            )));
  }
}
