import 'package:flutter/material.dart';
import 'package:runcool/firebase/notificationManager.dart';
import '../../utils/everythingUtils.dart';
import 'package:provider/provider.dart';
import '../../models/Notification.dart';
import 'notificationCards.dart';

class NotificationsWrap extends StatelessWidget {
  // final List<Widget> notifications;
  final String title;

  NotificationsWrap({@required this.title});
  @override
  Widget build(BuildContext context) {
    final List<dynamic> allNotifs = Provider.of<List<dynamic>>(context) ?? [];

    List<Widget> notifications =
        NotificationManager().getNotificationCards(allNotifs, title) ?? [];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title + "s",
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
