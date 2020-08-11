import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/app.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 重置密码成功页面

class ResetComplete extends StatefulWidget {
  @override
  _ResetCompleteState createState() => _ResetCompleteState();
}

class _ResetCompleteState extends State<ResetComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        backgroundColor: Colors.white,
        iconColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    SizedBox(height: 110.0),
                    Container(
                      width: double.infinity,
                      height: 65.0,
                      alignment: Alignment.center,
                      child: Image.asset('assets/register/icon.png'),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        '登录密码重置成功',
                        style: TextStyle(
                          color: Color(0xff24262E),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RegisterButtonWidget(
                title: '完成',
                onTap: () => pushAndRemoveUntil(RootPage()),
              ),
              SizedBox(height: 42.0),
            ],
          ),
        ),
      ),
    );
  }
}
