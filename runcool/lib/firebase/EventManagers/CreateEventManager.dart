// Still in testing
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEventManager{

  final String uid;

  CreateEventManager({this.uid});

  CollectionReference events = FirebaseFirestore.instance.collection('events');

  updateEvent(Map eventDetails){
    //Convert to Map<String, dynamic>
    Map<String, dynamic> data = eventDetails.map((key,value)=>MapEntry(key.toString(), value));
    
    // events.add(data);
  }
}
