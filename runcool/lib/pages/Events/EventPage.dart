import 'package:flutter/material.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import '../../utils/EventTextDetails.dart';
import './JoinEventPage.dart';
import './../RuncoolNavBar.dart';
import './../../utils/everythingUtils.dart';
import '../../models/Event.dart';

class EventPage extends StatefulWidget {
  final dynamic event;
  EventPage({this.event});

  @override
  _EventPageState createState() => _EventPageState(event);
}

class _EventPageState extends State<EventPage> {
  dynamic event;
  _EventPageState(this.event);

  // List<String> participants = [
  //   'Paula',
  //   'Eugene',
  //   'Sarah',
  //   'Bob',
  //   'Ho',
  //   'RERE',
  //   'BIZ'
  // ];
  List<Widget> participantsWidgets = [];

  void _fillParticipants() {
    setState(() {
      event.participants.forEach((element) {
        participantsWidgets.add(Icon(
          Icons.account_circle_outlined,
          size: 60,
          color: Colors.green,
        ));
      });
    });
  }

  void _workoutsAndSongs(Event event) {
    String s;
    if (event.eventType == 'Gymming') {
      // event.workout.forEach()
    }
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
          "Event",
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
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            GoogleMapPlacement(),
            Container(
              height: 490, //changed this to fit pixel 3a..
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: EventTextTitle(
                          title: event.name ?? "",
                          fontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 20,
                                        color: Colors.blue[100],
                                      ),
                                      EventTextDetails(
                                        (event.startTime != null)
                                            ? '${event.startTime.day}-${event.startTime.month}-${event.startTime.year}'
                                            : "",
                                      ), //insert datetoString fn
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        EventTextDetails(
                                            (event.startTime != null)
                                                ? (event.startTime.hour
                                                        .toString()
                                                        .padLeft(2, '0')) +
                                                    ":" +
                                                    (event.startTime.minute
                                                        .toString()
                                                        .padLeft(2, '0'))
                                                : ""),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      EventTextDetails('To be done'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                            event.difficulty.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    (event.eventType == "Running")
                                        ? Column(children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .directions_run_outlined,
                                                    size: 20,
                                                    color: Colors.amber,
                                                  ),
                                                  EventTextDetails('3.7km'),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.speed,
                                                  size: 20,
                                                  color: Colors.limeAccent,
                                                ),
                                                EventTextDetails('veri fast'),
                                              ],
                                            ),
                                          ])
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: (event.eventType == 'Gymming')
                              ? EventTextTitle(
                                  title: "Workout Routine",
                                  fontSize: 16,
                                )
                              : (event.eventType == 'Zumba')
                                  ? EventTextTitle(
                                      title: "Songs",
                                      fontSize: 16,
                                    )
                                  : Container()),
                      // Fill in workout/song exercises

                      // Description
                      Align(
                          alignment: Alignment.topLeft,
                          child: EventTextTitle(
                            title: "Description",
                            fontSize: 16,
                          )),
                      Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: EventTextDetails((event.description == '')
                              ? "-No decription from creator-"
                              : event.description),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: EventTextTitle(
                          title: 'Organiser',
                          fontSize: 24,
                        ),
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
                          title: 'Participants',
                          fontSize: 24,
                        ), //should maybe put row for the 5/8 thing?
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
                        child: ButtonType1(onPress: joinPage, text: "Join"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
