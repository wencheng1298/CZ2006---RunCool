import 'package:runcool/models/User.dart';
import 'package:runcool/models/Event.dart';

class Notification {
  final String notificationType;
  final AppUser notifier;
  final DateTime time;
  final Event event;
  // final bool eventUpdated;
  // final int noOfMessages;

  Notification({this.notificationType, this.notifier, this.time, this.event});
}
