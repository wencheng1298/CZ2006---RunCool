import 'package:flutter/material.dart';

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
      child: Text(text),
      constraints: BoxConstraints(minWidth: 75.0, minHeight: 30.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
