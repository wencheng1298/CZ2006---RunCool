class Facilities {
  String roadname;
  double lat;
  double lng;
  String description;
  List<dynamic> coordinates;

  Facilities({this.roadname,this.lat,this.lng,this.description,this.coordinates});

  factory Facilities.fromJson(Map<String, dynamic> parsedJson) {
    return Facilities(
      roadname: parsedJson['properties']['ROAD_NAME'],
      lat: parsedJson['geometry']['coordinates'][0][1],
      lng: parsedJson['geometry']['coordinates'][0][0],
      description: parsedJson['properties']['FACILITIES'],
      coordinates: parsedJson['geometry']['coordinates'],

    );
  }
}