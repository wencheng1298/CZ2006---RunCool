import 'package:flutter/material.dart';
import 'package:runcool/pages/ProfileUI.dart';
import './../../utils/everythingUtils.dart';

class EditProfileUI extends StatefulWidget {
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  double fontMainSize = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        //leading: Container(),
      ),
      body: BackgroundImage(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Edit your profile',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: CircleAvatar(
                radius: 55,
              ),
            ),
          ),
          InputTextField1(text: 'name'),
          SizedBox(height: 10),
          InputTextField1(text: 'testing'),
          SizedBox(height: 10),
          InputTextField1(text: 'New password re-confirm'),
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
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                      Icon(Icons.insert_emoticon, size: 18, color: kTurquoise),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  'user input',
                  style: TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
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
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
