import 'package:runcool/models/User.dart';
import 'package:runcool/models/Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String notificationType;
  final String notifier;
  final DateTime timeStamp;
  final String notificationID;
  final String receiver;
  // final Event event;
  // final bool eventUpdated;
  // final int noOfMessages;
  static final CollectionReference notifCollection =
      FirebaseFirestore.instance.collection('notifications');

  AppNotification(
      {this.notificationType,
      this.notifier,
      this.timeStamp,
      this.notificationID,
      this.receiver});
  // factory AppNotification.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data();
  //   return AppNotification(
  //       notifier: data['notifier'] ?? '',
  //       notificationType: data['notificationType'],
  //       time: data['time']);
  // }
  factory AppNotification.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    final notificationType = data['notificationType'] ?? '';
    final notifier = data['notifier'] ?? '';
    final receiver = data['receiver'] ?? '';
    final timeStamp =
        data['timeStamp'] == null ? null : data['timeStamp'].toDate();
    final notificationID = doc.id;
    switch (notificationType) {
      case 'Event Invite':
        final event = data['event'] ?? '';
        return EventInvite(
            event: event,
            notifier: notifier,
            notificationType: notificationType,
            timeStamp: timeStamp,
            receiver: receiver,
            notificationID: notificationID);
      case 'Event Update':
        final event = data['event'] ?? '';
        final eventUpdated = data['eventUpdated'] ?? "none";
        final noOfMessages = data['noOfMessages'] ?? null;
        return EventUpdate(
          event: event,
          eventUpdated: eventUpdated,
          notificationType: notificationType,
          noOfMessages: noOfMessages,
          timeStamp: timeStamp,
          receiver: receiver,
          notificationID: notificationID,
        );
      default:
        return AppNotification(
            notifier: notifier,
            notificationType: notificationType,
            timeStamp: timeStamp,
            receiver: receiver,
            notificationID: notificationID);
    }
  }

  static Stream<List<dynamic>> getNotifications(List<dynamic> notifications) {
    Stream<QuerySnapshot> path = notifCollection
        .where(FieldPath.documentId, whereIn: notifications)
        // .orderBy("timeStamp", descending: true)
        .snapshots();
    return path.map((snapshot) {
      return snapshot.docs
          .map((doc) => AppNotification.fromFirestore(doc))
          .toList();
    });
  }
}

class EventInvite extends AppNotification {
  final String event;
  EventInvite(
      {this.event,
      String notifier,
      String notificationType,
      DateTime timeStamp,
      String receiver,
      String notificationID})
      : super(
            notificationType: notificationType,
            notifier: notifier,
            timeStamp: timeStamp,
            receiver: receiver,
            notificationID: notificationID);
}

class EventUpdate extends AppNotification {
  final String event;
  final int noOfMessages;
  final String eventUpdated;
  EventUpdate(
      {this.event,
      this.eventUpdated,
      this.noOfMessages,
      String notificationType,
      DateTime timeStamp,
      String notificationID,
      String receiver})
      : super(
            notificationType: notificationType,
            timeStamp: timeStamp,
            notificationID: notificationID,
            receiver: receiver);
}
