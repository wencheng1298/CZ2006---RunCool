import 'package:flutter/material.dart';
import './RunningUI/CreateRunningUI1.dart';
import './GymmingUI/CreateGymmingUI1.dart';
import './ZumbaUI/CreateZumbaUI1.dart';

import 'CreateEventUI.dart';
import './../../utils/everythingUtils.dart';

class ChooseEventUI extends StatefulWidget {
  @override
  ChooseEventUIState createState() => ChooseEventUIState();
}

class ChooseEventUIState extends State<ChooseEventUI> {

  bool _buttonDisabled = true;

  String eventType;
  List<String> eventTypes = ['Running', 'Gymming', 'Zumba'];

  void goNextPage(String eventChoice) {
    if (eventChoice == 'Running') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateRunningUI1()));
    } else if (eventChoice == 'Gymming') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateGymmingUI1()));
    } else if (eventChoice == "Zumba") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateZumbaUI1()));
    }
  }

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
      body: BackgroundImage(
        child: Container(
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
                    value: eventType,
                    hint: Text(
                      '--None--',
                      style: TextStyle(color: Colors.white),
                    ),
                    onChanged: (newChoice) {
                      setState(() {
                        eventType = newChoice;
                        if (_buttonDisabled) {
                          _buttonDisabled = false;
                        }
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
              //Need to change the value of _buttonDisabled and reset State
              Container(
                padding: const EdgeInsets.only(top: 50, right: 20),
                alignment: Alignment.bottomRight,
                child: OutlinedButton(
                  child: Text('Next'),
                  onPressed:
                      _buttonDisabled ? null : () => goNextPage(eventType),
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
      ),
    );
  }
}
