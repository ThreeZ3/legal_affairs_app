import 'package:flutter/material.dart';

///排名

class HomeRankingWidget extends StatefulWidget {
  final String name;

  const HomeRankingWidget({Key key, this.name}) : super(key: key);

  @override
  _HomeRankingWidgetState createState() => _HomeRankingWidgetState();
}

class _HomeRankingWidgetState extends State<HomeRankingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xffE1B96B),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: (Radius.circular(5)),
            ),
          ),
          child: Text(
            "排名",
            style: TextStyle(
              color: Color(0xffFFF6F7F9),
              fontSize: 12,
            ),
          ),
        ),
        Container(
          width: 50,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: (Radius.circular(5)),
            ),
          ),
          child: Text(
            widget.name,
            style: TextStyle(
              color: Color(0xffFFE1B96B),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
