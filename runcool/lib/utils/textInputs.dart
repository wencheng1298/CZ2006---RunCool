import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GoogleMapsAppData.dart';
import 'constants.dart';

class LineTextField extends StatefulWidget {
  final Function onChange;
  final String hintText;

  LineTextField({this.onChange, this.hintText});

  @override
  _LineTextFieldState createState() => _LineTextFieldState();
}

class _LineTextFieldState extends State<LineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kTurquoise),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }
}

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

class InputTextFormFill extends StatefulWidget {
  final String text;
  final Function onChange;
  final double height;
  final bool obscure;
  final Function validate;

  InputTextFormFill(
      {this.text, this.onChange, this.height, this.obscure, this.validate});

  @override
  InputTextFormFillState createState() => InputTextFormFillState();
}

class InputTextFormFillState extends State<InputTextFormFill> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: kTurquoise, width: 2),
    borderRadius: BorderRadius.circular(15),
  );
  final errBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15),
  );
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        height: widget.height ?? 65,
        child: TextFormField(
          validator: widget.validate ?? (val) => null,
          onChanged: widget.onChange,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: Colors.white),
          obscureText: widget.obscure ?? false,
          decoration: InputDecoration(
            helperText: '',
            helperStyle: TextStyle(fontSize: 13, height: 0.6),
            filled: true,
            fillColor: Colors.grey[800].withOpacity(0.5),
            contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: errBorder,
            focusedErrorBorder: errBorder,
            hintText: widget.text ?? '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
            errorStyle: TextStyle(fontSize: 13.0, height: 0.6),
          ),
        ),
      ),
    );
  }
}

class DropdownFormFill extends StatefulWidget {
  final String value;
  final Function onChange;
  final double height;
  final Function validate;
  final List items;
  final String text;

  DropdownFormFill(
      {this.value,
      this.onChange,
      this.height,
      this.validate,
      this.items,
      this.text});
  @override
  _DropdownFormFillState createState() => _DropdownFormFillState();
}

class _DropdownFormFillState extends State<DropdownFormFill> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: kTurquoise, width: 2),
    borderRadius: BorderRadius.circular(15),
  );
  final errBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15),
  );
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: widget.validate ?? (val) => null,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyle(fontSize: 13, height: 0.6),
        filled: true,
        fillColor: Colors.grey[800].withOpacity(0.5),
        contentPadding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
        focusedBorder: border,
        enabledBorder: border,
        errorBorder: errBorder,
        focusedErrorBorder: errBorder,
        errorStyle: TextStyle(fontSize: 13.0, height: 0.6),
      ),
      dropdownColor: Colors.grey[800].withOpacity(0.9),
      icon: Icon(
        Icons.arrow_drop_down_circle_outlined, color: Colors.white38,
        // color: Colors.white,
      ),
      iconSize: 26,
      isExpanded: true,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      value: widget.value,
      hint: Text(
        widget.text ?? '--none--',
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      onChanged: widget.onChange,
      items: widget.items.map((choice) {
        return DropdownMenuItem(
            value: choice,
            child: Text(
              choice,
            ));
      }).toList(),
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
  final Color color;
  final int minLine;
  final TextEditingController controller;

  DescriptionTextField(
      {this.text, this.onChange, this.color, this.minLine, this.controller});
  @override
  _DescriptionTextFieldState createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChange,
      autofocus: false,
      keyboardType: TextInputType.multiline,
      minLines: widget.minLine ?? 6,
      maxLines: 10,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.color ?? Colors.grey[800],
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

  GoogleMapsSearchField(
      {this.text, this.onTap, this.onChange, this.height, this.textcontroller});
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
