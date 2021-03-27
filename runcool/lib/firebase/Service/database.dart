import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // Future updateUserData(String email, String password) async {
  //   return await users.doc(uid).set({'email': email, 'password': password});
  // }

  Future updateUserData(
    String email,
    String password,
    // String name,
    // int age,
    // String gender,
    // String hobbies,
    // String region,
    // String occupation,
    // String insta,
    // String bio,
  ) async {
    return await users.doc(uid).set({
      'email': email,
      'password': password,
      // 'name': name,
      // 'age': age,
      // 'gender': gender,
      // 'hobbies': hobbies,
      // 'region': region,
      // 'occupation': occupation,
      // 'insta': insta,
      // 'bio': bio
    });
  }

  // Future updateExtraUserData(
  //   String name,
  //   int age,
  //   String gender,
  //   String hobbies,
  //   String region,
  //   String occupation,
  //   String insta,
  //   String bio,
  // ) async {
  //   return await users.doc(uid).set({
  //     'name': name,
  //     'age': age,
  //     'gender': gender,
  //     'hobbies': hobbies,
  //     'region': region,
  //     'occupation': occupation,
  //     'insta': insta,
  //     'bio': bio
  //   });
  // }

  Stream<QuerySnapshot> get userSnapshot {
    return users.snapshots();
  }
}
