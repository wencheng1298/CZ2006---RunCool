import 'package:flutter/material.dart';

class EventTextDetails extends StatelessWidget {
  final String _title;

  EventTextDetails(this._title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 100,
        child: Text(
          _title,
          textAlign: TextAlign.left,
          //overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
