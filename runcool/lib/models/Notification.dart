import 'package:runcool/models/User.dart';
import 'package:runcool/models/Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String notificationType;
  final String notifier;
  final DateTime time;
  final String notificationID;
  // final Event event;
  // final bool eventUpdated;
  // final int noOfMessages;

  AppNotification(
      {this.notificationType, this.notifier, this.time, this.notificationID});
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
    final time = data['time'] == null ? null : data['time'].toDate();
    final notificationID = doc.id;
    switch (notificationType) {
      case 'Event Invite':
        final event = data['event'] ?? '';
        return EventInvite(
            event: event,
            notifier: notifier,
            notificationType: notificationType,
            time: time);
      case 'Event Update':
        final event = data['event'] ?? '';
        final eventUpdated = data['eventUpdated'] ?? false;
        final noOfMessages = int.parse(data['noOfMessages'] ?? "0");
        return EventUpdate(
            event: event,
            eventUpdated: eventUpdated,
            notificationType: notificationType,
            noOfMessages: noOfMessages,
            time: time);
      default:
        return AppNotification(
            notifier: notifier, notificationType: notificationType, time: time);
    }
  }
}

class EventInvite extends AppNotification {
  final String event;
  EventInvite(
      {this.event, String notifier, String notificationType, DateTime time})
      : super(
            notificationType: notificationType, notifier: notifier, time: time);
}

class EventUpdate extends AppNotification {
  final String event;
  final int noOfMessages;
  final bool eventUpdated;
  EventUpdate(
      {this.event,
      this.eventUpdated,
      this.noOfMessages,
      String notifier,
      String notificationType,
      DateTime time})
      : super(
            notificationType: notificationType, notifier: notifier, time: time);
}
