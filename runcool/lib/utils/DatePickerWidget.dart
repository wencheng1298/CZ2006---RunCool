import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class DatePickerWidget extends StatefulWidget {
  final Function updateDate;

  DatePickerWidget({@required this.updateDate});
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date;
  
  String getText() {
    if (date == null) {
      return "Select Date";
    } else {
      final day = date.day.toString();
      final month = date.month.toString();
      final year = date.year.toString();
      return '$day/$month/$year';
    }
  }

  Future selectDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null || newDate.isBefore(initialDate)) {
      date = null;
      return;
    }
    setState(() {
      date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TinyButton(
      onPress: () async => {
        await selectDate(context),
        widget.updateDate(date.year, date.month, date.day)
        },
      text: getText(),
      colour: kTurquoise,
    );
  }
}
