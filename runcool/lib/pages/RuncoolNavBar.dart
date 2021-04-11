import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:runcool/firebase/ProfileManager.dart';

import 'HomePageUI.dart';
import 'MyActivitiesUI.dart';
import 'Events/ChooseEventUI.dart';
import 'NotificationUI.dart';
import 'ProfileUI.dart';

import 'package:provider/provider.dart';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RuncoolNavBar extends StatefulWidget {
  @override
  _RuncoolNavBarState createState() => _RuncoolNavBarState();
}

class _RuncoolNavBarState extends State<RuncoolNavBar> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff1f1b24);
  final Color iconColor = Colors.black;
  final double iconSize = 30;

  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePageUI(),
    MyActivitiesUI(),
    ChooseEventUI(),
    NotificationUI(),
    ProfileUI(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context) ?? AppUser();
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTappedBar,
        color: _turqoise,
        backgroundColor: _background,
        buttonBackgroundColor: _turqoise,
        height: 50,
        items: <Widget>[
          Icon(Icons.home_outlined, size: iconSize, color: iconColor),
          Icon(Icons.explore_outlined, size: iconSize, color: iconColor),
          Icon(Icons.add_circle_outline, size: iconSize, color: iconColor),
          user.notifications.isEmpty
              ? Icon(Icons.notifications_none_outlined,
                  size: iconSize, color: iconColor)
              : Icon(Icons.notification_important_outlined,
                  size: iconSize, color: Colors.red),
          Icon(Icons.person_outline, size: iconSize, color: iconColor),
        ],
        animationDuration: Duration(
          milliseconds: 100,
        ),
        animationCurve: Curves.linear,
      ),
    );
  }
}
