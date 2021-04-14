import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runcool/utils/places_service.dart';
import 'constants.dart';
import './GoogleMapPlacement.dart';
import 'package:runcool/models/User.dart';
import '../utils/everythingUtils.dart';
import './../pages/profileDependancies/ProfileUI1.dart';

class EventCard extends StatefulWidget {
  final Function fn;
  final dynamic event;

  EventCard({this.event, this.fn});




  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  dynamic event;

  Completer<GoogleMapController> _mapController = Completer();

  List<LatLng> pLineCoordinates = [];

  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = Set();

  Set<Circle> circlesSet = {};

  String initialPos, finalPos;

  LatLngBounds latLngBounds;

  BitmapDescriptor nparklocationicon;
  //gym and zumba stuff
  String locationPos;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.event.eventType == 'Running') {
      setRoute();
    }
    else {
      setMarkers().then((_) {
        _goToPlace(widget.event.location);

      });

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.fn,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 340,
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800],
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: kBackgroundColor,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (widget.event.startTime != null)
                        ? '${widget.event.startTime.day}/${widget.event.startTime.month}/${widget.event.startTime.year}'
                        : '', //date
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    (widget.event.eventType != null)
                        ? widget.event.eventType.toString()
                        : '', //Event Type
                    style: TextStyle(color: kTurquoise),
                  ),
                  Text(
                    (widget.event.startTime != null)
                        ? (widget.event.startTime.hour.toString().padLeft(2, '0')) +
                            ":" +
                            (widget.event.startTime.minute.toString().padLeft(2, '0'))
                        : "", // Time
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Text(
              (widget.event.name != '') ? widget.event.name : '',
              style: TextStyle(fontSize: 24, color: kTurquoise),
            ),
            //The lag is killing me so imma gotto comment this out
             Padding(
               padding: const EdgeInsets.only(left: 15.0, right: 15.0),
               child: Container(
                 child: GoogleMapPlacement(
                   onMapCreated: (GoogleMapController controller) {
                     _mapController.complete(controller);
                     //controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));


                   },
                   polylineset: Set.of((polylineSet != null)? Set<Polyline>.of(polylineSet) : []), //set polyline
                   markersset: Set.of((markersSet != null)? Set<Marker>.of(markersSet) : []),
                   circlesset: Set.of((circlesSet != null)? Set<Circle>.of(circlesSet) : []),

                 ),
               ),
             ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      (widget.event.eventType == 'Running')
                          ? widget.event.estDistance //+ "km" - removed this cause it is in km
                          : '', // Time
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  (widget.event.difficulty == 'Hard')
                      ? Row(children: [
                          Icon(Icons.bolt, size: 20, color: kTurquoise),
                          Icon(Icons.bolt, size: 20, color: kTurquoise),
                          Icon(Icons.bolt, size: 20, color: kTurquoise)
                        ])
                      : (widget.event.difficulty == 'Medium')
                          ? Row(children: [
                              Icon(Icons.bolt, size: 20, color: kTurquoise),
                              Icon(Icons.bolt, size: 20, color: kTurquoise),
                            ])
                          : Icon(Icons.bolt, size: 20, color: kTurquoise),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  (widget.event.noOfParticipants != null)
                      ? widget.event.noOfParticipants.toString() + " pax"
                      : '3 pax',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: StreamBuilder<AppUser>(
                  stream: AppUser.getUserFromID(widget.event.creator),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              creator.name == ''
                                  ? "No name provided"
                                  : creator.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            creator.image != ''
                                ? CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(creator.image),
                                  )
                                : Icon(
                                    Icons.account_circle_outlined,
                                    size: 25,
                                    color: kTurquoise,
                                  ),
                          ],
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );



  }
  Future<void> updateCamera() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
  }

  Future<void> setRoute() async {
    //var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    //var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;

    GeoPoint startLoc = widget.event.startLocation;
    LatLng startLatLng = LatLng(startLoc.latitude, startLoc.longitude);
    GeoPoint endLoc = widget.event.endLocation;
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

    //print("this is encoded points: ");
    //print(widget.event.encPoints);
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
    List<PointLatLng> decodePolyLinePointsResult = polylinePoints.decodePolyline(widget.event.encPoints);

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
      infoWindow: InfoWindow(title: initialPos, snippet: "Starting Address"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos, snippet: "Destination Address"),
      position: desLatLng,
      markerId: MarkerId("destId"),
    );

    List<dynamic> waypoint = widget.event.checkpoints;

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

  Future<void> _goToPlace(GeoPoint position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(position.latitude, position.longitude),
        zoom: 15)));
  }

  Future<void> setMarkers() async {

    GeoPoint locationGeo = widget.event.location;
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

