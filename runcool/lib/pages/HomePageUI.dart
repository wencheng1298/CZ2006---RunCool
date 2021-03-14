import 'package:flutter/material.dart';
import 'package:runcool/pages/FilterUI/SelectItemsFIlterUI.dart';

import './../widgets/navigationBar.dart';

class HomePageUI extends StatefulWidget {
  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff1f1b24);

  void FilterItem() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectItemsFIlterUI()));
  }

  Container EventCards(String heading, String subHeading) {
    return Container(
      width: 400,
      child: Card(
        child: Wrap(
          children: <Widget>[
            ListTile(
              title: Text(heading),
              subtitle: Text(subHeading),
            ),
          ],
        ),
      ),
    );
  }

/*   Widget popupMenuButton<String>(
    icon: Icon(Icons.add,size: 30.0),
    itembuilder: (BuildContext context)=><PopupMenuEntry<String>>[

      PopupMenuItem<String>(
        value: "one_val",
        child: Text("one"),
      ),
    ],

  ); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => FilterItem(),
          )
        ],
      ),
      body: SingleChildScrollView(
        //let the app be scrollable
        child: Container(
          color: _background,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
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
                color: Colors.black,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      EventCards("Events for you", "Event 1"),
                      EventCards("Events for you", "Event 2"),
                      EventCards("Events for you", "Event 3"),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10),
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
                color: Colors.black,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      EventCards("Friends up to", "Event 1"),
                      EventCards("Friends up to", "Event 2"),
                      EventCards("Friends up to", "Event 3"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
