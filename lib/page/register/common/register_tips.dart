import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-25
///
/// 用户登录提示信息

class RegisterTips extends StatelessWidget {
  final String title;

  const RegisterTips({Key key, this.title}) : super(key: key);

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
        SizedBox(height: 16.0),
        Text(
          '法π 账号',
          style: TextStyle(
            color: Color(0xff24262E),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
