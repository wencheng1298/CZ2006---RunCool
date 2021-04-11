import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
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
import './../eventDisplayDependancies/inviteFriendList.dart';

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
  String message = '';
  final TextEditingController _controller = TextEditingController();

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
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
            builder: (context) => JoinEventPage(
                joinQuit: "joined",
                event:
                    event))); //find out if need to individually create or can use and add on..
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
            builder: (context) => JoinEventPage(
                  joinQuit: "quit",
                  event: event,
                ))); //find out if need to individually create or can use and add on..
  }

  void goHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RuncoolNavBar())); //find out if need to individually create or can use and add on..
  }

  addFriends(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text(
              "Choose from friend list",
              style: TextStyle(color: kTurquoise),
            ),
            content: InviteFriendList(event: event),
            actions: [
              MaterialButton(
                child: Text('Ok'),
                color: kTurquoise,
                onPressed: () {Navigator.of(context).pop();},
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _initStatus();
    // _fillParticipants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppUser currUser = Provider.of<AppUser>(context);
    return (event == null || viewStatus == null)
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
                        child: Column(children: [
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
                                                backgroundImage:
                                                    NetworkImage(creator.image),
                                              )
                                            : Icon(
                                                Icons.account_circle_outlined,
                                                size: 50,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            EventTextDetails(creator.name == ''
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: EventTextTitle(
                                  title:
                                      'Participants - ${event.participants.length}/${event.noOfParticipants}',
                                  fontSize: 20,
                                ),
                              ),
                              (viewStatus !=
                                      'creator') // Change to == when ready
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.add_sharp,
                                        size: 20,
                                        color: kTurquoise,
                                      ),
                                      onPressed: () {
                                        addFriends(context);
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                          (event.participants.isEmpty)
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ProfileCardStream(
                                      friends: event.participants),
                                ),
                          (viewStatus == 'creator' ||
                                  viewStatus == 'participant')
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: EventTextTitle(
                                          title: 'Announcements',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  height: 200,
                                                  color: Colors.white30,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                    child: ListView(
                                                        reverse: true,
                                                        children: EventManager()
                                                            .getAnnouncements(event
                                                                .announcements)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Replace below container with text box
                                      Row(children: [
                                        Expanded(
                                          child: Container(
                                            height: 32,
                                            child: DescriptionTextField(
                                              text: message,
                                              controller: _controller,
                                              onChange: (value) {
                                                setState(() {
                                                  message = value;
                                                });
                                              },
                                              color: Colors.white12,
                                              minLine: 1,
                                            ),
                                          ),
                                        ),
                                        MinuteButton(
                                            onPress: () async {
                                              if (message != '') {
                                                await EventManager()
                                                    .addAnnouncement(
                                                        message: message,
                                                        announcer:
                                                            currUser.name,
                                                        eventID: eventID,
                                                        announcerID:
                                                            currUser.uid);
                                              }
                                              print(message);
                                              setState(() {
                                                message = '';
                                                _controller.clear();
                                              });
                                            },
                                            text: "Post")
                                      ]),
                                    ],
                                  ),
                                )
                              : Container(),
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
                        ]),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
  }
}

class Announcement extends StatelessWidget {
  final Map announcement;
  Announcement(this.announcement);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          announcement['announcer'],
          style: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            elevation: 5,
            color: kTurquoise,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                announcement['message'],
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ),
        Text(
            DateFormat.yMd()
                .add_jm()
                .format(
                    announcement['timeStamp'].toDate().add(Duration(hours: 8)))
                .toString(),
            style: TextStyle(fontSize: 12)),
        SizedBox(height: 5)
      ],
    );
  }
}
