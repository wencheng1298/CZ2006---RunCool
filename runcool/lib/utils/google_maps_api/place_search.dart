class PlaceSearch {
  String description;
  String placeId;
  String main_text;
  String secondary_text;

  PlaceSearch({this.description, this.placeId,this.main_text,this.secondary_text});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
      description: json['description'],
      placeId: json['place_id'],
      main_text: json['structured_formatting']['main_text'],
      secondary_text: json['structured_formatting']['secondary_text'],
    );
  }
}