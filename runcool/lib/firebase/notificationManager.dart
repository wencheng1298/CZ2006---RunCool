import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:runcool/models/Notification.dart';
import 'package:runcool/models/User.dart';
import 'friendManager.dart';
import '../pages/notificationDependancies/notificationCards.dart';

class NotificationManager {
  final String notifId;
  NotificationManager({this.notifId});
  final friendManager = FriendManager();
  final _firestore = FirebaseFirestore.instance;

  // final String uid = 'W1UEpfkBl90eV8B6WITK';
  final String uid = "XLx1W21TqGoExTabn8LN";

  final CollectionReference notifCollection =
      FirebaseFirestore.instance.collection('notifications');
  final DocumentReference user = FirebaseFirestore.instance
      .collection('users')
      .doc('W1UEpfkBl90eV8B6WITK');

  // Future<Stream<QuerySnapshot>> get notifications async {
  //   // final users = await _firestore.collection('users').doc(uid).snapshots();
  //
  //   await for (var snapshot
  //       in _firestore.collection('users').doc(uid).snapshots()) {
  //     print(snapshot.data());
  //   }
  //
  //   // users.getData()
  // }

  List<Widget> getNotificationCards(
      List<AppNotification> notifications, String notificationType) {
    List<Widget> notifCards = [];
    for (var notification in notifications) {
      if (notification.notificationType == notificationType) {
        notifCards.add(_getCard(notification));
      }
    }
    return notifCards;
  }

  Widget _getCard(AppNotification notification) {
    if (notification.notificationType == "Friend Request") {
      return FriendRequestCard(friendNotification: notification);
    } else if (notification.notificationType == "Event Invite") {
      return EventInviteCard(eventNotification: notification);
    } else if (notification.notificationType == "Event Update") {
      return EventUpdateCard(eventNotification: notification);
    }
  }

  void createNotification(Map notificationDetails, String receiverId) async {
    Map<String, dynamic> data = notificationDetails
        .map((key, value) => MapEntry(key.toString(), value));

    // add server time and notifier to data
    data["timeStamp"] = FieldValue.serverTimestamp();
    // data["notifier"] = _firestore.doc('users/' + uid); // current logged in user
    data["notifier"] = uid;

    // change the eventid into a doc reference if it exists
    // if (data.containsKey("event")) {
    //   data["event"] = _firestore.doc('events/' + data["event"]);
    // }

    // create the notification
    final docRef = await notifCollection.add(data);

    // append the notification created under the user.
    // final notifRef = _firestore.doc('notifications/' + docRef.id);
    final notifRef = docRef.id;

    _firestore.collection('users').doc(receiverId).update({
      "notifications": FieldValue.arrayUnion([notifRef])
    });
  }

  // void getData() async {
  //   await for (var snapshot in user.snapshots()) {
  //     List<dynamic> notifications = snapshot.data()['notifications'];
  //     dynamic notifStreams =
  //         notifications.map((notif) async => await notif.get());
  //     for (var x in notifications) {
  //       dynamic notif = await x.get();
  //       print(notif.data());
  //       // dynamic f = await notif.onSnapshot();
  //       // print(f.runtimeType);
  //     }
  //     // print(notifStreams.runtimeType);
  //   }
  // }

  // Stream<List<Notification>>
  Stream<List<AppNotification>> getNotifications(List<String> notifications) {
    Stream<QuerySnapshot> path = notifCollection.where(FieldPath.documentId,
        whereIn: [
          "txrFYxedRX5OLeURIIgr",
          "AmwXRsgUdovXQSGcJREX",
          "16E8tGqNXyaOVj0YwbeB"
        ]).snapshots();
    return path.map((snapshot) {
      return snapshot.docs
          .map((doc) => AppNotification.fromFirestore(doc))
          .toList();
    });
  }

  //get users notifications
  // Stream<List<AppNotification>> getNotifications() {
  //   user.snapshots().map((DocumentSnapshot snapshot) {
  //     return snapshot.data()['notifications'].map((nid) {
  //       var ref = _firestore.collection('notifications').doc(nid).snapshots();
  //       ref.map((doc) => AppNotification.fromFirestore(doc));
  //     }).toList();
  //   });
  // }

  // AppUser getAppUserFromId(userId) async {
  //   await _firestore.collection('users').doc(userId).get();
  //   for (var message in message.docs)
  //
  // }

  // Notification _notificationListFromSnapshot(DocumentSnapshot snapshot) {
  //   dynamic notification = snapshot.data();
  //   return Notification(
  //       notificationType: notification['notificationType'],
  //       notifier: notification['notifier']);
  // }

  Future<String> reject() async {
    try {
      await notifCollection.doc(notifId).delete();
      return null;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> acceptFriendRequest(String friendId) {
    friendManager.acceptRequest(friendId, uid);
    return this.reject();
  }
}
