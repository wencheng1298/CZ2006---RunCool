import 'package:flutter/material.dart';
import './../../widgets/InputTextField.dart';
import './../../widgets/InputFieldTextTitles.dart';

enum EventPrivy { public, friends_only }

class CreateRunningUI2 extends StatefulWidget {
  @override
  _CreateRunningUI2State createState() => _CreateRunningUI2State();
}

class _CreateRunningUI2State extends State<CreateRunningUI2> {
  Color _background = Color(0xff322F2F);
  Color _turqoise = Color(0xff58C5CC);

  @override
  Widget build(BuildContext context) {
    EventPrivy openTo = EventPrivy.public;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Create Running UI 2',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: _background,
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Center(
                child: Text("Put the google map here"),
              ),
            ),
            Container(
              height: 470,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child:
                          InputFieldTextTitles('Enter the name of your route')),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Date of the run'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Select Start Time'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Enter the pace of run (km/h)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Enter number of participants'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Difficulty'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Event Open to:'),
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "Public",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: EventPrivy.public,
                          groupValue: openTo,
                          onChanged: (EventPrivy value) {
                            setState(() {
                              openTo = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          "Friends Only",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: EventPrivy.friends_only,
                          groupValue: openTo,
                          onChanged: (EventPrivy value) {
                            setState(() {
                              openTo = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
