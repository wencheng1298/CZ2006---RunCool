import 'package:flutter/material.dart';
import '../../utils/screen.dart';

class FriendRequestCard extends StatelessWidget {
  final String friendNotification;
  FriendRequestCard({@required this.friendNotification});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                'https://qph.fs.quoracdn.net/main-qimg-4ef1e845d114db437e843c262834aab1'),
          ),
          GestureDetector(
            onTap: () {
              print("friend clicked");
            },
            child: Text(
              friendNotification,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          TinyButton(
            text: "Accept",
            colour: kTurquoise,
            onPress: () {
              print('accept friend request');
            },
          ), // Accept
          TinyButton(
              onPress: () {
                print('delete friend request');
              },
              text: 'Delete',
              colour: Colors.white),
        ],
      ),
    );
  }
}

class EventInviteCard extends StatelessWidget {
  final String eventNotification;
  EventInviteCard({@required this.eventNotification});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "RUN",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "NAME invited you.",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(children: [
            GestureDetector(
              onTap: () {
                print('event name in invite clicked');
              },
              child: Text(
                eventNotification,
                style: TextStyle(color: Colors.white),
              ),
            ),
            TinyButton(
              text: "Accept",
              colour: kTurquoise,
              onPress: () {
                print('accept event invite');
              },
            ), // Accept
            TinyButton(
                onPress: () {
                  print('delete event Invite');
                },
                text: 'Delete',
                colour: Colors.white),
          ]),
        ]));
  }
}

class EventUpdateCard extends StatelessWidget {
  final String eventNotification;
  EventUpdateCard({@required this.eventNotification});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text(
                  eventNotification,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  print('event name in update pressed!');
                },
              ),
              TinyButton(
                  text: 'View',
                  colour: Colors.white,
                  onPress: () {
                    print('hello');
                  })
            ],
          ),
          Text(
            "3 new messages!",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
