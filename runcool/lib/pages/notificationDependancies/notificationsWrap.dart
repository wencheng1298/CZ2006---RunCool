import 'package:flutter/material.dart';
import '../../utils/everythingUtils.dart';

class NotificationsWrap extends StatelessWidget {
  final List<Widget> notifications;
  final String title;

  NotificationsWrap({@required this.title, @required this.notifications});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: kTurquoise),
          ),
          Column(
            children: notifications,
          ),
        ],
      ),
    );
  }
}
