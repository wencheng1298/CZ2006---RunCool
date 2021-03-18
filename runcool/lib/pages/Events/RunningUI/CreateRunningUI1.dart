import 'package:flutter/material.dart';
import './CreateRunningUI2.dart';
import './../../../utils/everythingUtils.dart';


class CreateRunningUI1 extends StatefulWidget {
  @override
  _CreateRunningUI1State createState() => _CreateRunningUI1State();
}

class _CreateRunningUI1State extends State<CreateRunningUI1> {
  Color _background = Color(0xff1f1b24);
  Color _turqoise = Color(0xff58C5CC);

  void goNextPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateRunningUI2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'New Route',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: _background,
        child: Column(
          children: [
            GoogleMapPlacement(),
            Container(
              height: 410,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('Start'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: InputTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InputFieldTextTitles('End'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: InputTextField(),
                  ),
                                  Align(
                  alignment: Alignment.topLeft,
                  child: InputFieldTextTitles('CheckPoints'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    height: 50,
                    color: _turqoise,
                    child: const Center(
                      child: Text('Add CheckPoint'),
                    ),
                  ),
                ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 20),
                  child: const Text(
                    "Estimated Distance: ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    alignment: Alignment.bottomRight,
                    child: OutlinedButton(
                      child: Text('Next'),
                      onPressed: () => goNextPage(),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
