import 'package:flutter/material.dart';

class CreateRunningUI1 extends StatefulWidget {
  @override
  _CreateRunningUI1State createState() => _CreateRunningUI1State();
}

class _CreateRunningUI1State extends State<CreateRunningUI1> {
  Color _background = Color(0xff322F2F);
  Color _turqoise = Color(0xff58C5CC);

  Widget _buildTextField() {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: 35,
        child: TextField(
          autofocus: false,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _turqoise, width: 2),
              borderRadius: BorderRadius.circular(35),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _turqoise, width: 2),
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
      ),
    );
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
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Center(
                child: Text("Put the google map here"),
              ),
            ),
            Container(
              height: 410,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Start",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: _buildTextField(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "End",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: _buildTextField(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                child: Text('Next'),
                onPressed: null,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
