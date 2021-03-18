import 'package:flutter/material.dart';
import './../EventCreatedSuccessUI.dart';

import './../../../utils/everythingUtils.dart';
enum EventPrivy { public, friends_only }

class CreateRunningUI2 extends StatefulWidget {
  @override
  _CreateRunningUI2State createState() => _CreateRunningUI2State();
}

class _CreateRunningUI2State extends State<CreateRunningUI2>
    with SingleTickerProviderStateMixin {
  Color _background = Color(0xff1f1b24);
  Color _turqoise = Color(0xff58C5CC);
  EventPrivy openTo;

  void createEvent() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EventCreatedSuccessUI()));
  }

  @override
  Widget build(BuildContext context) {
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
            GoogleMapPlacement(),
            SizedBox(height: 10),
            Container(
              height: 470,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Enter the name of your route'),
                  ),
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
                    child: DatePickerWidget(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Select Start Time'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TimePickerWidget(),
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
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white24),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Public",
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: Radio(
                            value: EventPrivy.public,
                            groupValue: openTo,
                            activeColor: _turqoise,
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
                            activeColor: _turqoise,
                            onChanged: (EventPrivy value) {
                              setState(() {
                                openTo = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Description'),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    maxLines: 10,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding:
                          EdgeInsets.only(left: 14, bottom: 8, top: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _turqoise, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white10, width: 2),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 80,
                    child: OutlinedButton(
                      child: Text('Create'),
                      onPressed: () => createEvent(),
                      style: TextButton.styleFrom(
                          backgroundColor: _turqoise,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
