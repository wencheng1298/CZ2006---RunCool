import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/everythingUtils.dart';
import 'package:provider/provider.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'CreateGymAndZumbaUI2.dart';

class CreateGymmingAndZumbaUI1 extends StatefulWidget {
  final Map eventDetails;
  CreateGymmingAndZumbaUI1({this.eventDetails});

  @override
  _CreateGymmingAndZumbaUI1State createState() => _CreateGymmingAndZumbaUI1State(eventDetails);
}

class _CreateGymmingAndZumbaUI1State extends State<CreateGymmingAndZumbaUI1> {
  Map eventDetails;
  _CreateGymmingAndZumbaUI1State(this.eventDetails);
  List<Widget> workoutandSongWidgets = [];

  void _initVariables() {
    (eventDetails['eventType'] == 'Gymming')
        ? eventDetails["workout"] = []
        : eventDetails['danceMusic'] = [];

    eventDetails["participants"] = [];
    eventDetails["notifications"] = [];
  }

  void _fillWorkoutandSongWidgets() {
    setState(() {
      workoutandSongWidgets = [];
      if (eventDetails['eventType'] == 'Gymming') {
        eventDetails['workout'].forEach((workout) {
          String text =
              "${workout['activity']} (${workout['repetition']} reps)";
          workoutandSongWidgets.add(ActivityContainer(text: text));
        });
      } else if (eventDetails['eventType'] == 'Zumba') {
        eventDetails['danceMusic'].forEach((song) {
          String text = "${song['songTitle']} by ${song['songArtist']}";
          workoutandSongWidgets.add(ActivityContainer(text: text));
        });
      }
    });
  }

  void goNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGymAndZumbaUI2(eventDetails: eventDetails),
      ),
    ); //find out if need to individually create or can use and add on..
  }

  _getWorkoutAndMusic(BuildContext context) {
    Map tempMap;
    if (eventDetails['eventType'] == 'Gymming') {
      tempMap = {"activity": null, "repetition": null};
    } else {
      tempMap = {"songTitle": null, "songArtist": null};
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text(
              (eventDetails['eventType'] == 'Gymming')
                  ? "Enter Exercise Details"
                  : "Enter Music Details",
              style: TextStyle(color: kTurquoise),
            ),
            content: SingleChildScrollView(
              child: Column(children: [
                LineTextField(
                  onChange: (val) {
                    (eventDetails['eventType'] == 'Gymming')
                        ? tempMap['activity'] = val
                        : tempMap['songTitle'] = val;
                  },
                  hintText: (eventDetails['eventType'] == 'Gymming')
                      ? "Enter Workout Activity"
                      : "Enter Song Title",
                ),
                LineTextField(
                  onChange: (val) {
                    (eventDetails['eventType'] == 'Gymming')
                        ? tempMap['repetition'] = val
                        : tempMap['songArtist'] = val;
                  },
                  hintText: (eventDetails['eventType'] == 'Gymming')
                      ? "Enter Repetition"
                      : "Enter Song Artist",
                )
              ]),
            ),
            actions: [
              //Check this portion. The popup doesnt seem to pop
              MaterialButton(
                child: Text('Ok'),
                color: kTurquoise,
                onPressed: () {
                  (eventDetails['eventType'] == 'Gymming')
                  ? eventDetails['workout'].add(tempMap)
                  : eventDetails['danceMusic'].add(tempMap);
                  _fillWorkoutandSongWidgets();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _initVariables();
    _fillWorkoutandSongWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Routine',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: BackgroundImage(
        child: Container(
          child: Column(
            children: [
              GoogleMapPlacement(),
              Container(
                  height: 410,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: (eventDetails['eventType'] == 'Gymming')
                            ? InputFieldTextTitles('Select a Gym')
                            : InputFieldTextTitles('Select a Sports Hall'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InputTextField1(height: 35),
                      ),
                      (eventDetails['eventType'] == 'Zumba')
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputFieldTextTitles(
                                    'Indicate the dance genre'),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: InputTextField1(
                                    height: 35,
                                    onChange: (val) {
                                      eventDetails['danceGenre'] = val;
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: (eventDetails['eventType'] == 'Gymming')
                            ? InputFieldTextTitles('Workout Routine')
                            : InputFieldTextTitles('Dance Music'),
                      ),
                      Column(
                        children: workoutandSongWidgets,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 1),
                        child: GestureDetector(
                          onTap: () => _getWorkoutAndMusic(context),
                          child: Container(
                            height: 50,
                            color: kTurquoise,
                            child: Center(
                              child: (eventDetails['eventType'] == 'Gymming')
                                  ? Text('Add Workout Exercise')
                                  : Text('Add Dance Music'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        child: Text('Next'),
                        onPressed: () => goNextPage(),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
