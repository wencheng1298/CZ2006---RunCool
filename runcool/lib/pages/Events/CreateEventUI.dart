import 'package:flutter/material.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'ChooseEventUI.dart';
import 'EventPage.dart';
import '../../utils/backgroundImage.dart';

class CreateEventUI extends StatefulWidget {
  @override
  CreateEventUIState createState() => CreateEventUIState();
}

class CreateEventUIState extends State<CreateEventUI> {
  List<Widget> pastEventsWidgets = [];
  List<String> events = ['Event 1', 'Event 2', '3'];

  void _fillPastEventsList() {
    setState(() {
      // Replace this by checking event dates
      events.forEach((element) {
        pastEventsWidgets.add(EventCard(
          fn: goEventPage,
        ));
      });
    });
  }

  @override
  void initState() {
    _fillPastEventsList();
    super.initState();
    // print(Authentication().getCurrUser().email);
  }

  void goEventPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EventPage())); //find out if need to individually create or can use and add on..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Event',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
      ),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20, left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose from past activities',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  children: pastEventsWidgets,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          label: Text('Create New'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseEventUI()));
          },
          elevation: 0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
