import 'package:cloud_firestore/cloud_firestore.dart';

// class AppUser {
//   final String uid;
//
//   AppUser({this.uid});
// }

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
    int age;
    try {
      if (data['age'] != null) {
        age = data['age'];
      } else {
        age = null;
      }
    } catch (e) {
      age = null;
    }

    AppUser x = AppUser(
        name: data['name'] ?? "",
        gender: data['gender'] ?? '',
        uid: doc.id,
        age: age,
        bio: data['bio'] ?? '',
        email: data['email'] ?? '',
        hobbies: data['hobbies'] ?? '',
        insta: data['insta'] ?? '',
        occupation: data['occupation'] ?? '',
        region: data['region'] ?? '',
        events: data['events'] ?? [],
        notifications: data['notifications'] ?? [],
        friends: data['friends'] ?? [],
        image: data['image'] ?? '');
    return x;
  }
}
