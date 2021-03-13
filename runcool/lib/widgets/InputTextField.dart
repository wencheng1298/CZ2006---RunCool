import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final Color _turqoise = Color(0xff58C5CC);
  final String hint;

  InputTextField({this.hint});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: 35,
        child: TextField(
          autofocus: false,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _turqoise, width: 2),
              borderRadius: BorderRadius.circular(35),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _turqoise, width: 2),
              borderRadius: BorderRadius.circular(35),
            ),
            hintText: hint?? "",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}