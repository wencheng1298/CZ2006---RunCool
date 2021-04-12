import 'package:flutter/material.dart';
import './../EventCreatedSuccessUI.dart';

import './../../../utils/everythingUtils.dart';
import '../../../controllers/EventManager.dart';
import './../../../models/Event.dart';

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

  final _formKey = GlobalKey<FormState>(); // VALIDATE
  bool difficultyError = false;

  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];

  void createEvent(Map eventDetails) async {
    Event event = await EventManager().createEvent(eventDetails);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EventCreatedSuccessUI(event: event)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Form(
          key: _formKey,
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
                        child: InputFieldTextTitles('Date of the run'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: DatePickerWidget(
                          date: eventDetails['startTime'],
                          updateDate: (year, month, day) {
                            setState(() {
                              int startHour = 0, startMinute = 0;
                              if (eventDetails.containsKey('startTime')) {
                                startHour = eventDetails['startTime'].hour;
                                startMinute = eventDetails['startTime'].minute;
                              }
                              eventDetails['startTime'] = new DateTime(
                                  year, month, day, startHour, startMinute);
                            });
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
                          time: eventDetails.containsKey('startTime')
                              ? TimeOfDay(
                                  hour: eventDetails['startTime'].hour,
                                  minute: eventDetails['startTime'].minute)
                              : null,
                          updateTime: (hour, minute) {
                            int year = 0, month = 0, day = 0;
                            setState(() {
                              if (eventDetails.containsKey('startTime')) {
                                year = eventDetails['startTime'].year;
                                month = eventDetails['startTime'].month;
                                day = eventDetails['startTime'].day;
                              }
                              eventDetails['startTime'] =
                                  new DateTime(year, month, day, hour, minute);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter the name of your route'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'Eg: Happy Hoo Hoo',
                          onChange: (val) {
                            eventDetails['name'] = val;
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter a name';
                            }
                            if (val.length < 8) {
                              return 'Name must have at least 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter the pace of run (km/h)'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'Eg: 5',
                          onChange: (val) {
                            eventDetails['pace'] = double.parse(val);
                          },
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter the pace';
                            }
                            try {
                              val = double.parse(val);
                              return null;
                            } catch (error) {
                              return "Enter a numeric value";
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InputFieldTextTitles(
                            'Enter number of participants'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: InputTextFormFill(
                          obscure: false,
                          text: 'minimum: 1, maximum: 8',
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
                          validate: (val) {
                            if (val.isEmpty) {
                              return 'Enter number of participants';
                            }
                            val = int.parse(val);
                            if (val < 1 || val > 8) {
                              return "There must be between 1-8 participants";
                            }
                            return null;
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
                                difficultyError = false;
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
                      Padding(
                        padding: EdgeInsets.only(left: 23, top: 4),
                        child: Text(
                          (difficultyError) ? 'Choose a difficulty' : '',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
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
                          onPress: () => {
                            print(eventDetails['difficult']),
                            if (eventDetails['difficulty'] == null)
                              {
                                difficultyError = true,
                              },
                            if (_formKey.currentState.validate())
                              {
                                if (!difficultyError)
                                  {
                                    createEvent(eventDetails),
                                  }
                              }
                          },
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
      ),
    );
  }
}
