import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/register/common/code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_code_tips.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/page/register/reset/reset_password_confirm.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 重置密码设置 - 验证码

class ResetPasswordCode extends StatefulWidget {
  final String phone;

  ResetPasswordCode(this.phone);

  @override
  _ResetPasswordCodeState createState() => _ResetPasswordCodeState();
}

class _ResetPasswordCodeState extends State<ResetPasswordCode> {
  TextEditingController _code = TextEditingController();

  @override
  void initState() {
    super.initState();
//    loginViewModel
//        .sendCode(
//      context,
//      widget.phone,
//    )
//        .catchError((e) {
//      showToast(context, '${e.message}');
//    });
  }

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
  }

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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 31.0),
                      RegisterCodeTips(
                        title: '输入手机验证码',
                        text: '+86 ${hiddenPhone(widget.phone)}',
                      ),
                      SizedBox(height: 19.0),
                      CodeInputTextFieldWidget(
                        controller: _code,
                        phone: widget.phone,
                      ),
                    ],
                  ),
                ),
                RegisterButtonWidget(
                  title: '下一步',
                  onTap: () => checkCodeMethod(),
                ),
                SizedBox(height: 42.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkCodeMethod() {
    if (strNoEmpty(_code.text)) {
      routePush(ResetPasswordConfirm(widget.phone));
    } else {
      showToast(context, '请输入验证码');
    }
//    loginViewModel
//        .checkCode(
//      context,
//      verifyCode: _code.text,
//      mobile: widget.phone,
//    )
//        .then((rep) {
//      if (rep != null) {
//        rep.data['code'] == 200
//            ? routePush(ResetPasswordConfirm(widget.phone))
//            : print('验证码错误');
//      }
//    }).catchError((e){
//      showToast(context, e.message);
//    });
  }
}
