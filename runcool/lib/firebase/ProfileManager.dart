import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/firebase/Service/auth.dart';

import 'authenticationManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class ProfileManager {
  final String uid;
  String newuid;

  ProfileManager({this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  updateProfile(Map profileDetails) {
    Map<String, dynamic> data =
        profileDetails.map((key, value) => MapEntry(key.toString(), value));
    users.add(data);
  }

  Future<String> createUser(
      Map profileDetails, String email, String password) async {
    try {
      dynamic uid = await AuthenticationManager()
          .registerWithEmailAndPassword(email, password);

      Map<String, dynamic> data =
          profileDetails.map((key, value) => MapEntry(key.toString(), value));
      data['notifications'] = [];
      data['events'] = [];
      data['friends'] = [];

      await users.doc(uid).set(data);
      return "success";
    } catch (e) {
      print(e.toString());
      return null;
    }
    // String userId = (await FirebaseAuth.instance.currentUser).uid;
    // newuid =
    //     FirebaseFirestore.instance.collection('users').doc(userId).toString();
    // users.doc(newuid).set(data);
  }

  Stream<AppUser> getUserFromID(docID) {
    return users
        .doc(docID)
        .snapshots()
        .map((doc) => AppUser.fromFirestore(doc));
  }

  //
  //
  // updateEvent(Map eventDetails) {
  //   //Convert to Map<String, dynamic>
  //   Map<String, dynamic> data =
  //       eventDetails.map((key, value) => MapEntry(key.toString(), value));
  //   data['deleted'] = false;
  //   events.add(data);
  // print(data);
}
// final _firestore = FirebaseFirestore.instance;
//
// void getUser() async {
//   // String user_email = AuthenticationManager.loggedInUser.email;
//   String userEmail = 'test@gmail.com';
//
//   final users = await _firestore
//       .collection('users')
//       .where('email', isEqualTo: userEmail)
//       .get();
//   // print(messages);
//   for (var user in users.docs) {
//     print("helllo");
//     print(user.data());
//   }

// await for (var snapshot in _firestore
//     .collection("users")
//     .where('email', isEqualTo: user_email)
//     .snapshots()) {
//   for (var message in snapshot.docs) {
//     print(message.data());
//   }
// }
//}
// }
//
