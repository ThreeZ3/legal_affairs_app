import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/other/protocol_page.dart';
import 'package:jh_legal_affairs/page/register/common/register_code.dart';
import 'package:jh_legal_affairs/page/register/common/register_phone_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_tips.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 用户注册页面

class RegisterPhone extends StatefulWidget {
  @override
  _RegisterPhoneState createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        backgroundColor: Color(0xfffafafa),
        iconColor: ThemeColors.colorOrange,
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () =>
                popUntil(ModalRoute.withName(LoginPage().toStringShort())),
            child: Text(
              '登录',
              style: TextStyle(
                color: ThemeColors.colorOrange,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Space(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      RegisterTips(title: '注册您的'),
                      SizedBox(height: 16.0),
                      RegisterPhoneInputTextFieldWidget(
                        title: '中国大陆 +86',
                        hintText: '输入您的手机号码',
                        controller: _phone,
                      ),
                      SizedBox(height: 32.0),
                      _user(),
                    ],
                  ),
                ),
                RegisterButtonWidget(
                  title: '注册账号',
                  onTap: () => sendCodeMethod(),
                ),
                SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //用户协议
  Widget _user() {
    return Row(
      children: <Widget>[
        Text(
          '注册即代表您同意',
          style: TextStyle(
            color: ThemeColors.color999,
            fontSize: 12.0,
          ),
        ),
        InkWell(
          onTap: () => routePush(new ProtocolPage()),
          child: Text(
            '用户协议',
            style: TextStyle(
              color: ThemeColors.color333,
              fontSize: 12.0,
            ),
          ),
        ),
        Text(
          '和',
          style: TextStyle(
            color: ThemeColors.color999,
            fontSize: 12.0,
          ),
        ),
        InkWell(
          onTap: () => routePush(new ProtocolPage()),
          child: Text(
            '隐私政策',
            style: TextStyle(
              color: ThemeColors.color333,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  void sendCodeMethod() {
    if (!strNoEmpty(_phone.text)) {
      showToast(context, '请输入手机号码');
    } else if (!isMobilePhoneNumber(_phone.text)) {
      showToast(context, '请输入正确的手机号码');
    } else {
      routePush(RegisterCode(_phone.text));
    }
  }
}
