import 'package:flutter/material.dart';

class AnswerDialog extends AlertDialog {
  final double left, top, bottom;
  AnswerDialog(
      {@required this.left, @required this.top, @required this.bottom});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.only(left: left, top: top, bottom: bottom),
            width: 75.5,
            height: 89,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Table(
                  title: '首个答案',
                ),
                Divider(height: 1),
                Table(
                  title: '最佳答案',
                ),
                Divider(height: 1),
                Table(
                  title: '近似答案',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Table extends StatelessWidget {
  final String title;
  const Table({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      height: 29,
      width: 75.5,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff999999)),
          ),
        ],
      ),
    );
  }
}
