import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'dart:async';

import './../EventPage.dart';

class SelectItemsFIlterUI extends StatefulWidget {
  @override
  _SelectItemsFIlterUIState createState() => _SelectItemsFIlterUIState();
}

class _SelectItemsFIlterUIState extends State<SelectItemsFIlterUI> {
  Color _background = Color(0xff1f1b24);
  Color _turqoise = Color(0xff58C5CC);

  bool _buttonDisabled1 = true;

  bool _valueRun = false;
  bool _valueGym = false;
  bool _valueZumba = false;

  String regionChoice;
  List<String> regionChoices = ['north-east', 'central', 'south-east'];

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year),
        lastDate: new DateTime(DateTime.now().year + 1));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  void apply() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EventPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Filter Your Search',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white54),
        ],
      ),
      body: Center(
        //let the app be scrollable
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 200),
              Text(
                "Region",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.grey.shade700,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined),
                    iconSize: 36,
                    isExpanded: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    value: regionChoice,
                    hint: Text(
                      '--None--',
                      style: TextStyle(color: Colors.white),
                    ),
                    onChanged: (newChoice) {
                      setState(() {
                        regionChoice = newChoice;
                        if (_buttonDisabled1) {
                          _buttonDisabled1 = false;
                        }
                      });
                    },
                    items: regionChoices.map((choice) {
                      return DropdownMenuItem(
                          value: choice,
                          child: Text(
                            choice,
                          ));
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 200),
              Text(
                "Date",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Select Dates"),
                onPressed: () async {
                  await displayDateRangePicker(context);
                },
              ),
              Column(
                children: <Widget>[
                  Text(
                      "Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}"),
                  Text(
                      "End Date: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}"),
                ],
              ),
              Container(
                  padding: new EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text("Activity",
                          style: TextStyle(color: Colors.white, fontSize: 21)),
                      CheckboxListTile(
                        secondary: const Icon(Icons.run_circle_sharp),
                        title: const Text('Run'),
                        value: this._valueRun,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueRun = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        secondary: const Icon(Icons.fitness_center),
                        title: const Text('Gym'),
                        value: this._valueGym,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueGym = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        secondary: const Icon(Icons.music_note_sharp),
                        title: const Text('Zumba'),
                        value: this._valueZumba,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueZumba = value;
                          });
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
