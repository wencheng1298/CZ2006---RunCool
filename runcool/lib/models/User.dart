import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runcool/controllers/AuthenticationManager.dart';
import 'package:runcool/pages/profileDependancies/FriendCard.dart';

class AppUser {
  final String uid;
  final String image;
  final String name;
  final String gender;
  final int age;
  final String bio;
  final String email;
  final String hobbies;
  final String insta;
  final String occupation;
  final String region;
  final List<dynamic> friends;
  final List<dynamic> notifications;
  final List<dynamic> events;
  static CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  AppUser(
      {this.uid,
      this.name,
      this.gender,
      this.age,
      this.bio,
      this.email,
      this.hobbies,
      this.insta,
      this.occupation,
      this.region,
      this.notifications,
      this.friends,
      this.events,
      this.image});
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    AppUser x = AppUser(
        name: data['name'] ?? "",
        gender: data['gender'] ?? '',
        uid: doc.id,
        age: data['age'] ?? 0,
        bio: data['bio'] ?? '',
        email: data['email'] ?? '',
        hobbies: data['hobbies'] ?? '',
        insta: data['instagram'] ?? '',
        occupation: data['occupation'] ?? '',
        region: data['region'] ?? '',
        events: data['events'] ?? [],
        notifications: data['notifications'] ?? [],
        friends: data['friends'] ?? [],
        image: data['image'] ?? '');
    return x;
  }

  static Stream<AppUser> getUserFromID(docID) {
    return _users
        .doc(docID)
        .snapshots()
        .map((doc) => AppUser.fromFirestore(doc));
  }

  static Stream<AppUser> getCurrentUserObject() {
    User currUser = AuthenticationManager().getCurrUserFromFirebase();
    return (currUser == null) ? null : getUserFromID(currUser.uid);
  }

  static Stream<List<Widget>> getFriendCards(List friends) {
    Stream<QuerySnapshot> path =
        _users.where(FieldPath.documentId, whereIn: friends).snapshots();
    return path.map((snapshot) {
      return snapshot.docs.map((doc) {
        AppUser user = AppUser.fromFirestore(doc);

        return FriendCard(user: user);
      }).toList();
    });
  }
}
