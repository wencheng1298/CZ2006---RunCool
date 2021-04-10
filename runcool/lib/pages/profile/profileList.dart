import 'package:flutter/material.dart';
import 'package:runcool/firebase/ProfileManager.dart';
import 'package:runcool/firebase/friendManager.dart';
import 'package:runcool/models/User.dart';
import 'package:runcool/pages/profile/FriendCard.dart';
import 'package:runcool/utils/everythingUtils.dart';

final double fontMainSize = 20;

class ProfileList extends StatefulWidget {
  final AppUser user;
  final String currUserID;
  ProfileList({@required this.user, this.currUserID});
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  bool friend = false;
  bool requestSent = false;
  List friends = [];

  void _processFriend() {
    if (widget.user.friends.contains(widget.currUserID) ||
        widget.user.uid == widget.currUserID) {
      setState(() {
        friend = true;
        friends = widget.user.friends.map((element) => element).toList();
        friends.remove(widget.currUserID);
      });
    }
  }

  @override
  void initState() {
    _processFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        children: [
          // profile picture
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: (user.image == '')
                    ? Icon(Icons.account_circle, size: 160, color: kTurquoise)
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(user.image),
                      )),
          ),
          // name
          Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                user.name ?? "Name",
                style: TextStyle(
                    fontSize: 30,
                    color: kTurquoise,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          // age
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
          //Gender
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
          // Hobbies
          (user.hobbies == '')
              ? Container()
              : Container(
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
                          style: TextStyle(
                              fontSize: fontMainSize, color: kTurquoise),
                        ),
                      ),
                      Text(
                        user.hobbies,

                        //hobbies,
                        style: TextStyle(
                            fontSize: fontMainSize, color: Colors.white),
                      )
                    ],
                  ),
                ),
          // region
          (user.region == '')
              ? Container()
              : Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child:
                            Icon(Icons.home, size: 18, color: Colors.grey[300]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Lives in',
                          style: TextStyle(
                              fontSize: fontMainSize, color: kTurquoise),
                        ),
                      ),
                      Text(
                        user.region,
                        //region,
                        style: TextStyle(
                            fontSize: fontMainSize, color: Colors.white),
                      )
                    ],
                  ),
                ),
          // occupation
          (user.occupation == '')
              ? Container()
              : Container(
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
                          'Occupation',
                          style: TextStyle(
                              fontSize: fontMainSize, color: kTurquoise),
                        ),
                      ),
                      Text(
                        user.occupation,
                        //occupation,
                        style: TextStyle(
                            fontSize: fontMainSize, color: Colors.white),
                      )
                    ],
                  ),
                ),
          //
          (user.insta == '')
              ? Container()
              : Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.account_circle_rounded,
                            size: 18, color: Colors.grey[300]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Instagram',
                          style: TextStyle(
                              fontSize: fontMainSize, color: kTurquoise),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.insta,
                          style: TextStyle(
                              fontSize: fontMainSize, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
          (user.bio == '')
              ? Container()
              : Container(
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
                          user.bio,
                          //bio,
                          style: TextStyle(
                              fontSize: fontMainSize, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 5),
          // friends
          (user.friends.isEmpty)
              ? Container()
              : Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: ProfileCardStream(friends: friends),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 20),
          //Request button
          friend
              ? Container()
              : (Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: (!requestSent)
                      ? ButtonType1(
                          onPress: () {
                            FriendManager().sendRequest(user.uid);
                            setState(() {
                              requestSent = true;
                            });
                          },
                          text: "Request")
                      : ButtonType1(
                          onPress: () {},
                          text: "Request sent",
                          colour: Colors.grey),
                ))
        ],
      ),
    );
  }
}