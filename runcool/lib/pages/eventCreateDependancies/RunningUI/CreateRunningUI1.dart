import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/custom_rect_tween.dart';
import 'package:runcool/utils/datagovapi/features.dart';
import 'package:runcool/utils/place.dart';
import 'package:runcool/utils/place_search.dart';
import 'package:runcool/utils/places_service.dart';
import 'package:runcool/utils/searchScreen.dart';
import './CreateRunningUI2.dart';
import './../../../utils/everythingUtils.dart';

//for geopoint saving...
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:google_api_headers/google_api_headers.dart';
//import 'package:google_maps_webservice/places.dart';

//import 'package:dio/dio.dart';

import 'dart:async';
//import 'package:geocoder/geocoder.dart';


//places_service
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String API_KEY = GoogleAPIKey;
Uri PLACES_API_KEY = Uri.parse(API_KEY);

class CreateRunningUI1 extends StatefulWidget {
  //final Map title;
  //CreateRunningUI1({Key key, this.title}) : super(key: key);
  final Map eventDetails;
  CreateRunningUI1({this.eventDetails});


  @override
  _CreateRunningUI1State createState() => _CreateRunningUI1State(eventDetails);
}
/// Tag-value used for the add todo popup button.
const String _heroSearch = 'add-search-hero';

class _CreateRunningUI1State extends State<CreateRunningUI1> {
  //Trial with Mapping
  Map eventDetails;
  _CreateRunningUI1State(this.eventDetails);

  final _formKey = GlobalKey<FormState>(); //validate

  void _initVariables() {
    eventDetails["checkpoints"] = [];


    eventDetails["participants"] = [];
    eventDetails["notifications"] = [];

  }

  void _fillRunDetailsWidget() {
    setState(() {

    });
  }


  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;

  //Trial with polylines
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();
  Set<Circle> circlesSet = {};

  //Estimated distance text
  var EstimatedDistance = "";

  //trial with geojson
  final geo = GeoJson();
  var PCNdata = <GeoJsonPoint>[];
  //StreamSubscription<GeoJsonPoint> sub;
  final dataIsLoaded = Completer<Null>();
  List<Marker> _geomarkers = <Marker>[];
  List<Features> apicall;
  BitmapDescriptor nparklocationicon;


  //trial with searching function
  TextEditingController destTextEditingController = TextEditingController();
  List<PlaceSearch> placeSearchList = [];






