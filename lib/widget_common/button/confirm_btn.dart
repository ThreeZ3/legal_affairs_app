import 'package:flutter/material.dart';

class ConfirmBtn extends StatelessWidget {
  final Function onTap;
  final double width;
  final double height;
  final Color color;
  final String title;
  EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  ConfirmBtn({
    Key key,
    this.onTap,
    this.width,
    this.height = 40,
    this.color,
    this.title = '确定',
    this.margin,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding == null ? EdgeInsets.symmetric(horizontal: 10) : padding,
      width: width,
      height: height,
      child: RaisedButton(
          highlightColor: Colors.transparent,
          highlightElevation: 0,
          disabledElevation: 0,
          elevation: 0,
          color: color,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onTap),
    );
  }
}
