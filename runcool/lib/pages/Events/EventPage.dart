import 'package:flutter/material.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import '../../utils/EventTextTitle.dart';
import '../../utils/EventTextDetails.dart';
import 'joinEventPage.dart';
import './../RuncoolNavBar.dart';
import './../../utils/everythingUtils.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  void joinPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                joinEventPage())); //find out if need to individually create or can use and add on..
  }

  void goHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RuncoolNavBar())); //find out if need to individually create or can use and add on..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Event Name', //need to make this dynamic
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: goHomePage,
          ),
        ),
        body: BackgroundImage(
          child: Container(
              child: Column(children: [
            GoogleMapPlacement(),
            Container(
              height: 450, //changed this to fit pixel 3a..
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: EventTextTitle('Anchorvale Horizon'),
                  ),
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          //mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 20,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  EventTextDetails(
                                      '30 February 2021'), //insert datetoString fn
                                ],
                              ),
                            ),
                            //SizedBox(height: 1),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  EventTextDetails(
                                      '10 am'), //insert timetoString fn
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 20,
                                      color: Colors.lightGreenAccent,
                                    ),
                                    EventTextDetails(
                                        'Meet at Rivervale Mall'), //insert locationn fn
                                  ],
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.speed,
                                      size: 20,
                                      color: Colors.limeAccent,
                                    ),
                                    EventTextDetails(
                                        'veri fast'), //insert speed fn
                                  ],
                                )),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.directions_run_outlined,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    EventTextDetails(
                                        '3.7km'), //insert datetoString fn
                                  ],
                                )),
                            //SizedBox(height: 1),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.build_outlined,
                                      size: 20,
                                      color: Colors.cyan,
                                    ),
                                    EventTextDetails(
                                        'Difficult'), //insert datetoString fn
                                  ],
                                )),
                          ],
                        ))
                      ]),
                  SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: EventTextDetails(
                          'This is a description of the event haha. I love CZ2004'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: EventTextTitle('Organiser'),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: Colors.deepOrangeAccent,
                      ),
                      EventTextDetails('Hi my name is Jeff.')
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: EventTextTitle(
                        'Participants'), //should maybe put row for the 5/8 thing?
                  ),
                  Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      child: EventTextTitle('Join'),
                      onPressed: () => joinPage(),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ])),
        ));
  }
}
