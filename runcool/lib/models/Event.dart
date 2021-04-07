import 'User.dart';

class Event {
  final AppUser creator;
  final String eventType;
  final String name;
  final String eventID;

  Event({this.creator, this.eventType, this.name, this.eventID});
}
