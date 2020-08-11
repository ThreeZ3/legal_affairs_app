import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/lawyer/lawyer_title.dart';

class LawFirmPhoto extends StatelessWidget {
  final String title;
  final int num;

  LawFirmPhoto(this.title, this.num);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
      child: new Column(
        children: <Widget>[
          new LawyerTitle(
            title,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            subWidget: new Row(
              children: ['add', 'reduce'].map((item) {
                return new SizedBox(
                  width: 40,
                  child: new FlatButton(
                    padding: EdgeInsets.all(0),
                    child: new Image.asset(
                      'assets/images/commom/img_$item.png',
                      width: 20,
                    ),
                    onPressed: () => showToast(context, '敬请期待'),
                  ),
                );
              }).toList(),
            ),
          ),
          new Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: List.generate(num, (index) {
              return new SizedBox(
                width: (winWidth(context) - 40) / 2,
                child: new Column(
                  children: <Widget>[
                    new CachedNetworkImage(
                      imageUrl:
                          'http://www.ruiyanglawyer.com/DATA/image/20180824142629843.jpg',
                    ),
                    new Space(),
                    new Text(
                      '图片说明文字图片说明文字图片图片说明文字图片说明文字图片图片说明文字',
                      style:
                          TextStyle(color: Color(0xff999999), fontSize: 12.0),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
