import 'package:flutter/material.dart';
import './../../../utils/everythingUtils.dart';
import 'package:provider/provider.dart';
import 'package:runcool/models/User.dart';

import './CreateGymAndZumbaUI2.dart';

class CreateGymmingUI1 extends StatefulWidget {
  @override
  _CreateGymmingUI1State createState() => _CreateGymmingUI1State();
}

class _CreateGymmingUI1State extends State<CreateGymmingUI1> {
  Map eventDetails = {"eventType": "Gymming"};

  void goNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGymAndZumbaUI2(eventDetails: eventDetails),
      ),
    ); //find out if need to individually create or can use and add on..
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
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
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            height: 50,
                            color: kTurquoise,
                            child: const Center(
                                child: Text('Add Workout Exercise')),
                          )),
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
