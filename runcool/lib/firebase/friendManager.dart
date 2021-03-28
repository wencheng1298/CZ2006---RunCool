import 'package:cloud_firestore/cloud_firestore.dart';
import 'notificationManager.dart';
import 'notificationManager.dart';

class FriendManager {
  final _firestore = FirebaseFirestore.instance;
  final notificationManager = NotificationManager();
  void _accept(String friendId, String userId) {
    DocumentReference friendRef = _firestore.doc('users/' + friendId);

    _firestore.collection('users').doc(userId).update({
      "friends": FieldValue.arrayUnion([friendRef])
    });
  }

  void acceptRequest(String friendId, String userId) {
    this._accept(friendId, userId);
    this._accept(userId, friendId);
  }

  void sendRequest(String receiverId) {
    notificationManager
        .createNotification({"notificationType": "Friend Request"}, receiverId);
  }
}
