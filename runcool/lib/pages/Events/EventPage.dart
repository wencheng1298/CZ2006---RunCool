import 'package:flutter/material.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import '../../utils/EventTextTitle.dart';
import '../../utils/EventTextDetails.dart';
import './JoinEventPage.dart';
import './../RuncoolNavBar.dart';
import '../../firebase/EventManagers/EventManager.dart';
import './../../utils/everythingUtils.dart';
import '../../models/Event.dart';

class EventPage extends StatefulWidget {
  final Event event;
  String testID = "eZoBIWxnC1Hc2RVrWumE";
  EventPage({this.event});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<String> participants = ['Paula', 'Eugene', 'Sarah','Bob', 'Ho', 'RERE', 'BIZ'];
  List<Widget> participantsWidgets = [];

  void _fillParticipants() {
    setState(() {
      participants.forEach((element) {
        participantsWidgets.add(Icon(
          Icons.account_circle_outlined,
          size: 60,
          color: Colors.green,
        ));
      });
    });
  }

  void joinPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                JoinEventPage())); //find out if need to individually create or can use and add on..
  }

  void goHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RuncoolNavBar())); //find out if need to individually create or can use and add on..
  }

  @override
  void initState() {
    _fillParticipants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "", //need to make this dynamic
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: goHomePage,
          ),
        ),
        body: BackgroundImage(
          child: StreamBuilder<Event>(
              stream: EventManager().getEventData(widget.testID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Event event = snapshot.data;
                  return (Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      GoogleMapPlacement(),
                      Container(
                        height: 450, //changed this to fit pixel 3a..
                        child: ListView(
                          padding: EdgeInsets.all(8),
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: EventTextTitle(event.name ?? ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
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
                                                color: Colors.blue[100],
                                              ),
                                              EventTextDetails(
                                                  '30 February 2021'), //insert datetoString fn
                                            ],
                                          ),
                                        ),
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
                                                  color: Colors.red,
                                                ),
                                                EventTextDetails(
                                                    'Rivervale Mall'), //insert locationn fn
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
                                                  color: Colors.amber,
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
                                                  Icons.bolt,
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
                            ),
                            SizedBox(
                              height: 100,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: EventTextDetails(
                                    'This is a description of the event haha.This is a description of the event haha.This is a description of the event haha.This is a description of the event haha. I love CZ2004'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: EventTextTitle('Organiser'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_outlined,
                                    size: 50,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  EventTextDetails('Hi my name is Jeff.')
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: EventTextTitle(
                                  'Participants'), //should maybe put row for the 5/8 thing?
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 60,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: participantsWidgets,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  ButtonType1(onPress: joinPage, text: "Join"),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ));
                } else {
                  return Loading();
                }
              }),
        ));
  }
}
