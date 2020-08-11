import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_phone_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/reset/reset_password_code.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 重置密码设置 - 手机号

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
        backgroundColor: Colors.white,
        iconColor: Colors.grey,
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
                      SizedBox(height: 31.0),
                      Text(
                        '登录密码重置',
                        style: TextStyle(
                          color: Color(0xff24262E),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 14.0),
                      RegisterPhoneInputTextFieldWidget(
                        title: '中国大陆 +86',
                        hintText: '输入您的手机号码',
                        controller: _phone,
                      ),
                    ],
                  ),
                ),
                RegisterButtonWidget(
                  title: '下一步',
                  onTap: () => sendCodeMethod(),
                ),
                SizedBox(height: 42.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendCodeMethod() {
    if (!strNoEmpty(_phone.text)) {
      showToast(context, '请输入手机号码');
    } else if (!isMobilePhoneNumber(_phone.text)) {
      showToast(context, '请输入正确的手机号码');
    } else {
      routePush(ResetPasswordCode(_phone.text));
    }
  }
}
