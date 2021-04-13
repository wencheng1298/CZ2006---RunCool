import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runcool/utils/DividerWidget.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/configGMaps.dart';
import 'package:runcool/utils/custom_rect_tween.dart';
import 'package:runcool/utils/datagovapi/features.dart';
import 'package:runcool/utils/everythingUtils.dart';
import 'package:runcool/utils/place.dart';
import 'package:runcool/utils/place_search.dart';

//places_service
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'datagovapi/facilities.dart';
class SearchScreen extends StatefulWidget {
  final String addtext;
  const SearchScreen(this.addtext);

  //SearchScreen({Key key, @required this.addtext}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

/// Tag-value used for the add todo popup button.
const String _heroSearch = 'add-search-hero';

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController destTextEditingController = TextEditingController();
  List<PlaceSearch> placeSearchList = [];
  List<Features> apicall;
  //try filter
  List<Features> _filteredlist = [];

  List<Facilities> facilcall;
  List<Facilities> facilfilteredlist =[];

  String filter = "";
  @override
  void initState() {
    if(widget.addtext == 'addwaypt')
      {
        getCoordinates('running').then((_) {

          if(widget.addtext == 'addwaypt')
          {
            List<Features> tmpList = [];
            for(int i=0;i< apicall.length;i++)
            {
              tmpList.add(apicall[i]);
            }
            setState(() {
              //apicall = tmpList;
              _filteredlist = apicall;
            });
            destTextEditingController.addListener(() {
              if(destTextEditingController.text.isEmpty) {
                setState(() {
                  filter = "";
                  _filteredlist = apicall;
                });
              }
              else{
                setState(() {
                  filter = destTextEditingController.text;
                });
              }
            });

          }

        });

      }
    else if (widget.addtext == 'gymming')
      {
        getCoordinates('gymming').then((_) {

            List<Features> tmpList = [];
            for(int i=0;i< apicall.length;i++)
            {
              tmpList.add(apicall[i]);
            }
            setState(() {
              //apicall = tmpList;
              _filteredlist = apicall;
            });
            destTextEditingController.addListener(() {
              if(destTextEditingController.text.isEmpty) {
                setState(() {
                  filter = "";
                  _filteredlist = apicall;
                });
              }
              else{
                setState(() {
                  filter = destTextEditingController.text;
                });
              }
            });



        });

      }
    else if(widget.addtext == 'zumba')
      {
        getFacilFeatures('zumba').then((_) {

            List<Facilities> tmpList = [];
            for(int i=0;i< facilcall.length;i++)
            {
              tmpList.add(facilcall[i]);
            }
            setState(() {
              //apicall = tmpList;
              facilfilteredlist = facilcall;
            });
            destTextEditingController.addListener(() {
              if(destTextEditingController.text.isEmpty) {
                setState(() {
                  filter = "";
                  facilfilteredlist = facilcall;
                });
              }
              else{
                setState(() {
                  filter = destTextEditingController.text;
                });
              }
            });



        });

      }



    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    final googleMapsAppData = Provider.of<GoogleMapsAppData>(context);

    setState(() {
      placeSearchList = googleMapsAppData.searchResults;
      //destTextEditingController.text;
    });

    //filter
    if(widget.addtext == 'zumba')
      {
        if((filter.isNotEmpty)) {
          List<Facilities> tmpList = [];
          for(int i=0;i<facilfilteredlist.length;i++) {
            if(facilfilteredlist[i].roadname.toLowerCase().contains(filter.toLowerCase()))
              tmpList.add(facilfilteredlist[i]);
          }
          facilfilteredlist = tmpList;
        }

      }
    else {
      if((filter.isNotEmpty)) {
        List<Features> tmpList = [];
        for(int i=0;i<_filteredlist.length;i++) {
          if(_filteredlist[i].name.toLowerCase().contains(filter.toLowerCase()))
            tmpList.add(_filteredlist[i]);
        }
        _filteredlist = tmpList;
      }

    }




    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroSearch,
          createRectTween: (begin, end){
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: kBackgroundColor,
            elevation: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //(widget.addtext != 'addwaypt') ?
                   Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0,top: 25.0, right: 25.0, bottom: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5.0,),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                  child: Icon(Icons.arrow_back,color: kTurquoise,)
                              ),
                              Center(
                                child: Text(
                                  "Set Address",
                                  style: TextStyle(color:kTurquoise,fontSize: 18.0, fontFamily: "Brand-Bold"),
                                ),
                              )
                            ],
                          ),

                          //(widget.addtext != 'addwaypt') ?
                          Row(
                            children: [
                              Icon(Icons.search, color: kTurquoise,),
                              SizedBox(width: 18.0,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: TextField(
                                      onChanged: (val) {
                                        googleMapsAppData.searchPlaces(val);
                                        if(widget.addtext == "addwaypt")
                                          {
                                            val =  " ";
                                          }
                                      },
                                      controller: destTextEditingController,
                                      decoration: InputDecoration(
                                          hintText: "Enter a Address",
                                          fillColor: Colors.grey[400],
                                          filled: true,
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0)
                                      ),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          )
                          /*: Container()*/,


                        ],
                      ),
                    ),
                  )
                      /*: Container()*/,


                  //SizedBox(height: 10.0 ,),
                  //tile for displaying predictions lol
                  (googleMapsAppData.searchResults != null &&
                      googleMapsAppData.searchResults.length != 0 && widget.addtext != "addwaypt" && widget.addtext != "gymming" && widget.addtext != "zumba")
                      ? Container(
                    height: 400,
                    child: ListView.separated(
                      itemCount: googleMapsAppData.searchResults.length,
                      separatorBuilder: (
                          BuildContext context,
                          int index,
                          ) =>
                          DividerWidget(), //seperate with a divider..
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(children: [
                            Text(
                              googleMapsAppData.searchResults[index].main_text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, color: kTurquoise),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              googleMapsAppData.searchResults[index].secondary_text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.blueGrey),
                            ),
                          ]),
                          onTap: () {
                            getPlaceAddressDetails(googleMapsAppData.searchResults[index].placeId, context);


                            //startTextEditingController.text = startAddress;

                            //googleMapsAppData.getPlaceAddressDetails(googleMapsAppData.searchResults[index].placeId);
                          },
                        );
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                      : Container(),
                  //DATAGOVAPI HANDLE
                  (apicall != null &&
                      apicall.length != 0 && (widget.addtext == "addwaypt" || widget.addtext == "gymming"))
                      ? Container(
                    height: 400,
                    child: ListView.separated(
                      itemCount: apicall == null ? 0 : _filteredlist.length,
                      separatorBuilder: (
                          BuildContext context,
                          int index,
                          ) =>
                          DividerWidget(), //seperate with a divider..
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(children: [
                            Text(
                              _filteredlist[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, color: kTurquoise),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              LatLng(_filteredlist[index].lat,_filteredlist[index].lng).toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.blueGrey),
                            ),
                          ]),
                          onTap: () {
                            Navigator.pop(context, "${_filteredlist[index].lat},${_filteredlist[index].lng}");

                          },
                        );
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                      : Container(),
                  (facilcall != null &&
                      facilcall.length != 0 && widget.addtext == "zumba")
                      ? Container(
                    height: 400,
                    child: ListView.separated(
                      itemCount: facilcall == null ? 0 : facilfilteredlist.length,
                      separatorBuilder: (
                          BuildContext context,
                          int index,
                          ) =>
                          DividerWidget(), //seperate with a divider..
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(children: [
                            Text(
                              facilfilteredlist[index].roadname,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, color: kTurquoise),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              facilfilteredlist[index].description,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.blueGrey),
                            ),
                          ]),
                          onTap: () {
                            Navigator.pop(context, "${facilfilteredlist[index].lat},${facilfilteredlist[index].lng}");

                          },
                        );
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                      : Container(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void getPlaceAddressDetails(String placeId, context) async
  {
    showDialog(context: context,
        builder: (BuildContext context) => Loading()
    );
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?key=$GoogleAPIKey&place_id=$placeId');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    Navigator.pop(context); //pop out the loading thing.

    if (json['status'] == 'OK') {
      //var jsonResult = json['result'] as Map<String,dynamic>;
      //     return Place.fromJson(jsonResult);
      var jsonResult = json['result'] as Map<dynamic,dynamic>;
      Place newplace = Place.fromJson(jsonResult);

      //print("this is drop off location");
      //print(newplace.geometry.location.lat);
      //print(newplace.geometry.location.lng);

      if(widget.addtext == "Start")
      {
        Provider.of<GoogleMapsAppData>(context, listen: false).updateStartLocationAddress(newplace);
        Navigator.pop(context, "obtainDirection");
      }
      if(widget.addtext == "End")
      {
        Provider.of<GoogleMapsAppData>(context, listen: false).updateDestLocationAddress(newplace);
        Navigator.pop(context, "obtainDirection");
      }
      //Provider.of<GoogleMapsAppData>(context, listen: false).updateDestLocationAddress(newplace);





      //var jsonResult = json['result'] as Map<String,dynamic>;
      //return DirectionDetails.fromJson(jsonResult);

    }
  }

  Future<void> getCoordinates(String whichapi) async {

    var file;
    if (whichapi == "running") {
      file = "assets/PCN_Access_Points_googlemaps.geojson";
    } else if (whichapi == "gymming") {
      file = "assets/sggyms.geojson";
    } else {
      file = "assets/sportsFacil.json";
    }


    var jsonText = await rootBundle.loadString(file);
    //setState(() => data = json.decode(jsonText));
    Map<dynamic, dynamic> json = convert.jsonDecode(jsonText.toString());
    var jsonFeatures = json['features'] as List;

    apicall = jsonFeatures.map((place) => Features.fromJson(place)).toList();
    for(int i=0;i<apicall.length;i++){
      print("name is ${apicall[i].name}"+"${apicall[i].lat} ${apicall[i].lng}");
    }

  }
  Future<void> getFacilFeatures(String whichapi) async {

    var file;
    if (whichapi == "zumba") {
      file = "assets/sportsFacil.json";
    }

    var jsonText = await rootBundle.loadString(file);
    //setState(() => data = json.decode(jsonText));
    Map<dynamic, dynamic> json = convert.jsonDecode(jsonText.toString());
    var jsonFeatures = json['features'] as List;

    facilcall = jsonFeatures.map((place) => Facilities.fromJson(place)).toList();
    for(int i=0;i<facilcall.length;i++){
      print("name is ${facilcall[i].roadname}"+"${facilcall[i].lat} ${facilcall[i].lng}");
    }

  }
}
class CheckpointTile extends StatelessWidget {

