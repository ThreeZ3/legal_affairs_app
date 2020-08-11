import 'package:flutter/material.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-25
///
/// 用户接收验证码提示信息

class RegisterCodeTips extends StatelessWidget {
  final String title;
  final String text;

  const RegisterCodeTips({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Color(0xff24262E),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Text(
              '验证码已发送至手机：',
              style: TextStyle(
                color: Color(0xff24262E),
                fontSize: 12.0,
              ),
            ),
            SizedBox(width: 8.0),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffE1B96B),
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
