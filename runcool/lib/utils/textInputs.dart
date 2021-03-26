import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GoogleMapsAppData.dart';
import 'constants.dart';
import '../pages/SignUpUI/LogIn.dart';

class InputTextField1 extends StatefulWidget {
  final String text;
  final Function onChange;
  final double height;


  InputTextField1({this.text, this.onChange, this.height});
  @override
  _InputTextField1State createState() => _InputTextField1State();
}

class _InputTextField1State extends State<InputTextField1> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: widget.height ?? 45,
        child: TextField(
          onChanged: widget.onChange,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800].withOpacity(0.5),
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.text ?? '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class NumberTextField extends StatefulWidget {
  final String text;
  final Function onChange;
  final double height;

  NumberTextField({this.text, this.onChange, this.height});
  @override
  _NumberTextFieldState createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: widget.height ?? 45,
        child: TextField(
          onChanged: widget.onChange,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800].withOpacity(0.5),
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTurquoise, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.text ?? '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class DescriptionTextField extends StatefulWidget {
  final String text;
  final Function onChange;

  DescriptionTextField({this.text, this.onChange});
  @override
  _DescriptionTextFieldState createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      autofocus: false,
      keyboardType: TextInputType.multiline,
      minLines: 6,
      maxLines: 10,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTurquoise, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10, width: 2),
        ),
      ),
    );
  }
}

class GoogleMapsSearchField extends StatefulWidget {
  final String text;
  final Function onChange;
  final double height;
  final TextEditingController textcontroller;
  //final FocusNode focusNode;
  final Function onTap;


  GoogleMapsSearchField({this.text,this.onTap, this.onChange, this.height, this.textcontroller});
  OverlayEntry createOverlayEntry;

  @override
  _GoogleMapsSearchFieldState createState() => _GoogleMapsSearchFieldState();
}

class _GoogleMapsSearchFieldState extends State<GoogleMapsSearchField> {

  /*OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {

        this._overlayEntry = this.createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);

      } else {
        this._overlayEntry.remove();
      }
    });
  }

  createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    final googleMapsController = Provider.of<GoogleMapsController>(context);
    return OverlayEntry(

      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              itemCount: googleMapsController.searchResults.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(
                    googleMapsController.searchResults[index].description,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              /*children: <Widget>[
            ListTile(
            title: Text(
              googleMapsController.searchResults[index].description,
              style: TextStyle(color: Colors.white),
            ),
          ),


        ],*/
      ),
    ),
    ),
    )
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: widget.height ?? 45,
        //child: CompositedTransformTarget(
          //link: this._layerLink,
          child: TextField(
            //focusNode: _focusNode,
            onTap: widget.onTap,
            controller: widget.textcontroller,
            onChanged: widget.onChange,
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800].withOpacity(0.5),
              contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kTurquoise, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kTurquoise, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: widget.text ?? '',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              //suffixIcon: Icon(Icons.search),
            ),
          ),
        //),
      ),
    );
  }
}
