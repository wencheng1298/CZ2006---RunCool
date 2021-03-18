import 'dart:ffi';

import 'package:flutter/gestures.dart';
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
  EventPrivy openToPublic;
  var name;
  var pace;
  var noOfParticipants;
  var difficulty;
  var description;

  List<String> difficultyLevels = ['easy', 'medium', 'hard'];

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
      body: BackgroundImage(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                      child:
                          InputFieldTextTitles('Enter the name of your route'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: InputTextField1(
                        height: 35,
                        onChange: (val) {
                          name = val;
                        },
                      ),
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
                      child:
                          InputFieldTextTitles('Enter the pace of run (km/h)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: NumberTextField(
                        height: 35,
                        onChange: (val) {
                          pace = double.parse(val);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child:
                          InputFieldTextTitles('Enter number of participants'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: NumberTextField(
                        height: 35,
                        onChange: (val) {
                          noOfParticipants = double.parse(val);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Difficulty'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: kTurquoise, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton(
                          dropdownColor: Colors.grey[800].withOpacity(0.9),
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: kTurquoise,
                          ),
                          iconSize: 26,
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          value: difficulty,
                          hint: Text(
                            '--None--',
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (newChoice) {
                            setState(() {
                              difficulty = newChoice;
                            });
                          },
                          items: difficultyLevels.map((choice) {
                            return DropdownMenuItem(
                                value: choice,
                                child: Text(
                                  choice,
                                ));
                          }).toList(),
                        ),
                      ),
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
                              groupValue: openToPublic,
                              activeColor: kTurquoise,
                              onChanged: (EventPrivy value) {
                                setState(() {
                                  openToPublic = value;
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
                              groupValue: openToPublic,
                              activeColor: kTurquoise,
                              onChanged: (EventPrivy value) {
                                setState(() {
                                  openToPublic = value;
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
                    DescriptionTextField(
                      onChange: (val) {
                        description = val;
                        print(description);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: 80,
                      child: TinyButton(
                        onPress: createEvent,
                        text: "Create",
                        colour: kTurquoise,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
