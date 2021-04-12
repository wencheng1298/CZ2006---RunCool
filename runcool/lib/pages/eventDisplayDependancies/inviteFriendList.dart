import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runcool/controllers/NotificationManager.dart';
import './../../models/User.dart';
import './../../utils/everythingUtils.dart';

class InviteFriendList extends StatefulWidget {
  final dynamic event;
  InviteFriendList({this.event});
  @override
  _InviteFriendListState createState() => _InviteFriendListState();
}

class _InviteFriendListState extends State<InviteFriendList> {
  String invite = "Invite";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    List<Widget> friendWidget = [];

    user.friends.forEach((friend) {
      // if (widget.event.participants
      //     .any((person) => user.friends.contains(person))) {
      if (widget.event.participants.contains(friend) ||
          friend == widget.event.creator) {
      } else {
        friendWidget.add(
          FriendInviteRow(friend, widget.event),
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

class FriendInviteRow extends StatefulWidget {
  @override
  final String friend;
  final event;
  FriendInviteRow(this.friend, this.event);
  _FriendInviteRowState createState() => _FriendInviteRowState();
}

class _FriendInviteRowState extends State<FriendInviteRow> {
  String invite = "invite";
  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<AppUser>(context);
    return user == null
        ? Container()
        : StreamBuilder<AppUser>(
            stream: AppUser.getUserFromID(widget.friend),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Row(
                      children: [
                        snapshot.data.image != ''
                            ? CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    NetworkImage(snapshot.data.image),
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
                        MinuteButton(
                          onPress: () async {
                            await NotificationManager().notifyEventInvite(
                                widget.event.eventID,
                                user.uid,
                                snapshot.data.uid);
                            setState(() {
                              invite = "Invited";
                            });
                          },
                          text: invite,
                          colour:
                              invite == "Invited" ? Colors.grey : Colors.white,
                        ),
                      ],
                    )
                  : Loading();
            });
  }
}
