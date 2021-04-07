// Still in testing
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/Event.dart';

class EventManager {
  final String uid;

  EventManager({this.uid});

  CollectionReference events = FirebaseFirestore.instance.collection('events');

  updateEvent(Map eventDetails) async {
    //Convert to Map<String, dynamic>
    Map<String, dynamic> data =
        eventDetails.map((key, value) => MapEntry(key.toString(), value));
    data['deleted'] = false;
    var docID = await events.add(data);
    // print("Docid: " + docID.id);
    return docID.id;
    // print(data);
  }

  // getEventById(String docID) async {
  //   var details = await events.doc(docID).get();
  //
  //   // print(details.runtimeType);
  //   // return details;
  // }
  Event _eventDataFromSnapshot(DocumentSnapshot snapshot) {
    dynamic event = snapshot.data();
    return Event(
      eventType: event['eventType'],
      name: event['name'],
    );
  }

  Stream<Event> getEventData(docID) {
    return events.doc(docID).snapshots().map(_eventDataFromSnapshot);
  }
}
