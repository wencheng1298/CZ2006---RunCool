import 'package:flutter/material.dart';
import 'constants.dart';
import '../pages/SignUpUI/LogIn.dart';

class InputTextField2 extends StatelessWidget {
  final Function onChange;
  dynamic widget;
  final String text;
  final String variable;
  InputTextField2({this.text, this.widget, this.variable, this.onChange});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: 45,
        child: TextField(
          onChanged: (value) {
            // widget[variable] = value;
            // widget.onChange;
          },
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800].withOpacity(0.5),
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: text ?? '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class InputTextField1 extends StatefulWidget {
  final String text;
  final Function onChange;

  InputTextField1({this.text, this.onChange});
  @override
  _InputTextField1State createState() => _InputTextField1State();
}

class _InputTextField1State extends State<InputTextField1> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: 45,
        child: TextField(
          onChanged: widget.onChange,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800].withOpacity(0.5),
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.text ?? '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
