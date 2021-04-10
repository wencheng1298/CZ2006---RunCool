import 'package:flutter/material.dart';
import 'package:runcool/firebase/EventManagers/EventManager.dart';
import 'package:runcool/firebase/ProfileManager.dart';
import 'package:runcool/firebase/notificationManager.dart';
import 'package:runcool/main.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/models/Event.dart';
import 'package:runcool/pages/Events/EventPage.dart';
import '../../utils/everythingUtils.dart';
import '../../models/Notification.dart';

final double mainFontSize = 20;
final notifManager = NotificationManager();

class FriendRequestCard extends StatelessWidget {
  final AppNotification friendNotification;
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
          StreamBuilder<AppUser>(
              stream: AppUser.getUserFromID(friendNotification.notifier),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AppUser friend = snapshot.data;
                  return Row(
                    children: [
                      (friend.image == '')
                          ? Icon(Icons.account_circle,
                              size: 50, color: kTurquoise)
                          : CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(friend.image),
                            ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          print("friend somee clicked");
                        },
                        child: Text(
                          friend.name,
                          style: TextStyle(
                              color: Colors.white, fontSize: mainFontSize),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Loading();
                }
              }),
          // ButtonBar(children: [
          Row(
            children: [
              TinyButton(
                text: "Accept",
                colour: kTurquoise,
                onPress: () {
                  NotificationManager().acceptFriendRequest(friendNotification);
                },
              ),
              SizedBox(width: 5),
              TinyButton(
                  onPress: () {
                    print('delete event Invite');
                  },
                  text: 'Delete'),
            ],
          ), // Accept

          // ]),
        ],
      ),
    );
  }
}

class EventInviteCard extends StatelessWidget {
  final dynamic eventNotification;
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
        child: StreamBuilder<dynamic>(
            stream: EventManager().getEventData(eventNotification.event),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var event = snapshot.data;
                return Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.eventType,
                        style: TextStyle(color: Colors.white),
                      ),
                      StreamBuilder<AppUser>(
                          stream: AppUser.getUserFromID(event.creator),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data.name + " invited you.",
                                style: TextStyle(color: Colors.white),
                              );
                            } else {
                              return Loading();
                            }
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EventPage(event: event)));
                        },
                        child: Text(
                          event.name,
                          style: TextStyle(
                              color: Colors.white, fontSize: mainFontSize),
                        ),
                      ),
                      Row(children: [
                        TinyButton(
                          text: "Join",
                          colour: kTurquoise,
                          onPress: () {
                            // "Accept "
                          },
                        ),
                        SizedBox(width: 5),
                        TinyButton(
                            onPress: () {
                              print('delete event Invite');
                            },
                            text: 'Delete',
                            colour: Colors.white),
                      ]),
                    ],
                  ),
                ]);
              } else {
                return Loading();
              }
            }));
  }
}

class EventUpdateCard extends StatelessWidget {
  final dynamic eventNotification;
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
      child: StreamBuilder<dynamic>(
          stream: EventManager().getEventData(eventNotification.event),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var event = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          event.name,
                          style: TextStyle(
                              color: Colors.white, fontSize: mainFontSize),
                        ),
                        onTap: () {
                          print('event name in update pressed!');
                        },
                      ),
                      TinyButton(
                          text: 'View',
                          colour: Colors.white,
                          onPress: () {
                            // notifManager.reject();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EventPage(event: event)));
                          })
                    ],
                  ),
                  eventNotification.noOfMessages == null
                      ? Container()
                      : Text(
                          eventNotification.noOfMessages.toString() +
                              " new messages!",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                  SizedBox(height: 5),
                  !eventNotification.eventUpdated
                      ? Container()
                      : Text(
                          "Event updated by creator!",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.green),
                        ),
                ],
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
