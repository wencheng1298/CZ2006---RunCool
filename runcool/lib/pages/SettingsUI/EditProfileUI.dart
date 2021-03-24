import 'package:flutter/material.dart';
import 'package:runcool/pages/ProfileUI.dart';
import './../../utils/everythingUtils.dart';

class EditProfileUI extends StatefulWidget {
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  double fontMainSize = 15;
  double _value = 50;

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
          InputTextField1(text: 'age'),
          SizedBox(height: 10),
          InputTextField1(text: 'others'),
          SizedBox(height: 10),
          InputTextField1(text: 'lives in ..'),
          SizedBox(height: 10),
          InputTextField1(text: 'occupation'),
          SizedBox(height: 10),
          InputTextField1(text: 'insta handle'),
          SizedBox(height: 10),
          InputTextField1(text: 'Bio'),
          SizedBox(height: 20),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Fitness level',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Slider(
              min: 0,
              max: 100,
              value: _value,
              divisions: 3,
              activeColor: kTurquoise,
              inactiveColor: Colors.lightBlue[900],
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Beginner',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Regular',
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Advanced',
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
