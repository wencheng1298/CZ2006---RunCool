import 'package:flutter/material.dart';

class EventTextTitle extends StatelessWidget {
  String _title;

  EventTextTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        _title,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 24, color: Colors.cyan),
      ),
    );
  }
}
