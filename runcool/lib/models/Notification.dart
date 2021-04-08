import 'package:runcool/models/User.dart';
import 'package:runcool/models/Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String notificationType;
  final String notifier;
  final DateTime time;
  final Event event;
  // final bool eventUpdated;
  // final int noOfMessages;

  AppNotification(
      {this.notificationType, this.notifier, this.time, this.event});
  factory AppNotification.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return AppNotification(
        notifier: data['notifier'] ?? '',
        notificationType: data['notificationType'],
        time: data['time']);
  }
}
