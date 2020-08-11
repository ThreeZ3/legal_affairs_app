import 'package:flutter/material.dart';

///自定义复选框
///时间：2020-03-24

class RoundCheckBox extends StatefulWidget {
  bool value = false;

  Function(bool) onChanged;

  RoundCheckBox({Key key, @required this.value, this.onChanged})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          widget.value = !widget.value;
          widget.onChanged(widget.value);
        },
        child: Padding(
          padding: EdgeInsets.all(0),
          child: widget.value
              ? Icon(
                  Icons.check_circle,
                  size: 22.0,
                  color: Color(0xffE1B96B),
                )
              : Icon(
                  Icons.panorama_fish_eye,
                  size: 22.0,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}
