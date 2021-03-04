import 'package:flutter/material.dart';

import 'CreateEventUI.dart';

class ChooseEventUI extends StatefulWidget {
  @override
  ChooseEventUIState createState() => ChooseEventUIState();
}

class ChooseEventUIState extends State<ChooseEventUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  String eventChoice;
  List<String> eventTypes = ['Running', 'Gymming', 'Zumba'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Event',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: _background,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 200),
            Text(
              "Select Your Event Type",
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
                  value: eventChoice,
                  onChanged: (newChoice) {
                    setState(() {
                      eventChoice = newChoice;
                    });
                  },
                  items: eventTypes.map((choice) {
                    return DropdownMenuItem(
                        value: choice,
                        child: Text(
                          choice,
                        ));
                  }).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50, right: 20),
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                child: Text('Next'),
                onPressed: () {
                  print('Pressed Next');
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
