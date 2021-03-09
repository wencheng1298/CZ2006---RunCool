import 'package:flutter/material.dart';

class EventTextDetails extends StatelessWidget {
  String _title;

  EventTextDetails(this._title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        _title,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
