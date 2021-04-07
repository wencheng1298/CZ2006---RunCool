import 'package:flutter/material.dart';
import './../EventCreatedSuccessUI.dart';

import './../../../utils/everythingUtils.dart';
import '../../../firebase/EventManagers/EventManager.dart';

enum EventPrivy { public, friends_only }

class CreateRunningUI2 extends StatefulWidget {
  final Map eventDetails;
  CreateRunningUI2({this.eventDetails});

  @override
  _CreateRunningUI2State createState() => _CreateRunningUI2State(eventDetails);
}

class _CreateRunningUI2State extends State<CreateRunningUI2>
    with SingleTickerProviderStateMixin {
  EventPrivy openTo;

  Map eventDetails;
  _CreateRunningUI2State(this.eventDetails);

  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];

  void createEvent(Map eventDetails) {
    EventManager().updateEvent(eventDetails);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EventCreatedSuccessUI(eventName: eventDetails['name'])));
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
                          eventDetails['name'] = val;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Date of the run'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: DatePickerWidget(
                        updateDate: (year, month, day) {
                          int hour = 0, minute = 0;
                          if (eventDetails.containsKey('startTime')) {
                            hour = eventDetails['startTime'].hour;
                            minute = eventDetails['startTime'].minute;
                          }
                          eventDetails['startTime'] =
                              new DateTime(year, month, day, hour, minute);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InputFieldTextTitles('Select Start Time'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TimePickerWidget(
                        updateTime: (hour, minute) {
                          int year = 0, month = 0, day = 0;
                          if (eventDetails.containsKey('startTime')) {
                            year = eventDetails['startTime'].year;
                            month = eventDetails['startTime'].month;
                            day = eventDetails['startTime'].day;
                          }
                          eventDetails['startTime'] =
                              new DateTime(year, month, day, hour, minute);
                        },
                      ),
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
                          eventDetails['pace'] = double.parse(val);
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
                          try {
                            val = double.parse(val);
                            eventDetails['noOfParticipants'] =
                                double.parse(val);
                          } catch (error) {
                            // Need find out how to catch and show error
                            eventDetails['noOfParticipants'] = 0;
                          }
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
                          value: eventDetails['difficulty'],
                          hint: Text(
                            '--None--',
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (newChoice) {
                            setState(() {
                              eventDetails['difficulty'] = newChoice;
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
                              groupValue: openTo,
                              activeColor: kTurquoise,
                              onChanged: (EventPrivy value) {
                                eventDetails['openToPublic'] = true;
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
                              activeColor: kTurquoise,
                              onChanged: (EventPrivy value) {
                                eventDetails['openToPublic'] = false;
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
                    DescriptionTextField(
                      onChange: (val) {
                        eventDetails['description'] = val;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: 80,
                      child: TinyButton(
                        onPress: () => createEvent(eventDetails), 
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
