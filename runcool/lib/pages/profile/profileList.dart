import 'package:flutter/material.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/utils/everythingUtils.dart';

class ProfileList extends StatelessWidget {
  final AppUser user;
  ProfileList({this.user});
  final double fontMainSize = 20;

  List<String> friends = [
    'Paula',
    'Eugene',
    'Sarah',
    'Bob',
    'Ho',
    'RERE',
    'BIZ'
  ];
  List<Widget> friendsWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              //child: GetUserName(userId),
              child: Text(
                //'user input',
                user.name ?? "Name",
                //name,
                style: TextStyle(
                    fontSize: 30,
                    color: kTurquoise,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
              //GetUserName(uid),
              //'HZVHv7uJAbaZJk54FiamoGriJTs2'
              //users.getId()
              //users.doc().toString()
              //users.parent.toString()
              //'Noah',
              // style: TextStyle(
              //     fontSize: 30,
              //     color: kTurquoise,
              //     fontWeight: FontWeight.bold),
              ),
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(Icons.face, size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Age",
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  user.age.toString() + " years old",
                  //age.toString(),
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
                  child: Icon(Icons.insert_emoticon,
                      size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  user.gender,
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
                  child: Icon(Icons.directions_run,
                      size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enjoys',
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  user.hobbies,

                  //hobbies,
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
                  child: Icon(Icons.home, size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lives in',
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  user.region,
                  //region,
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
                  child: Icon(Icons.card_travel,
                      size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Occupation:',
                    style: TextStyle(fontSize: fontMainSize, color: kTurquoise),
                  ),
                ),
                Text(
                  user.occupation,
                  //occupation,
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
                  child: Icon(Icons.fitness_center,
                      size: 18, color: Colors.grey[300]),
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
                  child: Icon(Icons.directions_run,
                      size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.insta,
                    //insta,
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
                  child: Icon(Icons.assignment_ind,
                      size: 18, color: Colors.grey[300]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'user input',
                    //bio,
                    style:
                        TextStyle(fontSize: fontMainSize, color: Colors.white),
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
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: friendsWidgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
