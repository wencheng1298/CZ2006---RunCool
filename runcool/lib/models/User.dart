import 'package:cloud_firestore/cloud_firestore.dart';

// class AppUser {
//   final String uid;
//
//   AppUser({this.uid});
// }

class AppUser {
  final String uid;
  final String name;
  final String gender;
  final int age;
  final String bio;
  final String email;
  final String hobbies;
  final String insta;
  final String occupation;
  final String region;
  final List<String> friends;
  final List<String> notifications;
  final List<Map<String, dynamic>> events;

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
      this.events});
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    print("HELLO");
    // print(data['age'].runtimeType);
    return AppUser(
      name: data['name'] ?? "",
      gender: data['gender'] ?? '',
      uid: doc.id,
      age: int.parse(data['age']) ?? 18,
      bio: data['bio'] ?? '',
      email: data['email'] ?? '',
      hobbies: data['hobbies'] ?? '',
      insta: data['insta'] ?? '',
      occupation: data['occupation'] ?? '',
      region: data['region'] ?? '',
      events: data['events'] ?? [],
      notifications: data['notifications'] ?? [],
      friends: data['friends'] ?? [],
    );
  }
}
