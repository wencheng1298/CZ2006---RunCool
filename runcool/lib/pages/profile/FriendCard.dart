import 'package:flutter/material.dart';
import 'package:runcool/pages/ProfileUI1.dart';
import 'package:runcool/utils/loading.dart';
import '../../models/User.dart';
import '../../utils/constants.dart';
import '../../firebase/ProfileManager.dart';

class ProfileCardStream extends StatelessWidget {
  final List friends;
  // friends.isEmpty ? ["none"] : friends
  ProfileCardStream({@required this.friends});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Widget>>(
        stream: AppUser.getFriendCards(friends.isEmpty ? ["none"] : friends),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var friendsWidgets = snapshot.data;
            print(friendsWidgets);
            return SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                // width: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  children: friendsWidgets,
                ));
          } else {
            return Loading();
          }
        });
  }
}

class FriendCard extends StatelessWidget {
  final AppUser user;
  FriendCard({@required this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileUI1(user: user))),
      child: Column(children: [
        user.image == ''
            ? Icon(Icons.account_circle, size: 60, color: kTurquoise)
            : CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.image),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            user.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        )
      ]),
    );
  }
}
