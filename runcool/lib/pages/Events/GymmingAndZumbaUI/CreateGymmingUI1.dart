import 'package:flutter/material.dart';
import './../../../utils/everythingUtils.dart';
import 'package:provider/provider.dart';
import 'package:runcool/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './CreateGymAndZumbaUI2.dart';

class CreateGymmingUI1 extends StatefulWidget {
  @override
  _CreateGymmingUI1State createState() => _CreateGymmingUI1State();
}

class _CreateGymmingUI1State extends State<CreateGymmingUI1> {
  Map eventDetails = {
    "eventType": "Gymming",
    "workout": [],
    "participants": [],
    "notifications": [],
  };
  List<Widget> workoutWidgets = [];

  void _fillWorkoutWidgets() {
    setState(() {
      workoutWidgets = [];
      eventDetails['workout'].forEach((workout) {
        String text = "${workout['activity']} (${workout['repetition']} reps)";
        workoutWidgets.add(ActivityContainer(text: text));
      });
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

  _getWorkout(BuildContext context) {
    Map exercise = {"activty": null, "repetition": null};
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text(
              "Enter Exercise Details",
              style: TextStyle(color: kTurquoise),
            ),
            content: SingleChildScrollView(
              child: Column(children: [
                LineTextField(
                  onChange: (val) {
                    exercise['activity'] = val;
                  },
                  hintText: "Enter Workout Activity",
                ),
                LineTextField(
                  onChange: (val) {
                    exercise['repetition'] = val;
                  },
                  hintText: "Enter Repetition",
                )
              ]),
            ),
            actions: [
              //Check this portion. The popup doesnt seem to pop
              MaterialButton(
                child: Text('Ok'),
                color: kTurquoise,
                onPressed: () {
                  eventDetails['workout'].add(exercise);
                  _fillWorkoutWidgets();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _fillWorkoutWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    eventDetails['creator'] = user.uid;

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
                        child: InputFieldTextTitles('Select a Gym'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InputTextField1(height: 35),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles('Add Workout Routine'),
                      ),
                      Column(
                        children: workoutWidgets,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 1),
                        child: GestureDetector(
                          onTap: () => _getWorkout(context),
                          child: Container(
                            height: 50,
                            color: kTurquoise,
                            child: const Center(
                                child: Text('Add Workout Exercise')),
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
