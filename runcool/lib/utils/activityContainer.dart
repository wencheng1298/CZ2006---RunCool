import 'package:flutter/material.dart';
import 'everythingUtils.dart';

class ActivityContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8, right:8, top:2, bottom: 1),
      child: Container(
        height: 50,
        color: Colors.grey,
        child: const Center(),
      ),
    );
  }
}
