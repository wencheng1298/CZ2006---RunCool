import 'package:flutter/material.dart';
import 'package:runcool/utils/constants.dart';

class TinyButton extends StatelessWidget {
  TinyButton({@required this.onPress, @required this.text, this.colour});
  final Function onPress;
  final Color colour;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      fillColor: colour ?? Colors.white,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      constraints: BoxConstraints(minWidth: 75.0, minHeight: 30.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class ButtonType1 extends StatelessWidget {
  final Function onPress;
  final Color colour;
  final String text;

  ButtonType1({@required this.onPress, @required this.text, this.colour});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 4.0,
      onPressed: onPress,
      fillColor: colour ?? kTurquoise,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      constraints: BoxConstraints(minWidth: 200.0, minHeight: 45.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class MinuteButton extends StatelessWidget {
  MinuteButton({@required this.onPress, @required this.text, this.colour});
  final Function onPress;
  final Color colour;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      fillColor: colour ?? Colors.white,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      constraints: BoxConstraints(minWidth: 60.0, minHeight: 32.0),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white12, width: 2)),
    );
  }
}
