import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../utils/constants.dart';
import '../firebase/notificationManager.dart';
import '../utils/everythingUtils.dart';
import './notificationDependancies/screen.dart';
import '../firebase/EventManagers/EventManager.dart';
import '../models/Notification.dart';
import '../models/Event.dart';
// import '../firebase/ProfileManager.dart';

class NotificationUI extends StatefulWidget {
  @override
  NotificationUIState createState() => NotificationUIState();
}

class NotificationUIState extends State<NotificationUI> {
  List<Widget> requestWidgets = [];
  List<Widget> inviteWidgets = [];
  List<Widget> updateWidgets = [];
  List<String> requests = ['Paula', 'Eugene', 'Sarah'];
  List<String> invites = ['North Horizon'];
  List<String> updates = ['Event 1', 'Event 2'];
  // TODO: replace with actual lists of notification class from database/ entities

  void _fillLists() {
    setState(() {
      requests.forEach((element) {
        requestWidgets.add(FriendRequestCard(friendNotification: element));
      });
      invites.forEach((element) {
        inviteWidgets.add(EventInviteCard(
          eventNotification: element,
        ));
      });
      updates.forEach((element) {
        updateWidgets.add(EventUpdateCard(eventNotification: element));
      });
    });
  }

  @override
  void initState() {
    _fillLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AppNotification>>.value(
      value: NotificationManager().getNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
            textAlign: TextAlign.center,
          ),
          leading: Container(),
        ),
        body: BackgroundImage(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "hello",
                  style: TextStyle(color: Colors.white),
                ),
                NotificationsWrap(
                    title: "Friend Requests", notifications: requestWidgets),
                NotificationsWrap(
                    title: "Event Invites", notifications: inviteWidgets),
                NotificationsWrap(
                    title: "Event Updates", notifications: updateWidgets)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
