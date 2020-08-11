import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/register/get_code_page.dart';
import 'package:jh_legal_affairs/page/register/common/register_phone.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 身份选择注册页面

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        backgroundColor: Color(0xfffafafa),
        iconColor: ThemeColors.colorOrange,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  '请选择您要注册的身份',
                  style: TextStyle(
                    color: Color(0xff24262E),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 100.0),
                RegisterButtonWidget(
                  title: '法律服务者',
                  onTap: () => routePush(GetCodeCode()),
                ),
                SizedBox(height: 16.0),
                RegisterButtonWidget(
                  title: '普通用户',
                  titleColors: Color(0xff24262E),
                  backgroundColors: Color(0xffF2F5F5),
                  onTap: () => routePush(RegisterPhone()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
