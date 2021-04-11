import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:runcool/models/Notification.dart';
import 'package:runcool/models/User.dart';
import 'friendManager.dart';
import '../pages/notificationDependancies/notificationCards.dart';

class NotificationManager {
  final friendManager = FriendManager();
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference notifCollection =
      FirebaseFirestore.instance.collection('notifications');

  List<Widget> getNotificationCards(
      List<dynamic> notifications, String notificationType) {
    List<Widget> notifCards = [];
    for (var notification in notifications) {
      if (notification.notificationType == notificationType) {
        notifCards.add(_getCard(notification));
      }
    }
    return notifCards;
  }

  Widget _getCard(dynamic notification) {
    if (notification.notificationType == "Friend Request") {
      return FriendRequestCard(friendNotification: notification);
    } else if (notification.notificationType == "Event Invite") {
      return EventInviteCard(eventNotification: notification);
    } else if (notification.notificationType == "Event Update") {
      return EventUpdateCard(eventNotification: notification);
    }
  }

  Future createNotification(Map notificationDetails, String receiverId) async {
    Map<String, dynamic> data = notificationDetails
        .map((key, value) => MapEntry(key.toString(), value));

    // add server time to data
    data["timeStamp"] = FieldValue.serverTimestamp();
    data["receiver"] = receiverId;

    // data["event"] = _firestore.doc('events/' + data["event"]);

    // create the notification
    final docRef = await notifCollection.add(data);

    // append the notification created under the user.
    final notifId = docRef.id;
    await _firestore.collection('users').doc(receiverId).update({
      "notifications": FieldValue.arrayUnion([notifId])
    });
  }

  Future<String> reject(notification) async {
    try {
      await _firestore.collection('users').doc(notification.receiver).update({
        "notifications": FieldValue.arrayRemove([notification.notificationID])
      });
      await notifCollection.doc(notification.notificationID).delete();
      return null;
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  Future<String> acceptFriendRequest(notification) async {
    await friendManager.acceptRequest(
        notification.notifier, notification.receiver);
    return this.reject(notification);
  }
}
