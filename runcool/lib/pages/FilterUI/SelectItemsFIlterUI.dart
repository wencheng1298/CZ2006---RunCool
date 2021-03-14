import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:runcool/pages/HomePageUI.dart';
import 'dart:async';

import './../HomePageUI.dart';

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
        context, MaterialPageRoute(builder: (context) => HomePageUI()));
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
/*         actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white54),
        ], */
      ),
      body: SingleChildScrollView(
        child: Container(
          color: _background,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Region',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
              SizedBox(height: 20),
              Text(
                "Date",
                style: TextStyle(color: Colors.white, fontSize: 21),
                textAlign: TextAlign.left,
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
                    "Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "End Date: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                  padding: new EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text("Activity",
                          style: TextStyle(color: Colors.white, fontSize: 21)),
                      CheckboxListTile(
                        title: const Text(
                          'Run',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        secondary: const Icon(Icons.run_circle_sharp,
                            color: Colors.white),
                        value: this._valueRun,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueRun = value;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.blue,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: const Text(
                          'Gym',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        secondary: const Icon(Icons.fitness_center,
                            color: Colors.white),
                        value: this._valueGym,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueGym = value;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.blue,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: const Text(
                          'Zumba',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        secondary: const Icon(Icons.music_note_sharp,
                            color: Colors.white),
                        value: this._valueZumba,
                        onChanged: (bool value) {
                          setState(() {
                            this._valueZumba = value;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.blue,
                      ),
                    ],
                  )),
            Container(
                    padding: const EdgeInsets.all(20),
                    width: 200,
                    child: OutlinedButton(
                      child: Text('Apply'),
                      onPressed: () => apply(),
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
      ),
    );
  }
}
