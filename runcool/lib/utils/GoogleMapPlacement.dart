import 'dart:async';
import 'package:utm/utm.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'GoogleMapsAppData.dart';
import 'everythingUtils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'dart:math' show cos, sqrt, asin;

class GoogleMapPlacement extends StatefulWidget {
  final Function onMapCreated;
  final String eventType;
  final Set<Polyline> polylineset;
  final Set<Marker> markersset;
  final Set<Circle> circlesset;

  /*void getStartAddress(startAddress) {
    _GoogleMapState().getStartingAddress(startAddress);
  }*/
  GoogleMapPlacement({this.onMapCreated, this.eventType, this.polylineset, this.circlesset,this.markersset});

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapPlacement> {
  // CameraPosition _initialLocation = CameraPosition(target: LatLng(1.3521, 103.8198)); //Singapore
  //GoogleMapController mapController;
  Completer<GoogleMapController> _mapController = Completer();

  Map<String, dynamic> data;

  Future<String> loadJsonData() async {
    var file;
    if (widget.eventType == "running") {
      file = "assets/pcn.json";
    } else if (widget.eventType == "gymming") {
      file = "assets/gymData.json";
    } else {
      file = "assets/sportsFacil.json";
    }

    var jsonText = await rootBundle.loadString(file);
    setState(() => data = json.decode(jsonText));
    print(data);

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    //this.loadJsonData();
  }

  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  String _currentAddress;

  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;

  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];



  @override
  /*void initState() {
    super.initState();
    _getCurrentLocation();



  }

  void getStartingAddress(startAddress) {
    this._startAddress = startAddress;
    _getAddress();
  }*/

  Widget build(BuildContext context) {
    final googleMapsAppData = Provider.of<GoogleMapsAppData>(context);
    //body: (googleMapsAppData.currentLocation == null)
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            if (googleMapsAppData.currentLocation == null) Center(
                    child: CircularProgressIndicator(),
                  ) else GoogleMap(
                    mapType: MapType.normal,
                    //initialCameraPosition: _initialLocation,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            googleMapsAppData.currentLocation.latitude,
                            googleMapsAppData.currentLocation.longitude),
                        zoom: 14),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers: Set.of((widget.markersset != null) ? widget.markersset : [])
              /*markers != null ? Set<Marker>.from(markers) : null*/,
                    // markers: data != null
                    //     ? getMarkers(data, widget.eventType)
                    //     : null,
                    polylines: Set.of((widget.polylineset != null) ? widget.polylineset : [])
              /*Set<Polyline>.of(polylines.values)*/,
                    circles: Set.of((widget.circlesset != null) ? widget.circlesset : []),
                    onMapCreated: widget.onMapCreated,
                  ),
          ],
        ));
  }
}

// Set<Marker> getMarkers(Map data, String eventType) {
//   if (eventType == "gymming") {
//     Set<Marker> markers = {};
//     // var latlong = UTM.fromUtm(
//     //   easting: 21092.5487,
//     //   northing: 46530.7697,
//     //   zoneNumber: 48,
//     //   zoneLetter: 'N',
//     // );
//     // final utm = UTM.fromLatLon(lon: 103.850922071159005, lat: 1.35528262760188);
//     // print('zone: ${utm.zone}');
//     // print('N: ${utm.northing}');
//     // print('E: ${utm.easting}');
//     // print('lat: ${utm.lat}');
//     // print('lat: ${utm.lon}');
//     // double lng = latlong.lon;
//     // double lat = latlong.lat;
//     // print(lng);
//     // print(lat);
//     print(data);
//     int count = 0;
//     for (var item in data["features"]) {
//       double lng = item["geometry"]["coordinates"][0];
//       double lat = item["geometry"]["coordinates"][1];
//
//       Marker marker = Marker(
//         markerId: MarkerId(item["properties"]["INC_CRC"]),
//         position: LatLng(lat, lng),
//         infoWindow: InfoWindow(title: item["properties"]["Name"]),
//         icon: BitmapDescriptor.defaultMarkerWithHue(
//           BitmapDescriptor.hueViolet,
//         ),
//       );
//       markers.add(marker);
//
//       count += 1;
//     }
//
//     return markers;
//   } else {
//     return null;
//   }
// }
