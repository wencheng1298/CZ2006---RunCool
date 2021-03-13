import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'HomePageUI.dart';
import 'MyActivitiesUI.dart';
import 'CreateEventUI.dart';
import 'NotificationUI.dart';
import 'ProfileUI.dart';

class RuncoolNavBar extends StatefulWidget {
  @override
  _RuncoolNavBarState createState() => _RuncoolNavBarState();
}

class _RuncoolNavBarState extends State<RuncoolNavBar> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff1f1b24);

  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePageUI(),
    MyActivitiesUI(),
    CreateEventUI(),
    // ChooseEventUI(),
    NotificationUI(),
    ProfileUI(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    print(_pages[_currentIndex]);
    print('Tapped index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTappedBar,
        color: _turqoise,
        backgroundColor: _background,
        buttonBackgroundColor: _turqoise,
        height: 50,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30, color: Colors.black),
          Icon(Icons.explore_outlined, size: 30, color: Colors.black),
          Icon(Icons.add_circle_outline, size: 30, color: Colors.black),
          Icon(Icons.notification_important_outlined,
              size: 30, color: Colors.black),
          Icon(Icons.person_outline, size: 30, color: Colors.black),
        ],
        animationDuration: Duration(
          milliseconds: 100,
        ),
        animationCurve: Curves.linear,
      ),
    );
  }
}
