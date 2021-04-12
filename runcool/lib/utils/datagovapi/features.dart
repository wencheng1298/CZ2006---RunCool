//import 'geometry.dart';
//import 'properties.dart';

/*class Features {
  final Geometry geometry;
  final Properties properties;

  Features({this.geometry,this.properties});

  factory Features.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Features(
      geometry: parsedJson['geometry'],
      properties: parsedJson['properties']
    );
  }

  Map<String, dynamic> toJson() => {
    "geometry" : geometry,
    "properties" : properties
  };


}*/

class Features {
  String name;
  double lat;
  double lng;

  Features({this.name,this.lat,this.lng});

  factory Features.fromJson(Map<String, dynamic> parsedJson) {
    return Features(
      name: parsedJson['properties']['Name'],
      lat: parsedJson['geometry']['coordinates'][1],
      lng: parsedJson['geometry']['coordinates'][0]
    );
  }
}