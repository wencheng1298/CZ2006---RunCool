import 'package:flutter/material.dart';
import '../../utils/EventTextTitle.dart';
import '../../utils/everythingUtils.dart';

class JoinEventPage extends StatefulWidget {
  dynamic event;
  String joinQuit;

  JoinEventPage({this.joinQuit, this.event});
  @override
  _JoinEventPageState createState() => _JoinEventPageState();
}

class _JoinEventPageState extends State<JoinEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        //   title: Text(
        //     'Event Name', //need to make this dynamic
        //     style: TextStyle(
        //       color: Colors.white),
        //   ),
      ),
      body: BackgroundImage(
        child: Container(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(26),
              child: Text(
                'You have successfully ${widget.joinQuit}- ${widget.event.name}',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            ButtonType1(onPress: (){ Navigator.pop(context);}, text: "Back to Event Page")
          ]),
        ),
      ),
    );
  }
}
