import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../EventCreatedSuccessUI.dart';

import '../../../utils/everythingUtils.dart';
import '../../../controllers/EventManager.dart';

import './../../../models/Event.dart';

enum EventPrivy { public, friends_only }

class CreateGymAndZumbaUI2 extends StatefulWidget {
  final Map eventDetails;
  CreateGymAndZumbaUI2({this.eventDetails});

  @override
  _CreateGymAndZumbaUI2State createState() =>
      _CreateGymAndZumbaUI2State(eventDetails);
}

class _CreateGymAndZumbaUI2State extends State<CreateGymAndZumbaUI2>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();

  Map eventDetails;
  _CreateGymAndZumbaUI2State(this.eventDetails);

  //googleMapstuff
  Completer<GoogleMapController> _mapController = Completer();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();
  Set<Circle> circlesSet = {};

  String locationPos;

  @override
  void initState() {
    // TODO: implement initState
    setMarkers().then((_) {
      _goToPlace(eventDetails['location']);
    });
    super.initState();
  }

  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];
  bool timeError = false;
  bool dateError = false;

  void createEvent(Map eventDetails) async {
    Event event = await EventManager().createEvent(eventDetails);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventCreatedSuccessUI(event: event),
      ),
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
      body: Form(
        key: _formkey,
        child: BackgroundImage(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GoogleMapPlacement(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  polylineset: Set.of((polylineSet != null)
                      ? Set<Polyline>.of(polylineSet)
                      : []), //set polyline
                  markersset: Set.of(
                      (markersSet != null) ? Set<Marker>.of(markersSet) : []),
                  circlesset: Set.of(
                      (circlesSet != null) ? Set<Circle>.of(circlesSet) : []),
                  // eventType: "running",
                ),
                SizedBox(height: 10),
                Container(
                  height: 470,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Date of the session'),
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
                        child: InputFieldTextTitles('Event Start Time'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
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
                                eventDetails['startTime'] = new DateTime(
                                    year, month, day, hour, minute);
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: (eventDetails['eventType'] == "Gymming")
                              ? InputFieldTextTitles(
                                  'Enter the name of your routine')
                              : InputFieldTextTitles(
                                  'Enter the name of your dance event')),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'eg: Happy Hoo Hoo',
                          onChange: (val) {
                            try {
                              eventDetails['name'] = val;
                            } catch (error) {
                              eventDetails['duration'] = null;
                            }
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
                        child:
                            InputFieldTextTitles('Duration of Event (minutes)'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: InputTextFormFill(
                          // validator:(value)=> value.isEmpty?'Enter an email' :null,
                          obscure: false,
                          text: 'minimum: 30',
                          onChange: (val) {
                            try {
                              val = double.parse(val);
                              eventDetails['duration'] = val;
                            } catch (error) {
                              eventDetails['duration'] = 0;
                            }
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter a duration';
                            }
                            val = double.parse(val);
                            if (val < 30) {
                              return 'Duration must be >30';
                            }

                            return null;
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
                            val = int.parse(val);
                            if (val < 1 || val > 8) {
                              return "There must be between 1-8 participants";
                            }
                            return null;
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

                      // Padding(
                      //   padding: EdgeInsets.only(left: 23, top: 4),
                      //   child: Text(
                      //     (difficultyError) ? 'Choose a difficulty' : '',
                      //     style: TextStyle(
                      //       color: Colors.redAccent,
                      //     ),
                      //   ),
                      // ),
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
                            if (_formkey.currentState.validate())
                              {
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

  Future<void> _goToPlace(GeoPoint position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
  }

  Future<void> setMarkers() async {
    GeoPoint locationGeo = eventDetails['location'];
    LatLng startLatLng = LatLng(locationGeo.latitude, locationGeo.longitude);

    locationPos = await PlacesService.searchCoordinateAddress(startLatLng);

    markersSet.clear();
    Marker locationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: locationPos, snippet: "Selected Location"),
      position: startLatLng,
      markerId: MarkerId("${locationPos}Id"),
    );

    setState(() {
      markersSet.add(locationMarker);
    });

    Circle locationCircle = Circle(
      fillColor: Colors.blueAccent,
      center: startLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("${locationPos}Id"),
    );

    setState(() {
      circlesSet.add(locationCircle);
    });
  }
}
