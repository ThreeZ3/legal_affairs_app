import 'package:flutter/material.dart';

class RowTitleIconBtn extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;
  final String title;
  final Color textColor;
  final Function onTap;

  const RowTitleIconBtn({
    Key key,
    this.iconData,
    this.size = 15,
    this.color,
    this.title,
    this.textColor,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: size,
            color: color,
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(color: textColor == null ? color : textColor),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
