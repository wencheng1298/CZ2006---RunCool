import 'package:flutter/material.dart';
import './../controllers/EventManager.dart';
import 'package:provider/provider.dart';
import './../utils/everythingUtils.dart';
import './eventDisplayDependancies/eventsForYouList.dart';
import './eventDisplayDependancies/friendEventsList.dart';
import 'package:runcool/models/Event.dart';

class HomePageUI extends StatefulWidget {
  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  List<Widget> eventsForYouWidgets = [];
  List<Widget> friendEventsWidgets = [];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<dynamic>>.value(
      value: Event.getEvents(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: Container(),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.menu),
          //     onPressed: () => FilterItem(),
          //   )
          // ],
        ),
        body: BackgroundImage(
          child: SingleChildScrollView(
            child: Container(
              height: 1000,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 20, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'EVENTS FOR YOU',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 340,
                              child: EventsForYouList()),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 20, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'See what your friends are up to',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 340,
                              child: FriendEventsList()),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
