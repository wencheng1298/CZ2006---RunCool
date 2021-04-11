import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../models/User.dart';
import './../../utils/everythingUtils.dart';

class InviteFriendList extends StatefulWidget {
  final dynamic event;
  InviteFriendList({this.event});
  @override
  _InviteFriendListState createState() => _InviteFriendListState();
}

class _InviteFriendListState extends State<InviteFriendList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    List<Widget> friendWidget = [];

    user.friends.forEach((friend) {
      if (widget.event.participants
          .any((person) => user.friends.contains(person))) {
      } else {
        friendWidget.add(
          StreamBuilder<AppUser>(
              stream: AppUser.getUserFromID(friend),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Row(
                        children: [
                          snapshot.data.image != ''
                              ? CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(snapshot.data.image),
                                )
                              : Icon(
                                  Icons.account_circle_outlined,
                                  size: 30,
                                  color: kTurquoise,
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "${snapshot.data.name}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          MinuteButton(onPress: () {}, text: "Invite"),
                        ],
                      )
                    : Loading();
              }),
        );
      }
    });

    return (friendWidget.isEmpty)
        ? Align(
            alignment: Alignment.topCenter,
            child: Text('You have no friends',
                style: TextStyle(color: Colors.white)))
        : SingleChildScrollView(
            child: Column(children: friendWidget),
          );
  }
}
