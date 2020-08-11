import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class LabelTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  final bool isBorder;
  final Widget rightW;

  LabelTile({
    this.title,
    this.subTitle,
    this.onPressed,
    this.isBorder = true,
    this.rightW,
  });

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      color: Colors.white,
      disabledColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: new Container(
        decoration: BoxDecoration(
          border: isBorder
              ? Border(
                  bottom: BorderSide(
                      color: Color(0xff11152B).withOpacity(0.5), width: 0.3),
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '$title',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14.0),
                ),
                new Space(height: mainSpace / 3),
                new Text(
                  '$subTitle',
                  style: TextStyle(color: Color(0xff999999), fontSize: 12),
                ),
              ],
            ),
            new Spacer(),
            rightW != null
                ? rightW
                : new Icon(CupertinoIcons.right_chevron),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
