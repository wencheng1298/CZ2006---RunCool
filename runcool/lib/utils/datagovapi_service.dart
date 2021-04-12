import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:provider/provider.dart';
import 'datagovapi/features.dart';
import 'dart:convert' as convert;

class DataGovAPI_Service {

  final geo = GeoJson();

  var PCNdata = <GeoJsonPoint>[];

   Future<Features> getCoordinates(String whichapi) async {


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
    var json = convert.jsonDecode(jsonText);
    var jsonFeatures = json['features'] as Map<String,dynamic>;
    return Features.fromJson(jsonFeatures);


  }


  /*Future<void> parse() async {
    final geojson = GeoJson();
    geojson.processedPoints.listen((GeoJsonPoint geoJsonPoint) {
      print("${geoJsonPoint.name}: ${geoJsonPoint.geoPoint.point}");
    });
    await geojson.parseFile("../assets/PCN_Access_Points_googlemaps.geojson",
        nameProperty: "ADMIN");
  }*/

 /* Future<void> loadPCN() async {
    final data = await rootBundle.loadString('assets/PCN_Access_Points_googlemaps.geojson');
    await geo.parse(data, disableStream: true, verbose: true);
    PCNdata = geo.points;
  }*/



}

