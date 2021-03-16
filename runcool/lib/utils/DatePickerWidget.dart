import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  Color _turqoise = Color(0xff58C5CC);
  DateTime date; 

  String getText(){
    if(date == null){
      return "Select Date";
    }
    else{
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Future selectDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date??initialDate,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null || newDate.isBefore(initialDate)){
      date = null;
      return;
    }
    setState(() {
      date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        minimumSize: Size.fromHeight(35),
        backgroundColor: Colors.white70,
        primary: _turqoise,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: FittedBox(
        child: Text(
          getText(),
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      onPressed: () => selectDate(context),
    );
  }
}
