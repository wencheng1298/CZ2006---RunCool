import 'package:cloud_firestore/cloud_firestore.dart';
import 'NotificationManager.dart';

class FriendManager {
  final _firestore = FirebaseFirestore.instance;
  // final notificationManager = NotificationManager();

  Future _accept(String friendId, String userId) async {
    await _firestore.collection('users').doc(userId).update({
      "friends": FieldValue.arrayUnion([friendId])
    });
  }

  Future<String> acceptRequest(String friendId, String userId) async {
    try {
      await this._accept(friendId, userId);
      await this._accept(userId, friendId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> sendRequest(String receiverId, String senderId) async {
    try {
      await NotificationManager().createNotification(
          {"notificationType": "Friend Request", "notifier": senderId},
          receiverId);
      return "success";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
