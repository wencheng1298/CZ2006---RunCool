import 'package:flutter/material.dart';

class EventTextDetails extends StatelessWidget {
  final String _title;

  EventTextDetails(this._title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        (_title!= null)? _title : "",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
