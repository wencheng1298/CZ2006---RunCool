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
  _CreateGymmingAndZumbaUI1State createState() =>
      _CreateGymmingAndZumbaUI1State(eventDetails);
}

class _CreateGymmingAndZumbaUI1State extends State<CreateGymmingAndZumbaUI1> {
  Map eventDetails;
  _CreateGymmingAndZumbaUI1State(this.eventDetails);
  List<Widget> workoutandSongWidgets = [];
  final _formKey = GlobalKey<FormState>(); // VALIDATE
  bool workoutEmptyError = false;

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
    if (workoutandSongWidgets.length == 0) {
      setState(() {
        workoutEmptyError = true;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreateGymAndZumbaUI2(eventDetails: eventDetails),
        ),
      ); //
    }
  }

  _getWorkoutAndMusic(BuildContext context) {
    Map tempMap;
    if (eventDetails['eventType'] == 'Gymming') {
      tempMap = {"activity": null, "repetition": null};
    } else {
      tempMap = {"songTitle": null, "songArtist": null};
    }
    final _formKey2 = GlobalKey<FormState>(); // VALIDATE

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
              child: Form(
                key: _formKey2,
                child: Column(children: [
                  InputTextFormFill(
                    obscure: false,
                    onChange: (val) {
                      (eventDetails['eventType'] == 'Gymming')
                          ? tempMap['activity'] = val
                          : tempMap['songTitle'] = val;
                    },
                    text: (eventDetails['eventType'] == 'Gymming')
                        ? "Enter Workout Activity"
                        : "Enter Song Title",
                    validate: (val) => val.isEmpty ? '*Cannot be null' : null,
                  ),
                  InputTextFormFill(
                    obscure: false,
                    onChange: (val) {
                      (eventDetails['eventType'] == 'Gymming')
                          ? tempMap['repetition'] = int.parse(val)
                          : tempMap['songArtist'] = val;
                    },
                    text: (eventDetails['eventType'] == 'Gymming')
                        ? "Enter Repetition"
                        : "Enter Song Artist",
                    validate: (eventDetails['eventType'] == 'Gymming')
                        ? (val) {
                            if (val.isEmpty) {
                              return '*Cannot be null';
                            }
                            try{
                              val = int.parse(val);
                              return null;
                            }catch(error){
                              return 'Must be a number';
                            }
                          }
                        : (val) {
                            if (val.isEmpty) {
                              return '*Cannot be null';
                            }
                            return null;
                          },
                  )
                ]),
              ),
            ),
            actions: [
              //Check this portion. The popup doesnt seem to pop
              MaterialButton(
                child: Text('Ok'),
                color: kTurquoise,
                onPressed: () {
                  if (_formKey2.currentState.validate()) {
                    (eventDetails['eventType'] == 'Gymming')
                        ? eventDetails['workout'].add(tempMap)
                        : eventDetails['danceMusic'].add(tempMap);
                    _fillWorkoutandSongWidgets();
                    Navigator.of(context).pop();
                  }
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
      resizeToAvoidBottomInset: true,
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
        child: Form(
          key: _formKey, // VALIDATE
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
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: InputTextFormFill(
                                      obscure: false,
                                      height: 50,
                                      text: 'Eg. Pop',
                                      onChange: (val) {
                                        eventDetails['danceGenre'] = val;
                                      },
                                      validate: (val) => val.isEmpty
                                          ? 'Enter the genre'
                                          : null,
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
                        Padding(
                          padding: EdgeInsets.only(left: 23, bottom: 3),
                          child: Text(
                            (workoutEmptyError)
                                ? (eventDetails['eventType'] == 'Gymming')
                                    ? '*Add an exercise'
                                    : '*Add a song'
                                : '',
                            style: TextStyle(color: Colors.red, height: 0.5),
                          ),
                        ),
                        Column(
                          children: workoutandSongWidgets,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
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
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                goNextPage(),
                              }
                          },
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
      ),
    );
  }
}
