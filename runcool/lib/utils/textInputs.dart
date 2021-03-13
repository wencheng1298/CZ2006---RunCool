import 'package:flutter/material.dart';
import 'constants.dart';

class InputTextField2 extends StatelessWidget {
  final String text;
  InputTextField2({this.text});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: 45,
        child: TextField(
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
