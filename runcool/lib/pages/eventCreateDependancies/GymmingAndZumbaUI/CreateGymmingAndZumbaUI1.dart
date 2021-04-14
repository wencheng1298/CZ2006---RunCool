import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runcool/utils/places_service.dart';
import 'package:runcool/utils/searchScreen.dart';
import '../../../utils/everythingUtils.dart';
import 'package:provider/provider.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/utils/datagovapi/facilities.dart';
import 'package:runcool/utils/datagovapi/features.dart';

import 'CreateGymAndZumbaUI2.dart';

class CreateGymmingAndZumbaUI1 extends StatefulWidget {
  final Map eventDetails;
  CreateGymmingAndZumbaUI1({this.eventDetails});

  @override
  _CreateGymmingAndZumbaUI1State createState() =>
      _CreateGymmingAndZumbaUI1State(eventDetails);
}

class _CreateGymmingAndZumbaUI1State extends State<CreateGymmingAndZumbaUI1> {
  Map eventDetails;
  _CreateGymmingAndZumbaUI1State(this.eventDetails);
  List<Widget> workoutandSongWidgets = [];
  final _formKey = GlobalKey<FormState>(); // VALIDATE
  bool workoutEmptyError = false;

  //googleMapstuff
  Completer<GoogleMapController> _mapController = Completer();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();
  Set<Circle> circlesSet = {};

  String locationPos;

  List<Facilities> facilcall;
  LatLng position;
  List<LatLng> positionList = [];


  void _initVariables() {
    (eventDetails['eventType'] == 'Gymming')
        ? eventDetails["workout"] = []
        : eventDetails['danceMusic'] = [];

    eventDetails["participants"] = [];
    eventDetails["notifications"] = [];
  }

  void _fillWorkoutandSongWidgets() {
    setState(() {
      workoutandSongWidgets = [];
      if (eventDetails['eventType'] == 'Gymming') {
        eventDetails['workout'].forEach((workout) {
          String text =
              "${workout['activity']} (${workout['repetition']} reps)";
          workoutandSongWidgets.add(ActivityContainer(text: text));
        });
      } else if (eventDetails['eventType'] == 'Zumba') {
        eventDetails['danceMusic'].forEach((song) {
          String text = "${song['songTitle']} by ${song['songArtist']}";
          workoutandSongWidgets.add(ActivityContainer(text: text));
        });
      }
    });
  }

  void goNextPage() {
    if (workoutandSongWidgets.length == 0) {
      setState(() {
        workoutEmptyError = true;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreateGymAndZumbaUI2(eventDetails: eventDetails),
        ),
      ); //
    }
  }

