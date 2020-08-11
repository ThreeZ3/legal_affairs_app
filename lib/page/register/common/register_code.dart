import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_code_tips.dart';
import 'package:jh_legal_affairs/page/register/common/register_password.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 注册接收验证码页面

class RegisterCode extends StatefulWidget {
  final String phone;
  final bool isLawyer;
  final String id;

  RegisterCode(this.phone, [this.isLawyer = false, this.id = '']);

  @override
  _RegisterCodeState createState() => _RegisterCodeState();
}

class _RegisterCodeState extends State<RegisterCode> {
  TextEditingController _code = TextEditingController();

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
        brightness: Brightness.light,
        iconColor: ThemeColors.colorOrange,
      ),
      body: Padding(
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
                    RegisterCodeTips(
                      title: '输入收到的验证码',
                      text: '+86 ${hiddenPhone(widget.phone)}',
                    ),
                    SizedBox(height: 24.0),
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
              SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
            ],
          ),
        ),
      ),
    );
  }

  void checkCodeMethod() async {
    if (!strNoEmpty(widget.phone) || !strNoEmpty(_code.text)) {
      showToast(context, '请输入参数信息');
//      return;
    } else {
      loginViewModel
          .checkCode(
        context,
        verifyCode: _code.text,
        mobile: widget.phone,
      )
          .then((rep) {
        routePush(RegisterPassword(
          widget.phone,
          _code.text,
          widget.isLawyer,
          widget.id,
        ));
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
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
//            ? routePush(RegisterPassword(widget.phone, _code.text))
//            : print('验证码错误');
//      }
//    }).catchError((e){
//      showToast(context, '${e.message.toString()}');
//    });
//  }
}
