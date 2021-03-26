import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'GoogleMapsAppData.dart';
import 'everythingUtils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'dart:math' show cos, sqrt, asin;

class GoogleMapPlacement extends StatefulWidget {

  final Function onMapCreated;


  /*void getStartAddress(startAddress) {
    _GoogleMapState().getStartingAddress(startAddress);
  }*/
  GoogleMapPlacement({this.onMapCreated});

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapPlacement> {

  CameraPosition _initialLocation = CameraPosition(target: LatLng(1.3521, 103.8198)); //Singapore
  //GoogleMapController mapController;
  Completer<GoogleMapController> _mapController = Completer();

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
          googleMapsAppData.currentLocation == null
          ? Center(child: CircularProgressIndicator(),)
          :GoogleMap(
            mapType: MapType.normal,
            //initialCameraPosition: _initialLocation,
            initialCameraPosition: CameraPosition(target: LatLng(googleMapsAppData.currentLocation.latitude, googleMapsAppData.currentLocation.longitude),
            zoom: 14),
            myLocationEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: markers != null ? Set<Marker>.from(markers) : null,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: widget.onMapCreated,
      ),



        ],
      )

    );
  }


}


