import 'authenticationManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileManager {
  final _firestore = FirebaseFirestore.instance;

  void getUser() async {
    // String user_email = AuthenticationManager.loggedInUser.email;
    String userEmail = 'test@gmail.com';

    final users = await _firestore
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
    // print(messages);
    for (var user in users.docs) {
      print("helllo");
      print(user.data());
    }

    // await for (var snapshot in _firestore
    //     .collection("users")
    //     .where('email', isEqualTo: user_email)
    //     .snapshots()) {
    //   for (var message in snapshot.docs) {
    //     print(message.data());
    //   }
    // }
  }
}
