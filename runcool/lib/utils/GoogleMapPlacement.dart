import 'package:flutter/material.dart';

class GoogleMapPlacement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Center(
        child: Text("Put the google map here"),
      ),
    );
  }
}
