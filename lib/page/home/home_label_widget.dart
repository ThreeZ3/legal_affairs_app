import 'package:flutter/material.dart';

///标签

class HomeLabelWidget extends StatefulWidget {
  final String name;
  final String rank;

  const HomeLabelWidget({Key key, this.name, this.rank}) : super(key: key);

  @override
  _HomeLabelWidgetState createState() => _HomeLabelWidgetState();
}

class _HomeLabelWidgetState extends State<HomeLabelWidget> {
  TextStyle style = TextStyle(
    color: Color(0xffE1B96B),
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, bottom: 2),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
      decoration: BoxDecoration(
          color: Color(0xffF0F0F0), borderRadius: BorderRadius.circular(5)),
      child: RichText(
        text: TextSpan(
          text: '${widget.name} ',
          children: [
            TextSpan(
              text: '${widget.rank}',
              style: style,
            ),
          ],
          style: style,
        ),
      ),
    );
  }
}
