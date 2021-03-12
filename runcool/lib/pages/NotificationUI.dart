import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationUI extends StatefulWidget {
  @override
  NotificationUIState createState() => NotificationUIState();
}

class NotificationUIState extends State<NotificationUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

  List<Widget> requestWidgets = [];
  List<Widget> inviteWidgets = [];
  List<Widget> updateWidgets = [];
  List<String> requests = ['Paula', 'Eugene', 'Sarah'];
  List<String> invites = ['North Horizon'];
  List<String> updates = ['Event 1', 'Event 2'];
  // TODO: replace with actual lists of notification class from database/ entities

  void _fillLists() {
    setState(() {
      requests.forEach((element) {
        requestWidgets.add(_getFriendRequestCard(element));
      });
      invites.forEach((element) {
        inviteWidgets.add(_getEventInviteCard(element));
      });
      updates.forEach((element) {
        updateWidgets.add(_getEventUpdateCard(element));
      });
    });
  }

  // get the notification cards from the list!!

  // Buttons used!
  OutlinedButton acceptButton(String text) {
    return OutlinedButton(
      onPressed: () {
        print('accept pressed');
      },
      child: Text('$text'),
    );
  }

  OutlinedButton deleteButton() {
    return OutlinedButton(
      onPressed: () {
        print('delete pressed');
      },
      child: Text('Delete'),
    );
  }

  // Get the individual notification cards.
  Container _getFriendRequestCard(String friend) {
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
            radius: 30,
            backgroundImage: NetworkImage(
                'https://qph.fs.quoracdn.net/main-qimg-4ef1e845d114db437e843c262834aab1'),
          ),
          TextButton(
            onPressed: () {
              print("friend clicked");
            },
            child: Text(
              "$friend",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          acceptButton("Accept"), // Accept
          deleteButton(),
        ],
      ),
    );
  }

  Container _getEventInviteCard(String event) {
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
            TextButton(
              onPressed: () {
                print('event name in invite clicked');
              },
              child: Text(
                "$event",
                style: TextStyle(color: Colors.white),
              ),
            ),
            acceptButton("Accept"),
            deleteButton()
          ]),
        ]));
  }

  Container _getEventUpdateCard(String event) {
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
              TextButton(
                child: Text("$event"),
                onPressed: () {
                  print('event name in update pressed!');
                },
              ),
              acceptButton('View')
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

  Container _notificationWrap(String title, List<Widget> notifications) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: _turqoise),
          ),
          Column(
            children: notifications,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _fillLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _background,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _background,
          image: DecorationImage(
              image: AssetImage('images/gym.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  _background.withOpacity(0.2), BlendMode.dstATop)),
        ),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _notificationWrap("Friend Requests", requestWidgets),
              _notificationWrap("Event Invites", inviteWidgets),
              _notificationWrap("Event Updates", updateWidgets)
            ],
          ),
        ),
      ),
    );
  }
}