  final Features features;

  CheckpointTile({Key key, this.features}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return TextButton(
      onPressed: ()
      {


        //getPlaceAddressDetails(placeSearch.placeId, context);
        //getting error here - can consider using the method imployed. googleMapsAppData.searchPlaces(value)
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(features.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );
  }
}

class PredictionTile extends StatelessWidget
{
  final PlaceSearch placeSearch;


  PredictionTile({Key key, this.placeSearch}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return TextButton(
      onPressed: ()
      {


        getPlaceAddressDetails(placeSearch.placeId, context);
        //getting error here - can consider using the method imployed. googleMapsAppData.searchPlaces(value)
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(placeSearch.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),),
                      SizedBox(height: 8.0,),
                      Text(placeSearch.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async
  {
    showDialog(context: context,
        builder: (BuildContext context) => Loading()
    );
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?key=$GoogleAPIKey&place_id=$placeId');
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    Navigator.pop(context); //pop out the loading thing.

    if (json['status'] == 'OK') {
      //var jsonResult = json['result'] as Map<String,dynamic>;
      //     return Place.fromJson(jsonResult);
      var jsonResult = json['result'] as Map<String,dynamic>;
      Place newplace = Place.fromJson(jsonResult);


      Provider.of<GoogleMapsAppData>(context, listen: false).updateDestLocationAddress(newplace);
      print("this is drop off location");
      print(newplace.name);

      Navigator.pop(context, "obtainDirection");

      //var jsonResult = json['result'] as Map<String,dynamic>;
      //return DirectionDetails.fromJson(jsonResult);

    }
  }
}