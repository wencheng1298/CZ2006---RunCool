class DirectionDetails {
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  String encodedPoints;

  DirectionDetails({this.distanceValue,this.durationValue,this.distanceText,this.durationText, this.encodedPoints});

  factory DirectionDetails.fromJson(Map<String, dynamic> parsedJson) {
    return DirectionDetails(
      distanceValue: parsedJson[0]['legs'][0]['distance']['value'],
      durationValue: parsedJson[0]['legs'][0]['duration']['value'],
      distanceText: parsedJson[0]['legs'][0]['distance']['text'],
      durationText: parsedJson[0]['legs'][0]['duration']['text'],
      encodedPoints: parsedJson[0]['overview_polyline']['points']
    );
  }
}