import 'package:flutter/material.dart';

class InputFieldTextTitles extends StatelessWidget {
  String _title;

  InputFieldTextTitles(this._title);  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        _title,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
