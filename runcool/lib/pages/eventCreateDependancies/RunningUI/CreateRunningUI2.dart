import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './../EventCreatedSuccessUI.dart';

import './../../../utils/everythingUtils.dart';
import '../../../controllers/EventManager.dart';
import './../../../models/Event.dart';

enum EventPrivy { public, friends_only }

class CreateRunningUI2 extends StatefulWidget {
  final Map eventDetails;
  CreateRunningUI2({this.eventDetails});

  @override
  _CreateRunningUI2State createState() => _CreateRunningUI2State(eventDetails);
}

class _CreateRunningUI2State extends State<CreateRunningUI2>
    with SingleTickerProviderStateMixin {
  EventPrivy openTo;

  Map eventDetails;
  _CreateRunningUI2State(this.eventDetails);

  //googlemap stuff
  Completer<GoogleMapController> _mapController = Completer();

  List<LatLng> pLineCoordinates = [];

  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();

  Set<Circle> circlesSet = {};

  String initialPos, finalPos;

  LatLngBounds latLngBounds;

  BitmapDescriptor nparklocationicon;
  @override
  void initState() {
    // TODO: implement initState
    setRoute();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>(); // VALIDATE

  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];
  bool timeError = false;
  bool dateError = false;

  void createEvent(Map eventDetails) async {
    Event event = await EventManager().createEvent(eventDetails);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EventCreatedSuccessUI(event: event)),
    );
  }

  _checkDateAndTimeError() {
    setState(() {
      if (eventDetails['startTime'] == null) {
        timeError = true;
        dateError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Create ${widget.eventDetails['eventType']} UI 2',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GoogleMapPlacement(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                    //controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
                  },
                  polylineset: Set.of((polylineSet != null)
                      ? Set<Polyline>.of(polylineSet)
                      : []), //set polyline
                  markersset: Set.of(
                      (markersSet != null) ? Set<Marker>.of(markersSet) : []),
                  circlesset: Set.of(
                      (circlesSet != null) ? Set<Circle>.of(circlesSet) : []),
                ),
                SizedBox(height: 10),
                Container(
                  height: 470,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Date of the run'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: DatePickerWidget(
                          date: eventDetails['startTime'],
                          updateDate: (year, month, day) {
                            setState(() {
                              int startHour = 0, startMinute = 0;
                              if (eventDetails.containsKey('startTime')) {
                                startHour = eventDetails['startTime'].hour;
                                startMinute = eventDetails['startTime'].minute;
                              }
                              eventDetails['startTime'] = new DateTime(
                                  year, month, day, startHour, startMinute);
                              dateError = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          (dateError) ? 'Select a date' : '',
                          style:
                              TextStyle(color: Colors.redAccent, height: 0.6),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Select Start Time'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TimePickerWidget(
                          time: eventDetails.containsKey('startTime')
                              ? TimeOfDay(
                                  hour: eventDetails['startTime'].hour,
                                  minute: eventDetails['startTime'].minute)
                              : null,
                          updateTime: (hour, minute) {
                            int year = 0, month = 0, day = 0;
                            setState(() {
                              if (eventDetails.containsKey('startTime')) {
                                year = eventDetails['startTime'].year;
                                month = eventDetails['startTime'].month;
                                day = eventDetails['startTime'].day;
                              }
                              eventDetails['startTime'] =
                                  new DateTime(year, month, day, hour, minute);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter the name of your route'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'Eg: Happy Hoo Hoo',
                          onChange: (val) {
                            eventDetails['name'] = val;
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter a name';
                            }
                            if (val.length < 8) {
                              return 'Name must have at least 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter the pace of run (km/h)'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'Eg: 5',
                          onChange: (val) {
                            eventDetails['pace'] = double.parse(val);
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter the pace';
                            }
                            try {
                              val = double.parse(val);
                              return null;
                            } catch (error) {
                              return "Enter a numeric value";
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter number of participants'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'minimum: 1, maximum: 8',
                          onChange: (val) {
                            try {
                              val = int.parse(val);
                              eventDetails['noOfParticipants'] = val;
                            } catch (error) {
                              // Need find out how to catch and show error
                              eventDetails['noOfParticipants'] = 0;
                            }
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter number of participants';
                            }
                            try {
                              val = int.parse(val);
                              if (val < 1 || val > 8) {
                                return "There must be between 1-8 participants";
                              }
                              return null;
                            } catch (error) {
                              return 'Must be a number';
                            }

                            //return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Difficulty'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: DropdownFormFill(
                          value: eventDetails['difficulty'],
                          onChange: (newChoice) {
                            setState(() {
                              eventDetails['difficulty'] = newChoice;
                            });
                          },
                          items: difficultyLevels,
                          text: "--None--",
                          validate: (val) =>
                              val == null ? 'Choose your difficulty' : null,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Description'),
                      ),
                      DescriptionTextField(
                        onChange: (val) {
                          eventDetails['description'] = val;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: 80,
                        child: TinyButton(
                          onPress: () => {
                            _checkDateAndTimeError(),
                            if (_formKey.currentState.validate())
                              {
                                print("this works"),
                                createEvent(eventDetails),
                              }
                          },
                          text: "Create",
                          colour: kTurquoise,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setRoute() async {
    //var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    //var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;

    GeoPoint startLoc = eventDetails['startLocation'];
    LatLng startLatLng = LatLng(startLoc.latitude, startLoc.longitude);
    GeoPoint endLoc = eventDetails['endLocation'];
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
    print(eventDetails['encPoints']);
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
    List<PointLatLng> decodePolyLinePointsResult =
        polylinePoints.decodePolyline(eventDetails['encPoints']);

    pLineCoordinates.clear();
    if (decodePolyLinePointsResult.isNotEmpty) {
      decodePolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
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

    if (startLatLng.latitude > desLatLng.latitude &&
        startLatLng.longitude > desLatLng.longitude) {
      latLngBounds = LatLngBounds(southwest: desLatLng, northeast: startLatLng);
    } else if (startLatLng.longitude > desLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(startLatLng.latitude, desLatLng.longitude),
          northeast: LatLng(desLatLng.latitude, startLatLng.longitude));
    } else if (startLatLng.latitude > desLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(desLatLng.latitude, startLatLng.longitude),
          northeast: LatLng(startLatLng.latitude, desLatLng.longitude));
    } else {
      latLngBounds = LatLngBounds(southwest: startLatLng, northeast: desLatLng);
    }

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow:
          InfoWindow(title: initialPos.toString(), snippet: "Starting Address"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
          title: finalPos.toString(), snippet: "Destination Address"),
      position: desLatLng,
      markerId: MarkerId("destId"),
    );

    List<dynamic> waypoint = eventDetails['checkpoints'];

    if (waypoint.isNotEmpty) {
      LatLng waypoint1 = LatLng(waypoint[0].latitude, waypoint[0].longitude);

      Marker wayptLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow:
            InfoWindow(title: waypoint1.toString(), snippet: "Checkpoint"),
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
