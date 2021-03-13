import 'package:flutter/material.dart';
import 'package:runcool/utils/constants.dart';

class TinyButton extends StatelessWidget {
  TinyButton({@required this.onPress, @required this.text, this.colour});
  final Function onPress;
  final Color colour;
  final String text;
  @override
  Widget build(BuildContext context) {
    print(colour);
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
    print(colour);
    return RawMaterialButton(
      elevation: 4.0,
      onPressed: onPress,
      fillColor: colour ?? kTurquoise,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      constraints: BoxConstraints(minWidth: 200.0, minHeight: 45.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
