import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/place.dart';
import 'package:runcool/utils/places_service.dart';
import '../utils/EventTextDetails.dart';
import 'profileDependancies/ProfileUI1.dart';
import 'eventCreateDependancies/JoinEventPage.dart';
import 'NavBar.dart';
import '../utils/everythingUtils.dart';
import '../models/Event.dart';
import 'profileDependancies/FriendCard.dart';
import 'package:runcool/models/User.dart';
import 'package:provider/provider.dart';
import '../controllers/EventManager.dart';
import 'eventDisplayDependancies/inviteFriendList.dart';
import 'eventCreateDependancies/EventDeletedSuccessUI.dart';

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

  List<Widget> participantsWidgets = [];
  String viewStatus;
  String message = '';
  final TextEditingController _controller = TextEditingController();

  StreamSubscription eventStream;

  //GoogleMaps stuff
  Completer<GoogleMapController> _mapController = Completer();
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();
  Set<Circle> circlesSet = {};

  String initialPos, finalPos;
  LatLngBounds latLngBounds;

  BitmapDescriptor nparklocationicon;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  //End of GoogleMaps stuff

  void _initStatus() {
    final AppUser user = Provider.of<AppUser>(context, listen: false);

    eventStream = Event.getEventData(eventID).listen((eve) {
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
          setRoute();
        }
      });
    });

  }

  @override
  void dispose() {
    eventStream.cancel();
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

  _workoutsAndSongsList() {
    String s = '';
    if (event.eventType == 'Gymming') {
      event.workout.forEach((workout) {
        s = s +
            workout['activity'] +
            " x" +
            workout['repetition'].toString() +
            '\n';
      });
    } else  if (event.eventType == 'Zumba'){

      event.danceMusic.forEach((music) {
        s = s + music['songTitle'] + ' by ' + music['songArtist'] + '\n';
      });
    }
    return EventTextDetails(s);
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    getBytesFromAsset('images/nparkscoast-to-coast.png', 64).then((onValue) {
      nparklocationicon =BitmapDescriptor.fromBytes(onValue);

    });
    _initStatus();
    // _fillParticipants();
    updateCamera();


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
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: goHomePage,
              // ),
            ),
            body: BackgroundImage(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  GoogleMapPlacement(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                      //controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));


                    },
                    polylineset: Set.of((polylineSet != null)? Set<Polyline>.of(polylineSet) : []), //set polyline
                    markersset: Set.of((markersSet != null)? Set<Marker>.of(markersSet) : []),
                    circlesset: Set.of((circlesSet != null)? Set<Circle>.of(circlesSet) : []),

                  ),
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
                                      SingleChildScrollView(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                            EventTextDetails(
                                                (event.eventType == "Running"&& initialPos != null && finalPos != null)
                                                    ? ("${initialPos} to ${finalPos}")
                                                    : ("to be done")
                                            ),
                                          ],
                                        ),
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
                                                      EventTextDetails(event.estDistance),
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
                                                    EventTextDetails(event.pace.toString()),
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: _workoutsAndSongsList(),
                          ),
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
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileUI1(user: creator))),
                                      child: Row(
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
                                      ),
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
                              (viewStatus == 'creator' ||
                                      viewStatus ==
                                          'participant') // Change to == when ready
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
                                    onPress: () async {
                                      setState() {
                                        viewStatus = null;
                                      }

                                      await EventManager().deleteEvent(event);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  (EventDeletedSuccessUI())));
                                    },
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

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 20)));
  }

  Future<void> updateCamera() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
  }

  Future<void> setRoute() async {
    //var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    //var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;

    GeoPoint startLoc = event.startLocation;
    LatLng startLatLng = LatLng(startLoc.latitude, startLoc.longitude);
    GeoPoint endLoc = event.endLocation;
    LatLng desLatLng = LatLng(endLoc.latitude, endLoc.longitude);

    //event.endLocation;


    initialPos = await PlacesService.searchCoordinateAddress(startLatLng);
    finalPos = await PlacesService.searchCoordinateAddress(desLatLng);

    //var startLatLng = LatLng(initialPos.geometry.location.lat, initialPos.geometry.location.lng);
    /*print("this is the start");
    print(initialPos.placeId);
    print(startLatLng);
    //var desLatLng = LatLng(finalPos.geometry.location.lat, finalPos.geometry.location.lng);
    print("this is the end");
    print(finalPos.placeId);
    print(endLatLng);

    /*showDialog(
      context: context,
      builder: (BuildContext context) => Loading()
    );*/

    var details = await PlacesService.obtainPlaceDirectionDetails(startLatLng, endLatLng);


    */

    print("this is encoded points: ");
    print(event.encPoints);
    /*setState(() {
      //todo check if this is correct
      GeoPoint  start = GeoPoint(startLatLng.latitude, startLatLng.longitude);
      eventDetails['startLocation'] = start;

      GeoPoint  end = GeoPoint(desLatLng.latitude, desLatLng.longitude);
      eventDetails['endLocation'] = end;

      eventDetails['encPoints'] = details.encodedPoints;

      EstimatedDistance = details.distanceText;
      eventDetails['estDistance'] = EstimatedDistance;


    });*/


    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResult = polylinePoints.decodePolyline(event.encPoints);

    pLineCoordinates.clear();
    if(decodePolyLinePointsResult.isNotEmpty)
    {
      decodePolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));

      });
    }


    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });


    if(startLatLng.latitude > desLatLng.latitude && startLatLng.longitude > desLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: desLatLng, northeast: startLatLng);
    }
    else if (startLatLng.longitude > desLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(startLatLng.latitude, desLatLng.longitude), northeast: LatLng(desLatLng.latitude, startLatLng.longitude));
    }
    else if (startLatLng.latitude > desLatLng.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(desLatLng.latitude, startLatLng.longitude), northeast: LatLng(startLatLng.latitude, desLatLng.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: startLatLng, northeast: desLatLng);
    }

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));


    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: startLatLng.toString(), snippet: "Starting Address"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: desLatLng.toString(), snippet: "Destination Address"),
      position: desLatLng,
      markerId: MarkerId("destId"),
    );

    List<dynamic> waypoint = event.checkpoints;

    LatLng waypoint1 = LatLng(waypoint[0].latitude, waypoint[0].longitude);

    if(waypoint.isNotEmpty) {
      Marker wayptLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(title: waypoint1.toString(), snippet: "Checkpoint"),
        position: waypoint1,
        markerId: MarkerId("wayptId"),

      );
      setState(() {
        markersSet.add(wayptLocMarker);
      });
    }


    setState(() {
      markersSet.add(startLocMarker);
      markersSet.add(destLocMarker);
    });

    Circle startLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: startLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("startId"),
    );

    Circle destLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: desLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.purpleAccent,
      circleId: CircleId("destId"),
    );

    setState(() {
      circlesSet.add(startLocCircle);
      circlesSet.add(destLocCircle);

    });
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
