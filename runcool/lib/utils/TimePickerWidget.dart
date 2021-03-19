import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay time;

  String getText() {
    if (time == null) {
      return "Select Time";
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    }
  }

  Future selectTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;
    setState(() => time = newTime);
  }

  @override
  Widget build(BuildContext context) {
    return TinyButton(
      onPress: () => selectTime(context),
      text: getText(),
      colour: kTurquoise,
    );

    //     OutlinedButton(
    //   style: TextButton.styleFrom(
    //     minimumSize: Size.fromHeight(35),
    //     backgroundColor: Colors.white70,
    //     primary: _turqoise,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(15),
    //     ),
    //   ),
    //   child: FittedBox(
    //     child: Text(
    //       getText(),
    //       style: TextStyle(fontSize: 20, color: Colors.black),
    //     ),
    //   ),
    //   onPressed: () => selectTime(context),
    // );
  }
}
