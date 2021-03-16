import 'package:flutter/material.dart';
import './../utils/everythingUtils.dart';
import './SettingsUI/SettingsUI.dart';

class ProfileUI extends StatefulWidget {
  @override
  ProfileUIState createState() => ProfileUIState();
}

class ProfileUIState extends State<ProfileUI> {
  double fontMainSize = 15;
  void Settings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsUI()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Settings(),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        //leading: Container(),
      ),
      body: BackgroundImage(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: CircleAvatar(
                  radius: 55,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Noah',
                style: TextStyle(
                    fontSize: 30,
                    color: kTurquoise,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.face, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Age',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.insert_emoticon,
                        size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.directions_run, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enjoys',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.home, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lives in',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.card_travel, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Currently',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.fitness_center, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Fitness level',
                      style:
                          TextStyle(fontSize: fontMainSize, color: kTurquoise),
                    ),
                  ),
                  Text(
                    'user input',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.directions_run, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'User Insta handle',
                      style: TextStyle(
                          fontSize: fontMainSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.assignment_ind, size: 18, color: kTurquoise),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'user input short bio',
                      style: TextStyle(
                          fontSize: fontMainSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Friends',
                      style: TextStyle(
                          fontSize: 30,
                          color: kTurquoise,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  ),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                  Icon(Icons.account_circle, size: 70, color: kTurquoise),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
