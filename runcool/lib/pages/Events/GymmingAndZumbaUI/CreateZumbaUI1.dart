import 'package:flutter/material.dart';
import 'package:runcool/pages/Events/GymmingAndZumbaUI/CreateGymAndZumbaUI2.dart';
import 'package:runcool/utils/GoogleMapPlacement.dart';
import '../../../utils/everythingUtils.dart';

class CreateZumbaUI1 extends StatefulWidget {
  @override
  _CreateZumbaUI1State createState() => _CreateZumbaUI1State();
}

class _CreateZumbaUI1State extends State<CreateZumbaUI1> {
  Map eventDetails = {"eventType": "Zumba"};

  void goNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateGymAndZumbaUI2(
                  eventDetails: eventDetails,
                ))); //find out if need to individually create or can use and add on..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Dance',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: kBackgroundColor,
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
                      child: InputFieldTextTitles('Select a Sports Hall'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: InputTextField1(height: 35),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Indicate the Dance Genre'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: InputTextField1(
                        height: 35,
                        onChange: (val) {
                          eventDetails['danceGenre'] = val;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Add Dance Music'),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          height: 50,
                          color: kTurquoise,
                          child: const Center(child: Text('Add Dance Music')),
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
    );
  }
}
