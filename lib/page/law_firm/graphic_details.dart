import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class ShareModel {
  final String title;
  final String pic;

  ShareModel({@required this.title, @required this.pic});
}

TextStyle greyWord = TextStyle(fontSize: 12, color: Color(0xffFF999999));
TextStyle greyMidWord = TextStyle(fontSize: 14, color: Color(0xffFF999999));
TextStyle greyBigWord = TextStyle(fontSize: 14, color: Color(0xffFF666666));
TextStyle greyWord2 = TextStyle(fontSize: 12, color: Color(0xffFF666666));

class SketchChoose extends StatelessWidget {
  final bool ifLike;
  final int num;
  final String id;

  SketchChoose({Key key, this.ifLike, this.num, @required this.id})
      : super(key: key);

  //支持 反对  操作类型:1.支持，2.反对
  Future postLectureAttitude(context, String id, int num) async {
    await sketchViewModel
        .sketchComment(context, sketchId: id, status: num)
        .catchError((e) => showToast(context, e.message));
  }

  @override
  Widget build(BuildContext context) {
    double btnWidth = (winWidth(context) - 194) / 2;
    return InkWell(
      onTap: () {
        ifLike
            ? postLectureAttitude(context, id, 1)
            : postLectureAttitude(context, id, 2);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        width: btnWidth,
        decoration: BoxDecoration(
          color: ifLike ? Color(0xffFFE1B96B) : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 2,
            color: ifLike ? Color(0xffFFE1B96B) : Colors.black,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: <Widget>[
            Text(
              ifLike ? "支持" : "反对",
              style: TextStyle(
                fontSize: 12,
                color: ifLike ? Colors.white : Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  ifLike
                      ? "assets/images/lawyer/like.png"
                      : "assets/images/mine/unlike.png",
                  width: 13,
                  height: 13,
                  color: ifLike ? Colors.white : Colors.black,
                ),
                Text(
                  "$num",
                  style: TextStyle(
                    fontSize: 12,
                    color: ifLike ? Colors.white : Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
