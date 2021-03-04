import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//Required for routing to different UIs
import './pages/HomePageUI.dart';
import './pages/MyActivitiesUI.dart';
import './pages/CreateEventUI.dart';
import './pages/ChooseEventUI.dart'; //Temporary
import './pages/NotificationUI.dart';
import './pages/ProfileUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RuncoolNavBar(),
    );
  }
}

class RuncoolNavBar extends StatefulWidget {
  @override
  _RuncoolNavBarState createState() => _RuncoolNavBarState();
}

class _RuncoolNavBarState extends State<RuncoolNavBar> {
  Color _turqoise = Color(0xff58C5CC);
  Color _background = Color(0xff322F2F);

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
