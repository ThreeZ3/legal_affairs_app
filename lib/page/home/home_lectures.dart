import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///课件

class HomeLectures extends StatefulWidget {
  @override
  _HomeLecturesState createState() => _HomeLecturesState();
}

class _HomeLecturesState extends State<HomeLectures> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CachedNetworkImage(imageUrl:
          "http://www.flutterj.com/content/templates/emlog_dux/images/random/1.jpg",
          width: MediaQueryData.fromWindow(window).size.width,
          height: 194,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "知道用知道用了才知道知道 道道才知知道知道 知道 道道才知知道知道 知道 道道才知知道知道 道道才知道",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "内容简介容简介内容 介内容简介内介内容简介内容简介",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xff999999),
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "￥1，000.00",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 1),
              decoration: BoxDecoration(
                  color: Color(0xffE1B96B),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "立即学习",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        )
      ],
    );
  }
}
