import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:runcool/firebase/ProfileManager.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import '../../utils/EventTextDetails.dart';
import './JoinEventPage.dart';
import './../RuncoolNavBar.dart';
import './../../utils/everythingUtils.dart';
import '../../models/Event.dart';
import './../profile/FriendCard.dart';
import 'package:runcool/models/User.dart';
import 'package:provider/provider.dart';
import './../../firebase/EventManagers/EventManager.dart';

class EventPage extends StatefulWidget {
  // final dynamic event;
  final String eventID;
  EventPage({@required this.eventID});

  @override
  _EventPageState createState() => _EventPageState(eventID);
}

class _EventPageState extends State<EventPage> {
  String eventID;
  _EventPageState(this.eventID);
  dynamic event;
  StreamSubscription eventStream;

  List<Widget> participantsWidgets = [];
  String viewStatus;

  void _initStatus() {
    final AppUser user = Provider.of<AppUser>(context, listen: false);

    EventManager().getEventData(eventID).listen((eve) {
      setState(() {
        event = eve;
        if (event != null) {
          if (event.creator == user.uid) {
            viewStatus = 'creator';
          } else if (event.participants.contains(user.uid)) {
            viewStatus = 'participant';
          } else {
            viewStatus = 'viewer';
          }
        }
      });
    });

    print(viewStatus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
    final AppUser user = Provider.of<AppUser>(context, listen: false);
    // setState(() {
    // viewStatus = 'participant';
    EventManager().joinEvent(event.eventID, user.uid);
    // });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                JoinEventPage())); //find out if need to individually create or can use and add on..
  }

  void quitPage() {
    final AppUser user = Provider.of<AppUser>(context, listen: false);

    // setState(() {

    EventManager().quitEvent(event.eventID, user.uid);
    // viewStatus = 'viewer';
    // });
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
    _initStatus();
    // _fillParticipants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return event == null && viewStatus != null
        ? Loading()
        : Scaffold(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              EventTextDetails((event
                                                          .startTime !=
                                                      null)
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
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .directions_run_outlined,
                                                          size: 20,
                                                          color: Colors.amber,
                                                        ),
                                                        EventTextDetails(
                                                            '3.7km'),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.speed,
                                                        size: 20,
                                                        color:
                                                            Colors.limeAccent,
                                                      ),
                                                      EventTextDetails(
                                                          'veri fast'),
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
                                child: EventTextDetails(
                                    (event.description == '')
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
                              child: StreamBuilder<AppUser>(
                                  stream: AppUser.getUserFromID(event.creator),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Loading();
                                    } else {
                                      AppUser creator = snapshot.data;
                                      return Row(
                                        children: [
                                          creator.image != ''
                                              ? CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      creator.image),
                                                )
                                              : Icon(
                                                  Icons.account_circle_outlined,
                                                  size: 50,
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              EventTextDetails(
                                                  creator.name == ''
                                                      ? "name"
                                                      : creator.name),
                                              Container(
                                                width: 300,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text(
                                                  creator.bio,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: EventTextTitle(
                                title: 'Participants',
                                fontSize: 24,
                              ), //should maybe put row for the 5/8 thing?
                            ),
                            (event.participants.isEmpty)
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ProfileCardStream(
                                        friends: event.participants),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: (viewStatus == 'creator')
                                  ? ButtonType1(
                                      onPress: () {},
                                      text: "Delete Event",
                                    )
                                  : (viewStatus == 'participant')
                                      ? ButtonType1(
                                          onPress: quitPage,
                                          text: "Quit",
                                          colour: Colors.red)
                                      : (event.participants.length <
                                              event.noOfParticipants)
                                          ? ButtonType1(
                                              onPress: joinPage, text: "Join")
                                          : ButtonType1(
                                              onPress: () {},
                                              text: "Event Full",
                                              colour: Colors.grey),
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
