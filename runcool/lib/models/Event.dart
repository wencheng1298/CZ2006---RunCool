import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final AppUser creator;
  final String eventType;
  final String name;
  final String eventID;

  Event({this.creator, this.eventType, this.name, this.eventID});
  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Event(
      eventType: data['eventType'] ?? '',
      name: data['name'],
    );
  }
}
