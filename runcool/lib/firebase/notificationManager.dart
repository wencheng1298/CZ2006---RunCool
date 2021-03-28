import 'package:cloud_firestore/cloud_firestore.dart';
import 'friendManager.dart';

class NotificationManager {
  final String notifId;
  NotificationManager({this.notifId});
  final friendManager = FriendManager();
  final _firestore = FirebaseFirestore.instance;

  final String uid = 'W1UEpfkBl90eV8B6WITK';

  final CollectionReference notifCollection =
      FirebaseFirestore.instance.collection('notifications');
  final DocumentReference user = FirebaseFirestore.instance
      .collection('users')
      .doc('W1UEpfkBl90eV8B6WITK');

  // Future<Stream<QuerySnapshot>> get notifications async {
  //   // final users = await _firestore.collection('users').doc(uid).snapshots();
  //
  //   await for (var snapshot
  //       in _firestore.collection('users').doc(uid).snapshots()) {
  //     print(snapshot.data());
  //   }
  //
  //   // users.getData()
  // }
  void createNotification(Map eventDetails, String receiverId) async {
    Map<String, dynamic> data =
        eventDetails.map((key, value) => MapEntry(key.toString(), value));

    // add server time and notifier to data
    data["timeStamp"] = FieldValue.serverTimestamp();
    data["notifier"] = _firestore.doc('users/' + uid); // current logged in user

    // change the eventid into a doc reference if it exists
    if (data.containsKey("event")) {
      data["event"] = _firestore.doc('events/' + data["event"]);
    }

    // create the notification
    final docRef = await notifCollection.add(data);

    // append the notification created under the user.
    final notifRef = _firestore.doc('notifications/' + docRef.id);

    _firestore.collection('users').doc(receiverId).update({
      "notifications": FieldValue.arrayUnion([notifRef])
    });
  }

  void getData() async {
    await for (var snapshot in user.snapshots()) {
      List<dynamic> notifications = snapshot.data()['notifications'];
      dynamic notifStreams =
          notifications.map((notif) async => await notif.get());
      for (var x in notifications) {
        dynamic notif = await x.get();
        print(notif.data());
        // dynamic f = await notif.onSnapshot();
        // print(f.runtimeType);
      }
      // print(notifStreams.runtimeType);
    }
  }

  Future<String> reject() async {
    try {
      await notifCollection.doc(notifId).delete();
      return null;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> acceptFriendRequest(String friendId) {
    friendManager.acceptRequest(friendId, uid);
    return this.reject();
  }
}
