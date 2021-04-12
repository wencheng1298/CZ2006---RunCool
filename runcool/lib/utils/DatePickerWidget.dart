import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';

class DatePickerWidget extends StatefulWidget {
  final Function updateDate;
  final DateTime date;

  DatePickerWidget({@required this.updateDate, this.date});
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState(date);
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date;
  _DatePickerWidgetState(this.date);

  bool error = false;

  String getText() {
    if (date == null) {
      return "Select Date";
    } else if  (date.isBefore(DateTime.now())){
      error = true;
      return 'Date must be in the future';
    } else {
      final day = date.day.toString();
      final month = date.month.toString();
      final year = date.year.toString();
      error = false;
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
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          child: child,
          data: ThemeData.dark(),
        );
      },
    );
    if (newDate == null) {
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
      colour: (error)
      ? Colors.redAccent
      : kTurquoise,
    );
  }
}
