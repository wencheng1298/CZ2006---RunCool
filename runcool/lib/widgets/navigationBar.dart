import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationBar extends StatelessWidget {
  final Color appColor;
  final Color bgColor;

  //Constructor - Takes in special color + bgcolor
  NavigationBar(this.appColor, this.bgColor);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: appColor,
      backgroundColor: bgColor,
      buttonBackgroundColor: appColor,
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
      index: 0,
      onTap: (index) {
        print('Tapped index: $index');
      },
    );
  }
}

