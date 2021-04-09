import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/ProfileManager.dart';

class Event {
  final String creator;
  final String eventType;
  final String name;
  final String eventID;
  final bool deleted;
  final DateTime endTime;
  final DateTime startTime;
  final List<Map<String, dynamic>> announcements;
  final List<String> participants;
  final bool openToPublic;
  final int noOfParticipants;
  final String description;
  final String difficulty;

  Event(
      {this.creator,
      this.eventType,
      this.name,
      this.eventID,
      this.announcements,
      this.deleted,
      this.description,
      this.difficulty,
      this.endTime,
      this.noOfParticipants,
      this.openToPublic,
      this.participants,
      this.startTime});
  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    // AppUser creator = ProfileManager().getUserFromID(data['creator']);
    return Event(
        eventType: data['eventType'] ?? 'Running',
        name: data['name'] ?? '',
        creator: data['creator'] ?? '',
        eventID: doc.id,
        participants: data['participants'] ?? [],
        announcements: data['announcements'] ?? [],
        startTime: data['startTime'].toDate().add(Duration(hours: 8)) ?? null,
        endTime: data['endTime'].toDate().add(Duration(hours:8)) ?? null,
        noOfParticipants: data['noOfParticipants'] ?? 8,
        difficulty: data['difficulty'] ?? '',
        description: data['description'] ?? '',
        deleted: data['deleted'] ?? false,
        openToPublic: data['openToPublic'] ?? true);
  }
}
