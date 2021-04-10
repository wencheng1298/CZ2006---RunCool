import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:runcool/pages/profile/FriendCard.dart';
import 'package:runcool/pages/profile/profileList.dart';

import 'authenticationManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class ProfileManager {
  final String uid;
  String newuid;

  ProfileManager({this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  AuthenticationManager authManager = AuthenticationManager();

  updateProfile(Map profileDetails) {
    Map<String, dynamic> data =
        profileDetails.map((key, value) => MapEntry(key.toString(), value));
    users.add(data);
  }

  Future<String> createUser(
      Map profileDetails, String email, String password) async {
    try {
      dynamic user =
          await authManager.registerWithEmailAndPassword(email, password);
      Map<String, dynamic> data =
          profileDetails.map((key, value) => MapEntry(key.toString(), value));
      data['notifications'] = [];
      data['events'] = [];
      data['friends'] = [];
      data['email'] = user.email;

      await users.doc(user.uid).set(data);
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

  Stream<AppUser> getCurrentUserObject() {
    User currUser = authManager.getCurrUserFromFirebase();

    return (currUser == null) ? null : getUserFromID(currUser.uid);
  }

  Stream<List<Widget>> getFriendCards(List friends) {
    Stream<QuerySnapshot> path =
        users.where(FieldPath.documentId, whereIn: friends).snapshots();
    return path.map((snapshot) {
      return snapshot.docs.map((doc) {
        AppUser user = AppUser.fromFirestore(doc);

        return FriendCard(user: user);
      }).toList();
    });
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
