import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/ProfileManager.dart';

class Event {
  final String creator;
  final String eventType;
  final String name;
  final String eventID;
  final DateTime startTime;
  final List<dynamic> announcements;
  final List<dynamic> participants;
  final int noOfParticipants;
  final String description;
  final String difficulty;
  static CollectionReference events =
      FirebaseFirestore.instance.collection('events');

  Event(
      {this.creator,
      this.eventType,
      this.name,
      this.eventID,
      this.announcements,
      this.description,
      this.difficulty,
      this.noOfParticipants,
      this.participants,
      this.startTime});

  factory Event.createEventFromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    if (data == null) return null;
    final eventType = data['eventType'] ?? null;
    final name = data['name'] ?? '';
    final creator = data['creator'] ?? '';
    final eventID = doc.id;
    final participants = data['participants'] ?? [];
    final announcements = data['announcements'] ?? [];
    final startTime = (data['startTime'] != null)
        ? data['startTime'].toDate().add(Duration(hours: 8))
        : null;
    final noOfParticipants = data['noOfParticipants'] ?? 8;
    final difficulty = data['difficulty'] ?? '';
    final description = data['description'] ?? '';

    switch (eventType) {
      case 'Gymming':
        final workout = data['workout'] ?? [];
        final location = data['location'].toString();
        final duration = data['duration'] ?? 0.0;
        return GymmingEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            duration: duration,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty,
            location: location,
            workout: workout);
      case 'Zumba':
        final danceGenre = data['danceGenre'] ?? '';
        final danceMusic = data['danceMusic'] ?? [];
        final location = data['location'].toString() ?? '';
        final duration = data['duration'] ?? 0.0;
        return ZumbaEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            duration: duration,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty,
            danceGenre: danceGenre,
            danceMusic: danceMusic,
            location: location);
      case 'Running':
        final checkpoints = data['checkpoints'] ?? [];
        final startLocation = data['startLocation'].toString() ?? '';
        final endLocation = data['endLocation'].toString() ?? '';
        final estDistance = data['estDistance'] ?? '';
        final pace = data['pace'] ?? 0.0;
        return RunningEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty,
            endLocation: endLocation,
            estDistance: estDistance,
            pace: pace,
            startLocation: startLocation,
            checkpoints: checkpoints);
      default:
        return Event(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty);
    }
  }

  static Stream<dynamic> getEventData(docID) {
    return events
        .doc(docID)
        .snapshots()
        .map((doc) => Event.createEventFromFirestore(doc));
  }

  static Stream<List<dynamic>> getEvents() {
    return events.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.createEventFromFirestore(doc);
      }).toList();
    });
  }
}

class RunningEvent extends Event {
  List checkpoints;
  String startLocation;
  String endLocation;
  int estDistance;
  double pace;

  RunningEvent(
      {this.checkpoints,
      this.startLocation,
      this.endLocation,
      this.estDistance,
      this.pace,
      String name,
      String creator,
      String eventType,
      List participants,
      int noOfParticipants,
      DateTime startTime,
      String eventID,
      List announcements,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty);
}

class GymmingEvent extends Event {
  List workout;
  String location;
  double duration;

  GymmingEvent(
      {this.workout,
      this.location,
      this.duration,
      String name,
      String creator,
      String eventType,
      List participants,
      int noOfParticipants,
      DateTime startTime,
      String eventID,
      List announcements,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty);
}

class ZumbaEvent extends Event {
  List danceMusic;
  String danceGenre;
  String location;
  double duration;

  ZumbaEvent(
      {this.danceGenre,
      this.danceMusic,
      this.location,
      this.duration,
      String name,
      String creator,
      String eventType,
      List participants,
      int noOfParticipants,
      DateTime endTime,
      DateTime startTime,
      String eventID,
      List announcements,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            eventID: eventID,
            eventType: eventType,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            difficulty: difficulty);
}
