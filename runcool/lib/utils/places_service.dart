import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/place.dart';
import 'dart:convert' as convert;
import 'everythingUtils.dart';

import 'place_search.dart';
import 'directionDetails.dart';

class PlacesService {

  final API_KEY = GoogleAPIKey;

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var type = 'address';
    //var location = '1.3521, 103.8198';
    //var radius = '500';
    var country = 'sg'; //&components=country:sg
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$API_KEY&components=country:$country');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();




    //print(jsonResults);

  }

  Future<Place> getPlace(String placeId) async { //get place details with place_id

    var type = 'address';
    var location = '1.3521, 103.8198';
    var radius = '500';
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$API_KEY&place_id=$placeId');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

  /*Future<DirectionDetails> getPlaceAddressDetails(String placeId) async { //get place details with place_id

    var type = 'address';
    var location = '1.3521, 103.8198';
    var radius = '500';
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$API_KEY&place_id=$placeId');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    if(json['status']== 'OK')
      {
        /*var jsonResult = json['result'];
        Place newplace = Place();
        newplace.name = jsonResult['name'];
        newplace.placeId = placeId;
        newplace.geometry.location.lat = jsonResult['geometry']['location']['lat'];
        newplace.geometry.location.lng = jsonResult['geometry']['location']['lng'];

        Provider.of<GoogleMapsAppData>(context, listen: false).updateDestLocationAddress(newplace);
        print("this is drop off location");
        print(newplace.name);*/

        var jsonResult = json['result'] as Map<String,dynamic>;
        return DirectionDetails.fromJson(jsonResult);


      }
    //var jsonResult = json['result'] as Map<String,dynamic>;
    //return Place.fromJson(jsonResult);
  }*/

  static Future<String> searchCoordinateAddress(LatLng position/*, context*/) async { //geolocator search position //assistant method

    String placeAddress = '';
    var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GoogleAPIKey');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);



    /*var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);*/

    var jsonResult = json['result'];

    placeAddress = json['results'][0]['address_components'][2]['short_name'];
    /*Place newplace = new Place();
    newplace.geometry.location.lat = position.latitude;
    newplace.geometry.location.lng = position.longitude;
    newplace.name = jsonResult[0]['formatted_address'];
    newplace.placeId = jsonResult[0]['place_id'];*/


    //Provider.of<GoogleMapsAppData>(context, listen: false).updateStartLocationAddress(newplace);

    return placeAddress;
  }



   static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {

    //example https://maps.googleapis.com/maps/api/directions/json?
    // origin=Toronto&destination=Montreal
    // &key=YOUR_API_KEY


    String directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&mode=walking&key=$GoogleAPIKey' ;

    var url = Uri.parse(directionsUrl);
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);


    //var jsonResults = json['routes'] as List;
    //return jsonResults.map((direction) => DirectionDetails.fromJson(direction)).toList();
    //var jsonResult = json['routes'] as Map<String,dynamic>;
    //return DirectionDetails.fromJson(jsonResult);
    //need to see if implementing correctly....
    /*var jsonResults =json['routes'];
    DirectionDetails newdirection = DirectionDetails.fromJson(jsonResults);*/

    //var jsonResults = json['predictions'] as List;
    //return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();

    var jsonResults =json["routes"];
    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.distanceValue = jsonResults[0]["legs"][0]["distance"]["value"];
    directionDetails.distanceText = jsonResults[0]["legs"][0]["distance"]["text"];

    directionDetails.durationValue = jsonResults[0]["legs"][0]["duration"]["value"];
    directionDetails.durationText = jsonResults[0]["legs"][0]["duration"]["text"];

    directionDetails.encodedPoints = jsonResults[0]["overview_polyline"]["points"];
    return directionDetails;

    /*var jsonResult = json['result'] as Map<String,dynamic>;
    return DirectionDetails.fromJson(jsonResult);*/

  }

  static Future<DirectionDetails> addingWaypoint(LatLng initialPosition, LatLng finalPosition, LatLng waypoint) async {

    //example https://maps.googleapis.com/maps/api/directions/json?
    // origin=Toronto&destination=Montreal
    // &key=YOUR_API_KEY



    String directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&waypoints=${waypoint.latitude}%2C${waypoint.longitude}&mode=walking&key=$GoogleAPIKey' ;

    var url = Uri.parse(directionsUrl);
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);


    //var jsonResults = json['routes'] as List;
    //return jsonResults.map((direction) => DirectionDetails.fromJson(direction)).toList();
    //var jsonResult = json['routes'] as Map<String,dynamic>;
    //return DirectionDetails.fromJson(jsonResult);
    //need to see if implementing correctly....
    /*var jsonResults =json['routes'];
    DirectionDetails newdirection = DirectionDetails.fromJson(jsonResults);*/

    //var jsonResults = json['predictions'] as List;
    //return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();

    var jsonResults =json["routes"];
    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.distanceValue = jsonResults[0]["legs"][0]["distance"]["value"];
    directionDetails.distanceText = jsonResults[0]["legs"][0]["distance"]["text"];

    directionDetails.durationValue = jsonResults[0]["legs"][0]["duration"]["value"];
    directionDetails.durationText = jsonResults[0]["legs"][0]["duration"]["text"];

    directionDetails.encodedPoints = jsonResults[0]["overview_polyline"]["points"];
    return directionDetails;

    /*var jsonResult = json['result'] as Map<String,dynamic>;
    return DirectionDetails.fromJson(jsonResult);*/

  }
}