import 'package:flutter/material.dart';
import 'package:runcool/pages/NavBar.dart';
import './../../utils/everythingUtils.dart';

class EventDeletedSuccessUI extends StatefulWidget {
  @override
  EventDeletedSuccessUIState createState() => EventDeletedSuccessUIState();
}

class EventDeletedSuccessUIState extends State<EventDeletedSuccessUI> {
  void goHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (RuncoolNavBar())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'SUCCESS',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: Container(),
        ),
        body: BackgroundImage(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(26),
                    child: Text(
                      "Your Event has been deleted successfully!",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: OutlinedButton(
                      child: Text(
                        'Go back to Home Page',
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () => goHomePage(),
                      style: TextButton.styleFrom(
                          backgroundColor: kTurquoise,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              )),
        ));
  }
}
