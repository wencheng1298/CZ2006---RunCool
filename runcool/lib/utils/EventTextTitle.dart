import 'package:flutter/material.dart';

class EventTextTitle extends StatelessWidget {
  String title;
  double fontSize;

  EventTextTitle({this.title, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: this.fontSize, color: Colors.cyan),
      ),
    );
  }
}
