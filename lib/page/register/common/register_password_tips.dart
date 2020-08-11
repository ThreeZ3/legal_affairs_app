import 'package:flutter/material.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-25
///
/// 密码设置提示信息

class RegisterPasswordTips extends StatelessWidget {
  final String title;

  const RegisterPasswordTips({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '为了保证密码的安全性，密码至少应为8个字符，且同时包含数字和字母',
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
