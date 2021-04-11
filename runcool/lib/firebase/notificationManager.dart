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

  Future<String> deleteNotification(notification) async {
    try {
      await _firestore.collection('users').doc(notification.receiver).update({
        "notifications": FieldValue.arrayRemove([notification.notificationID])
      });
      await notifCollection.doc(notification.notificationID).delete();
      return "success";
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future<String> notifyAnnouncement(
      DocumentReference eventRef, String announcer, String announcerID) async {
    DocumentSnapshot eventSnapshot = await eventRef.get();
    final event = eventSnapshot.data();
    var participants = List.from(event["participants"] ?? []);
    participants.add(event["creator"]);
    participants.remove(announcerID);

    for (var participant in participants) {
      // if (participant != announcer) {
      //   createNotification({"notificationType": "Event Update"}, participant);
      // }
      QuerySnapshot docs = await notifCollection
          .where("notificationType", isEqualTo: "Event Update")
          .where("event", isEqualTo: eventSnapshot.id)
          .where("receiver", isEqualTo: participant)
          .get();
      if (docs.size == 0) {
        createNotification({
          "notificationType": "Event Update",
          "event": eventSnapshot.id,
          "noOfMessages": 1,
          "eventUpdated": "none"
        }, participant);
      } else {
        docs.docs.forEach((element) {
          notifCollection
              .doc(element.id)
              .update({"noOfMessages": FieldValue.increment(1)});
        });
      }
    }
    return 'Success';

    // add announcement map (time, participant name, message) to the array of announcements

    // for each of the participant in the event (except for the person who made the announcement):
    // see if they have a notification with the event id and type =  event update
    // if have --> increment no Of messages
    // else --> create notification
  }

  Future<String> acceptFriendRequest(notification) async {
    await friendManager.acceptRequest(
        notification.notifier, notification.receiver);
    return this.deleteNotification(notification);
  }
}
