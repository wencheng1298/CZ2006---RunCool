import 'package:flutter/material.dart';
import 'everythingUtils.dart';

class ActivityContainer extends StatelessWidget {
  final String text;
  
  ActivityContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 1),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[800].withOpacity(0.5),
          border: Border.all(color: kTurquoise),
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
