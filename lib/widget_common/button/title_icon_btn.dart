import 'package:flutter/material.dart';

class TitleIconBtn extends StatelessWidget {
  final String title;
  final String imgUrl;
  final Function onTap;
  final Color color;

  const TitleIconBtn({Key key, this.onTap, this.title, this.imgUrl, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style:
                  TextStyle(color: color == null ? Color(0xff999999) : color),
            ),
            SizedBox(width: 5),
            Image.asset(
              '$imgUrl',
              width: 14,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
