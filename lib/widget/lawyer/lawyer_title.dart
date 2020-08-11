import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class LawyerTitle extends StatelessWidget {
  final String title;
  final Widget subWidget;
  final EdgeInsetsGeometry padding;

  LawyerTitle(
    this.title, {
    this.subWidget,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: padding,
      child: new Row(
        children: <Widget>[
          new VerticalLine(color: THEME_COLOR, width: 3, height: 15),
          new Space(),
          new Text(
            '$title',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          new Spacer(),
          subWidget != null ? subWidget : new Container(),
        ],
      ),
    );
  }
}
