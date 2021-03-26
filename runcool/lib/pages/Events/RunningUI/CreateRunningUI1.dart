import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay/overlay.dart';
import 'package:provider/provider.dart';
import 'package:runcool/utils/DividerWidget.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/place.dart';
import 'package:runcool/utils/places_service.dart';
import './CreateRunningUI2.dart';
import './../../../utils/everythingUtils.dart';

//import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:google_api_headers/google_api_headers.dart';
//import 'package:google_maps_webservice/places.dart';

//import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:geocoder/geocoder.dart';

String API_KEY = GoogleAPIKey;
Uri PLACES_API_KEY = Uri.parse(API_KEY);

class CreateRunningUI1 extends StatefulWidget {

  final String title;
  CreateRunningUI1({Key key, this.title}) : super(key: key);

  @override
  _CreateRunningUI1State createState() => _CreateRunningUI1State();
}

class _CreateRunningUI1State extends State<CreateRunningUI1> {

  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  TextEditingController startTextEditingController = TextEditingController();
  TextEditingController destTextEditingController = TextEditingController();

  @override
  void initState() {
    final googleMapsController = Provider.of<GoogleMapsAppData>(context, listen: false);
    locationSubscription = googleMapsController.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    startTextEditingController.addListener(() { startTextEditingController.text;});
    super.initState();
  }

  @override
  void dispose() {
    final googleMapsController = Provider.of<GoogleMapsAppData>(context, listen: false);
    googleMapsController.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  Map eventDetails = {"eventType": "Running"};

  void goNextPage(details) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateRunningUI2(eventDetails: details)));
  }

    @override
  Widget build(BuildContext context) {
    final googleMapsAppData = Provider.of<GoogleMapsAppData>(context);
    //String startingAddress = googleMapsAppData.startingPlace.name;
    //startTextEditingController.text = startingAddress;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Route',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  GoogleMapPlacement(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },

                  ),
                  if (googleMapsAppData.searchResults != null &&
                      googleMapsAppData.searchResults.length != 0)
                    Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      backgroundBlendMode: BlendMode.darken,
                    ),
                  ),
                  if (googleMapsAppData.searchResults != null &&
                      googleMapsAppData.searchResults.length != 0)
                    Container(
                    height: 200,
                    child: ListView.separated(
                        itemCount: googleMapsAppData.searchResults.length,
                        separatorBuilder: (BuildContext context, int index,) => DividerWidget(), //seperate with a divider..
                        itemBuilder: (context,index){
                        return ListTile(
                          title: Column(
                            children:[
                            Text(
                              googleMapsAppData.searchResults[index].main_text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0,color: Colors.white),
                            ),
                              SizedBox(height: 3.0,),
                              Text(
                                googleMapsAppData.searchResults[index].secondary_text,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12.0,color: Colors.blueGrey),
                              ),
                            ]
                          ),
                          onTap: () {
                            googleMapsAppData.setSelectedLocation(
                              googleMapsAppData.searchResults[index].placeId
                            );
                            Place startAddress = googleMapsAppData.getPlaceSelected(googleMapsAppData.searchResults[index].placeId);
                            //startTextEditingController.text = startAddress;
                            googleMapsAppData.updateStartLocationAddress(startAddress);
                            //googleMapsAppData.getPlaceAddressDetails(googleMapsAppData.searchResults[index].placeId);
                          },
                        );
                        },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                        ),
                  ),


                ],
              ),
              Container(
                height: 410,
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Start'),
                    ),

                    Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              GoogleMapsSearchField(
                                text: (
                                Provider.of<GoogleMapsAppData>(context).startingPlace != null
                                    ? Provider.of<GoogleMapsAppData>(context).startingPlace.name
                                    :'Starting Address'
                                ), //the hint text
                                textcontroller: startTextEditingController,
                                onChange: (value) => googleMapsAppData.searchPlaces(value) ,
                              ),

                          ],
                          ),
                        ),
                    Align(
                          alignment: Alignment.topLeft,
                          child: InputFieldTextTitles('End'),
                        ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          GoogleMapsSearchField(
                            text: Provider.of<GoogleMapsAppData>(context).destPlace != null
                                ? Provider.of<GoogleMapsAppData>(context).destPlace.name
                                :'Ending Address', //the hint text
                          textcontroller: destTextEditingController,
                            onChange: (value) => googleMapsAppData.searchPlaces(value) ,
                            onTap: () async {
                              await getPlaceDirection();
                            },
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('CheckPoints'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Container(
                        height: 50,
                        color: kTurquoise,
                        child: const Center(
                          child: Text('Add CheckPoint'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20),
                    child: const Text(
                      "Estimated Distance: ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        child: Text('Next'),
                        onPressed: () => goNextPage(eventDetails),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(place.geometry.location.lat,place.geometry.location.lng),
          zoom: 14)
      )
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<GoogleMapsAppData>(context, listen: false).startingPlace;
    var finalPos = Provider.of<GoogleMapsAppData>(context, listen: false).destPlace;
    
    var startLatLng = LatLng(initialPos.geometry.location.lat, initialPos.geometry.location.lng);
    var desLatLng = LatLng(finalPos.geometry.location.lat, finalPos.geometry.location.lat);

    /*showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(message: "Please wait...",)
    );*/

    var details = await PlacesService.obtainPlaceDirectionDetails(startLatLng,desLatLng);

    print("this is encoded points: ");
    print(details.encodedPoints);

  }



}
