import 'geometry.dart';

class Place {
  final Geometry geometry;
  String name;
  String vicinity;
  String placeId;

  Place({this.geometry, this.name, this.vicinity, this.placeId});

  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        vicinity: parsedJson['vicinity'],
        placeId: parsedJson['place_id']);
  }
}
