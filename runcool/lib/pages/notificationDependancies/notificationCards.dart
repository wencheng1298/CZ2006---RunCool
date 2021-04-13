import 'package:flutter/material.dart';
import 'package:runcool/controllers/EventManager.dart';
import 'package:runcool/controllers/NotificationManager.dart';
import 'package:runcool/models/Event.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/pages/EventPageUI.dart';
import '../../utils/everythingUtils.dart';
import '../../models/Notification.dart';
import '../profileDependancies/ProfileUI1.dart';

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileUI1(
                                      user: friend, requested: true)));
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
                onPress: () async {
                  var res = await notifManager
                      .acceptFriendRequest(friendNotification);
                  if (res != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('You have successfully added a new friend!'),
                    ));
                  }
                },
              ),
              SizedBox(width: 5),
              TinyButton(
                  onPress: () {
                    notifManager.deleteNotification(friendNotification);
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
            stream: Event.getEventData(eventNotification.event),
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
                                  builder: (context) => EventPage(
                                      eventID: event.eventID, invited: true)));
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
                            notifManager.acceptInvite(eventNotification);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('You have successfully joined a event'),
                            ));
                          },
                        ),
                        SizedBox(width: 5),
                        TinyButton(
                            onPress: () {
                              notifManager
                                  .deleteNotification(eventNotification);
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
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eventNotification.eventUpdated == "deleted"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        eventNotification.event,
                        style: TextStyle(
                            color: Colors.white, fontSize: mainFontSize),
                      ),
                    ),
                    TinyButton(
                        text: 'Delete',
                        colour: Colors.white,
                        onPress: () {
                          notifManager.deleteNotification(eventNotification);
                        }),
                    // Container(),
                  ],
                )
              : StreamBuilder<dynamic>(
                  stream: Event.getEventData(eventNotification.event),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var event = snapshot.data;
                      return Row(
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
                                notifManager
                                    .deleteNotification(eventNotification);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventPage(eventID: event.eventID)));
                              })
                        ],
                      );
                    } else {
                      return Loading();
                    }
                  }),
          eventNotification.noOfMessages == 0
              ? Container()
              : Text(
                  eventNotification.noOfMessages.toString() + " new messages!",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.redAccent),
                ),
          SizedBox(height: 5),
          eventNotification.eventUpdated == "none"
              ? Container()
              : Text(
                  "Event ${eventNotification.eventUpdated} by creator!",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.green),
                ),
        ],
      ),
    );
  }
}
