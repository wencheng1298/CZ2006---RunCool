import 'package:flutter/material.dart';
import 'ChooseEventUI.dart';
import 'EventPage.dart';
import './../utils/backgroundImage.dart';

class CreateEventUI extends StatefulWidget {
  @override
  CreateEventUIState createState() => CreateEventUIState();
}

class CreateEventUIState extends State<CreateEventUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff1f1b24);

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
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
              Container(
                color: Colors.black,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: GestureDetector(
                      //clickable widget
                      onTap: () => goEventPage(), //go to event page...
                      child: const Card(
                        child: Text(
                            'Past Event Card 2' + '\n   Click on me to try   '),
                      ),
                    )),
              ),
            ],
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