  @override
  void initState() {
    final googleMapsController =Provider.of<GoogleMapsAppData>(context, listen: false);
    locationSubscription =
        googleMapsController.selectedLocation.stream.listen((place) {
          if (place != null) {
            _goToPlace(place);
          }
        });
    /*getBytesFromAsset('images/nparkscoast-to-coast.png', 64).then((onValue) {

      setState(() {
        nparklocationicon =BitmapDescriptor.fromBytes(onValue);
      });
      print('icon loaded');


    });*/
    getCoordinates('running').then((_) {

      for(int i =0; i< apicall.length; i ++)
      {
        _geomarkers.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          //infoWindow: InfoWindow(title: point.name, snippet: "Starting Address"),
          infoWindow: InfoWindow(title: apicall[i].name),
          position: LatLng(apicall[i].lat, apicall[i].lng),
          markerId: MarkerId("${apicall[i].name}Id"),
        ));
        //print(_geomarkers[0]);
      }
      setState(() {
        markersSet.addAll(_geomarkers);


      });

    });

    _initVariables(); //to initialise as empty list first.



    super.initState();
  }


  @override
  void dispose() {
    final googleMapsController =
    Provider.of<GoogleMapsAppData>(context, listen: false);
    googleMapsController.dispose();
    locationSubscription.cancel();
    markersSet.clear();
    circlesSet.clear();
    polylineSet.clear();
    //sub.cancel();
    getBytesFromAsset('images/nparkscoast-to-coast.png', 64).then((onValue) {
      nparklocationicon =BitmapDescriptor.fromBytes(onValue);

    });

    super.dispose();
  }

  //Map eventDetails = {"eventType": "Running"};


  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }




  void goNextPage() {
    //todo should i be adding the must to add a checkpoint??
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateRunningUI2(eventDetails: eventDetails)));
  }

  @override
  Widget build(BuildContext context) {
    //final googleMapsAppData = Provider.of<GoogleMapsAppData>(context);
    //String startingAddress = googleMapsAppData.startingPlace.name;
    //Place startingAddress;
    //startTextEditingController.text = startingAddress;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Route',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
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
                ],
              ),
              Container(
                height: 410,
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Start'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          GoogleMapsSearchField(
                            text:
                            (Provider.of<GoogleMapsAppData>(context).startingPlace != null
                                ? Provider.of<GoogleMapsAppData>(context).startingPlace.name
                                : 'Starting Address'), //the hint text

                            onTap: () async
                            {
                              var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen("Start")));
                              if(Provider.of<GoogleMapsAppData>(context,listen: false).startingPlace != null)
                                await _goToPlace(Provider.of<GoogleMapsAppData>(context,listen: false).startingPlace);


                              if(Provider.of<GoogleMapsAppData>(context,listen: false).destPlace != null && res== "obtainDirection")
                              {
                                await getPlaceDirection();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('End'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          GoogleMapsSearchField(
                            text: Provider.of<GoogleMapsAppData>(context).destPlace != null
                                ? Provider.of<GoogleMapsAppData>(context).destPlace.name
                                : 'Ending Address', //the hint text
                            /*textcontroller: destTextEditingController,
                            onChange: (value) =>
                                googleMapsAppData.searchPlaces(value),*/
                            onTap: () async
                            {
                              var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen("End")));


                              if(Provider.of<GoogleMapsAppData>(context,listen: false).startingPlace != null && res== "obtainDirection")
                              {
                                await getPlaceDirection();
                              }
                            }

                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('CheckPoints'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: GestureDetector(
                        onTap: () async
                        {
                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen("addwaypt")));

                          if(Provider.of<GoogleMapsAppData>(context,listen: false).destPlace != null && Provider.of<GoogleMapsAppData>(context,listen: false).startingPlace != null && res!="obtainDirection")
                          {
                            var latlong = res.split(",");
                            print(latlong);
                            var lat = double.tryParse(latlong[0]);
                            var lng = double.tryParse(latlong[1]);
                            GeoPoint checkpoint = GeoPoint(lat, lng);
                            eventDetails['checkpoints'].add(checkpoint);
                            await addwaypointDirection(LatLng(lat, lng));
                          }
                        },
                        child: Hero(
                          tag: _heroSearch,
                          createRectTween: (begin, end){
                            return CustomRectTween(begin: begin, end: end);
                          },
                          child: Container(
                            height: 50,
                            color: kTurquoise,
                            child: const Center(
                              child: Text('Add CheckPoint'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20),
                    child: const Text(
                      "Estimated Distance: ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20),
                    child:  Text(
                      EstimatedDistance,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        child: Text('Next'),
                        onPressed: () => {
                          goNextPage(),
                          },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 15)));
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;


    var startLatLng = LatLng(initialPos.geometry.location.lat, initialPos.geometry.location.lng);
    print("this is the start");
    print(initialPos.placeId);
    print(startLatLng);
    var desLatLng = LatLng(finalPos.geometry.location.lat, finalPos.geometry.location.lng);
    print("this is the end");
    print(finalPos.placeId);
    print(desLatLng);

    /*showDialog(
      context: context,
      builder: (BuildContext context) => Loading()
    );*/

    var details = await PlacesService.obtainPlaceDirectionDetails(startLatLng, desLatLng);



    print("this is encoded points: ");
    print(details.encodedPoints);
    setState(() {
      //todo check if this is correct
      GeoPoint  start = GeoPoint(startLatLng.latitude, startLatLng.longitude);
      eventDetails['startLocation'] = start;

      GeoPoint  end = GeoPoint(desLatLng.latitude, desLatLng.longitude);
      eventDetails['endLocation'] = end;

      eventDetails['encPoints'] = details.encodedPoints;

      EstimatedDistance = details.distanceText;
      eventDetails['estDistance'] = EstimatedDistance;


    });


    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

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

    LatLngBounds latLngBounds;
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
      infoWindow: InfoWindow(title: initialPos.name, snippet: "Starting Address"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos.name, snippet: "Destination Address"),
      position: desLatLng,
      markerId: MarkerId("destId"),
    );

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


  Future<void> getCoordinates(String whichapi) async {

    var file;
    if (whichapi == "running") {
      file = "assets/PCN_Access_Points_googlemaps.geojson";
    } else if (whichapi == "gymming") {
      file = "assets/gymData.json";
    } else {
      file = "assets/sportsFacil.json";
    }

    var jsonText = await rootBundle.loadString(file);
    //setState(() => data = json.decode(jsonText));
    Map<dynamic, dynamic> json = convert.jsonDecode(jsonText.toString());
    var jsonFeatures = json['features'] as List;

    apicall = jsonFeatures.map((place) => Features.fromJson(place)).toList();
    for(int i=0;i<apicall.length;i++){
      print("name is ${apicall[i].name}"+"${apicall[i].lat} ${apicall[i].lng}");
    }

  }
  Future<void> addwaypointDirection(LatLng waypoint) async {
    var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;
    //print(initialPos);


    var startLatLng = LatLng(initialPos.geometry.location.lat, initialPos.geometry.location.lng);
    print("this is the start");
    print(initialPos.placeId);
    print(startLatLng);
    var desLatLng = LatLng(finalPos.geometry.location.lat, finalPos.geometry.location.lng);
    print("this is the end");
    print(finalPos.placeId);
    print(desLatLng);

    /*showDialog(
      context: context,
      builder: (BuildContext context) => Loading()
    );*/

    var details = await PlacesService.addingWaypoint(startLatLng, desLatLng, waypoint);




    print("this is encoded points: ");
    print(details.encodedPoints);

    setState(() {
      //todo check if this is correct
      GeoPoint  start = GeoPoint(startLatLng.latitude, startLatLng.longitude);
      eventDetails['startLocation'] = start;

      GeoPoint  end = GeoPoint(desLatLng.latitude, desLatLng.longitude);
      eventDetails['endLocation'] = end;

      eventDetails['encPoints'] = details.encodedPoints;

      EstimatedDistance = details.distanceText;
      eventDetails['estDistance'] = EstimatedDistance;


    });

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

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

    LatLngBounds latLngBounds;
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


    markersSet.clear();
    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: initialPos.name, snippet: "Starting Address"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos.name, snippet: "Destination Address"),
      position: desLatLng,
      markerId: MarkerId("destId"),
    );


    Marker wayptLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: waypoint.toString(), snippet: "Waypoint"),
      position: waypoint,
      markerId: MarkerId("wayptId"),
    );

    setState(() {
      markersSet.clear();
      markersSet.add(startLocMarker);
      markersSet.add(destLocMarker);
      markersSet.add(wayptLocMarker);
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