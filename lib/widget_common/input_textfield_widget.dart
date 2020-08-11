import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final double height;
  final String hintText;
  final int maxLines;
  final Widget suffixIcon;
  final bool obscureText;
  final Function onChanged;

  InputTextField(
      {Key key,
      this.controller,
      this.height = 40,
      this.hintText = '',
      this.maxLines = 1,
      this.suffixIcon,
      this.obscureText = false,
      this.onChanged})
      : super(key: key);
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.grey.withOpacity(0.1),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintText: '${widget.hintText}',
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          border: OutlineInputBorder(),
          suffixIcon: widget.suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
      ),
    );
  }
}
