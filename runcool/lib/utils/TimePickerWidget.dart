import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class TimePickerWidget extends StatefulWidget {
  final Function updateTime;

  TimePickerWidget({@required this.updateTime});

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
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          child: child,
          data: ThemeData.dark(),
        );
      },
    );

    if (newTime == null) return;
    setState(() => time = newTime);
  }

  @override
  Widget build(BuildContext context) {
    return TinyButton(
      onPress: () async => {
        await selectTime(context),
        widget.updateTime(time.hour, time.minute),
      },
      text: getText(),
      colour: kTurquoise,
    );
  }
}