  _getWorkoutAndMusic(BuildContext context) {
    Map tempMap;
    if (eventDetails['eventType'] == 'Gymming') {
      tempMap = {"activity": null, "repetition": null};
    } else {
      tempMap = {"songTitle": null, "songArtist": null};
    }
    final _formKey2 = GlobalKey<FormState>(); // VALIDATE

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text(
              (eventDetails['eventType'] == 'Gymming')
                  ? "Enter Exercise Details"
                  : "Enter Music Details",
              style: TextStyle(color: kTurquoise),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey2,
                child: Column(children: [
                  InputTextFormFill(
                    obscure: false,
                    onChange: (val) {
                      (eventDetails['eventType'] == 'Gymming')
                          ? tempMap['activity'] = val
                          : tempMap['songTitle'] = val;
                    },
                    text: (eventDetails['eventType'] == 'Gymming')
                        ? "Enter Workout Activity"
                        : "Enter Song Title",
                    validate: (val) => val.isEmpty ? '*Cannot be null' : null,
                  ),
                  InputTextFormFill(
                    obscure: false,
                    onChange: (val) {
                      (eventDetails['eventType'] == 'Gymming')
                          ? tempMap['repetition'] = int.parse(val)
                          : tempMap['songArtist'] = val;
                    },
                    text: (eventDetails['eventType'] == 'Gymming')
                        ? "Enter Repetition"
                        : "Enter Song Artist",
                    validate: (eventDetails['eventType'] == 'Gymming')
                        ? (val) {
                            if (val.isEmpty) {
                              return '*Cannot be null';
                            }
                            try{
                              val = int.parse(val);
                              return null;
                            }catch(error){
                              return 'Must be a number';
                            }
                          }
                        : (val) {
                            if (val.isEmpty) {
                              return '*Cannot be null';
                            }
                            return null;
                          },
                  )
                ]),
              ),
            ),
            actions: [
              //Check this portion. The popup doesnt seem to pop
              MaterialButton(
                child: Text('Ok'),
                color: kTurquoise,
                onPressed: () {
                  if (_formKey2.currentState.validate()) {
                    (eventDetails['eventType'] == 'Gymming')
                        ? eventDetails['workout'].add(tempMap)
                        : eventDetails['danceMusic'].add(tempMap);
                    _fillWorkoutandSongWidgets();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _initVariables();
    _fillWorkoutandSongWidgets();
    getFacilFeatures('zumba');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Routine',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: Form(
          key: _formKey, // VALIDATE
          child: Container(
            child: Column(
              children: [
                GoogleMapPlacement(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);


                  },
                  polylineset: Set.of((polylineSet != null)? Set<Polyline>.of(polylineSet) : []), //set polyline
                  markersset: Set.of((markersSet != null)? Set<Marker>.of(markersSet) : []),
                  circlesset: Set.of((circlesSet != null)? Set<Circle>.of(circlesSet) : []),
                  // eventType: "running",

                ),
                Container(
                    height: 410,
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: (eventDetails['eventType'] == 'Gymming')
                              ? InputFieldTextTitles('Select a Gym')
                              : InputFieldTextTitles('Select a Sports Hall'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: GoogleMapsSearchField(
                            text: (locationPos !=null) ? locationPos : "Tap to select",
                              height: 35,
                          onTap: () async
                          {
                            if(eventDetails['eventType'] == 'Gymming')
                            {
                              var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen("gymming")));

                              var latlong = res.split(",");
                              var lat = double.tryParse(latlong[0]);
                              var lng = double.tryParse(latlong[1]);
                              GeoPoint location = GeoPoint(lat, lng);
                              eventDetails['location'] = location;
                              await _goToPlace(LatLng(lat, lng));
                              await setMarkers(LatLng(lat, lng));
                            }
                            else
                            {
                              var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen("zumba")));
                              var latlong = res.split(",");
                              var lat = double.tryParse(latlong[0]);
                              var lng = double.tryParse(latlong[1]);
                              GeoPoint location = GeoPoint(lat, lng);
                              eventDetails['location'] = location;
                              await _goToPlace(LatLng(lat, lng));
                              await setMarkers(LatLng(lat, lng));

                            }


                            //call zoom to update camera thingy.
                          },),
                        ),
                        (eventDetails['eventType'] == 'Zumba')
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputFieldTextTitles(
                                      'Indicate the dance genre'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: InputTextFormFill(
                                      obscure: false,
                                      height: 50,
                                      text: 'Eg. Pop',
                                      onChange: (val) {
                                        eventDetails['danceGenre'] = val;
                                      },
                                      validate: (val) => val.isEmpty
                                          ? 'Enter the genre'
                                          : null,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: (eventDetails['eventType'] == 'Gymming')
                              ? InputFieldTextTitles('Workout Routine')
                              : InputFieldTextTitles('Dance Music'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 23, bottom: 3),
                          child: Text(
                            (workoutEmptyError)
                                ? (eventDetails['eventType'] == 'Gymming')
                                    ? '*Add an exercise'
                                    : '*Add a song'
                                : '',
                            style: TextStyle(color: Colors.red, height: 0.5),
                          ),
                        ),
                        Column(
                          children: workoutandSongWidgets,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
                          child: GestureDetector(
                            onTap: () => _getWorkoutAndMusic(context),
                            child: Container(
                              height: 50,
                              color: kTurquoise,
                              child: Center(
                                child: (eventDetails['eventType'] == 'Gymming')
                                    ? Text('Add Workout Exercise')
                                    : Text('Add Dance Music'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        alignment: Alignment.bottomRight,
                        child: OutlinedButton(
                          child: Text('Next'),
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                goNextPage(),
                              }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToPlace(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(position.latitude, position.longitude),
        zoom: 15)));
  }





  Future<void> setMarkers(LatLng position) async {

    locationPos = await PlacesService.searchCoordinateAddress(position);

    markersSet.clear();
    Marker locationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: locationPos, snippet: "Selected Location"),
      position: position,
      markerId: MarkerId("${locationPos}Id"),
    );

    setState(() {
      markersSet.add(locationMarker);

    });

    Circle locationCircle = Circle(
      fillColor: Colors.blueAccent,
      center: position,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("${locationPos}Id"),
    );

    setState(() {
      circlesSet.add(locationCircle);

    });


  }

  Future<void> getFacilFeatures(String whichapi) async { //function for sports facilities.

    var file;
    if (whichapi == "zumba") {
      file = "assets/sportsFacil.json";
    }

    var jsonText = await rootBundle.loadString(file);
    //setState(() => data = json.decode(jsonText));
   Map<dynamic, dynamic> json = convert.jsonDecode(jsonText);
    var jsonFeatures = json['features'] as List;


    //var jsonFeaturesco = jsonFeatures['geometry']['coordinates'] as List;
    /*Map<dynamic, dynamic> json = convert.jsonDecode(jsonText);
    List<dynamic>jsonFeatures = json['features'];
    var jsonfeaturesgeo = json['geometry'] as List;
    print(jsonfeaturesgeo.length);*/

    facilcall = jsonFeatures.map((place) => Facilities.fromJson(place)).toList();
    List<dynamic> facilcallfeatures = [];
    //var facilcall;

    for(int i=0;i<facilcall.length;i++)
      {
        print(facilcall[i].coordinates);
      }
    pLineCoordinates.clear();

    /*await Future.forEach(facilcall, (element) async
    {
      List positions = element.coordinates as List;
      await Future.forEach(positions, (element) {

        position = LatLng(element[1],element[0]);
        positionList.add(position);
      });
      addMarker();
    });*/




    /*for(int i=0;i<facilcall.length;i++)
      {
        for(int j=0;j<facilcall[i].coordinates.length;j++)
          {
            facilcallfeatures = facilcall[i].coordinates[j] as List;

          }

      }*/
    for(int i =0;i<facilcallfeatures.length;i++)
      {
        pLineCoordinates.add(LatLng(facilcallfeatures[i][1],facilcallfeatures[i][0]));
      }



    //print(pLineCoordinates.length);
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
    /*for(int i=0;i<facilcallfeatures.length;i++)
    {
      print(facilcallfeatures[i]);
    }*/


    //for(int i = 0;i<facilcallfeatures.length;i++)
     // {
       // print(facilcallfeatures[i]);
     // }



    /*for(int i=0;i<facilcall.length;i++){
      facilcallfeatures.add(facilcall[i].coordinates);
      print(facilcallfeatures);
      //print("the coordinates are ${facilcall[i].coordinates}");
      //print("name is ${facilcall[i].roadname}"+"${facilcall[i].lat} ${facilcall[i].lng}");
    }*/

  }
  int polylinecounter = 1;

  addMarker() async {
    polylineSet.add(Polyline(
      polylineId: PolylineId("${polylinecounter}Id"),
      visible: true,
      width: 6,
      points: positionList,
      jointType: JointType.round,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,


    ));
    polylinecounter++;
  }
}
