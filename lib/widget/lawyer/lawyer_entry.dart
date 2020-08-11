import 'package:flutter/material.dart';

/// 创建者：林境浩
/// 开发者：林境浩
/// 创建日期：2020-04-29
///
/// 封装：竖线+词条、排名、灰色字体
///

//图标+词条
class Entry extends StatefulWidget {
  final String text;
  final Color borderColor;
  final Widget icon;
  Entry({this.text, this.borderColor, this.icon});
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 13),
      width: MediaQuery.of(context).size.width,
      color: Color(0xfffffffe),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 17,
            width: 2,
            margin: EdgeInsets.only(right: 2.0),
            decoration: BoxDecoration(
              color: Color(0xffE1B96B),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            child: widget.icon,
          ),
        ],
      ),
    );
  }
}

//排名
class IconBox extends StatefulWidget {
  final String text;
  final String number;
  IconBox({this.text, this.number});
  @override
  _IconBoxState createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 44,
      child: Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffE1B96B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xfffffffe),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF0F0F0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              widget.number,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xffE1B96B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//灰色字体
class GreyText extends StatefulWidget {
  final String text;
  GreyText({this.text});
  @override
  _GreyTextState createState() => _GreyTextState();
}

class _GreyTextState extends State<GreyText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 2),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Color(0xff999999),
          fontSize: 12,
        ),
      ),
    );
  }
}
