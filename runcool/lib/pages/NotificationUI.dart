import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../utils/constants.dart';
import '../firebase/NotificationManager.dart';
import '../utils/everythingUtils.dart';
import './notificationDependancies/screen.dart';
import '../firebase/EventManagers/EventManager.dart';
import '../models/Notification.dart';
import '../models/User.dart';
import '../models/Event.dart';
// import '../firebase/ProfileManager.dart';

class NotificationUI extends StatefulWidget {
  @override
  NotificationUIState createState() => NotificationUIState();
}

class NotificationUIState extends State<NotificationUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return StreamProvider<List<dynamic>>.value(
      value: AppNotification.getNotifications(
          user.notifications.isEmpty ? ["none"] : user.notifications),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
            textAlign: TextAlign.center,
          ),
          leading: Container(),
        ),
        body: Builder(
          builder: (context) => BackgroundImage(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationsWrap(title: "Friend Request"),
                  NotificationsWrap(title: "Event Invite"),
                  NotificationsWrap(title: "Event Update")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
