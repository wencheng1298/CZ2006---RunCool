import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runcool/utils/directionDetails.dart';
import 'package:runcool/utils/geolocator_service.dart';
import 'package:runcool/utils/place.dart';
import 'package:runcool/utils/place_search.dart';
import 'package:runcool/utils/places_service.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:math' show cos, sqrt, asin;

//Start of ApplicationBloc
class GoogleMapsAppData with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();






  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  BehaviorSubject<Place> selectedLocation = BehaviorSubject<Place>(); //changed from streamcontroller to behavioursubject cause when press back wont have error.
  double start_lat, start_lng, des_lat, des_lng;
  Position selectedplace;
  Place startingPlace, destPlace;

  BehaviorSubject<DirectionDetails> LocationDetails = BehaviorSubject<DirectionDetails>(); //changed from streamcontroller to behavioursubject cause when press back wont have error.

  GoogleMapsAppData() {
    setCurrentLocation();
  }

  void updateStartLocationAddress(Place startAddress) {
    startingPlace = startAddress;
    notifyListeners(); //handle the changes
  }
  void updateDestLocationAddress(Place destAddress) {
    destPlace = destAddress;
    notifyListeners(); //handle the changes
  }


  setCurrentLocation() async {
    currentLocation =  await geoLocatorService.getCurrentLocation(); //get current position
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }


  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

  getPlaceSelected(String placeId) async { //called in createrunningUi1 - to get the place details.
    Place newplace = Place();
    newplace = await placesService.getPlace(placeId);

    newplace.name = newplace.name;
    // print('this is drop off address');
    // print(newplace.name);
    notifyListeners();

    //Navigator.pop(context,"obtained directions");
  }
  /*getPlaceAddressDetails(String placeId) async {
    DirectionDetails address = DirectionDetails();
    address = await placesService.getPlaceAddressDetails(placeId);
  }*/

  /*getPlaceDetails(String placeId) async {
    searchResults = await placesService.obtainPlaceDirectionDetails(placeId);
    notifyListeners();
  }*/

  /*getDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails = await placesService.obtainPlaceDirectionDetails(initialPosition, finalPosition);
    print('this is distance');
    print(directionDetails.distanceValue);
    notifyListeners();

  }*/



  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) { //to calculate distance between 2.
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

}

//End of ApplicationBloc


