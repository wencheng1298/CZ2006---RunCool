import 'dart:ffi';

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
  final List<dynamic> announcements;
  final List<dynamic> participants;
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
  // factory Event.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data();
  //   // AppUser creator = ProfileManager().getUserFromID(data['creator']);
  //   return Event(
  //       eventType: data['eventType'] ?? 'Running',
  //       name: data['name'] ?? '',
  //       creator: data['creator'] ?? '',
  //       eventID: doc.id,
  //       participants: data['participants'] ?? [],
  //       announcements: data['announcements'] ?? [],
  //       startTime: data['startTime'] ?? null,
  //       endTime: data['endTime'] ?? null,
  //       noOfParticipants: data['noOfParticipants'] ?? 8,
  //       difficulty: data['difficulty'] ?? '',
  //       description: data['description'] ?? '',
  //       deleted: data['deleted'] ?? false,
  //       openToPublic: data['openToPublic'] ?? true);
  // }

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    final eventType = data['eventType'] ?? null;
    final name = data['name'] ?? '';
    final creator = data['creator'] ?? '';
    final eventID = doc.id;
    final participants = data['participants'] ?? [];
    final announcements = data['announcements'] ?? [];
    final startTime = (data['startTime'] != null)
        ? data['startTime'].toDate().add(Duration(hours: 8))
        : null;
    final endTime = (data['endTime'] != null)
        ? data['endTime'].toDate().add(Duration(hours: 8))
        : null;
    final noOfParticipants = data['noOfParticipants'] ?? 8;
    final difficulty = data['difficulty'] ?? '';
    final description = data['description'] ?? '';
    final deleted = data['deleted'] ?? false;
    final openToPublic = data['openToPublic'] ?? true;

    switch (eventType) {
      case 'Gymming':
        final workout = data['workout'] ?? [];
        final location = data['location'].toString();
        return GymmingEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            deleted: deleted,
            difficulty: difficulty,
            location: location,
            workout: workout);
      case 'Zumba':
        final danceGenre = data['danceGenre'] ?? '';
        final danceMusic = data['danceMusic'] ?? [];
        final location = data['location'].toString() ?? '';
        return ZumbaEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            deleted: deleted,
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
        final pace = data['pace'] ?? '';
        return RunningEvent(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            deleted: deleted,
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
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            deleted: deleted,
            description: description,
            difficulty: difficulty);
    }
  }
}

class RunningEvent extends Event {
  List checkpoints;
  String startLocation;
  String endLocation;
  int estDistance;
  Float pace;

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
      DateTime endTime,
      DateTime startTime,
      String eventID,
      bool openToPublic,
      List announcements,
      bool deleted,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            description: description,
            deleted: deleted,
            difficulty: difficulty);
}

class GymmingEvent extends Event {
  List workout;
  String location;

  GymmingEvent(
      {this.workout,
      this.location,
      String name,
      String creator,
      String eventType,
      List participants,
      int noOfParticipants,
      DateTime endTime,
      DateTime startTime,
      String eventID,
      bool openToPublic,
      List announcements,
      bool deleted,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            deleted: deleted,
            description: description,
            difficulty: difficulty);
}

class ZumbaEvent extends Event {
  List danceMusic;
  String danceGenre;
  String location;

  ZumbaEvent(
      {this.danceGenre,
      this.danceMusic,
      this.location,
      String name,
      String creator,
      String eventType,
      List participants,
      int noOfParticipants,
      DateTime endTime,
      DateTime startTime,
      String eventID,
      bool openToPublic,
      List announcements,
      bool deleted,
      String description,
      String difficulty})
      : super(
            name: name,
            participants: participants,
            noOfParticipants: noOfParticipants,
            endTime: endTime,
            eventID: eventID,
            eventType: eventType,
            openToPublic: openToPublic,
            startTime: startTime,
            announcements: announcements,
            creator: creator,
            deleted: deleted,
            description: description,
            difficulty: difficulty);
}
