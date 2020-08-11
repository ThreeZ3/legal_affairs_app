import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/register_code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_phone_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_tips.dart';
import 'package:jh_legal_affairs/page/register/register_page.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/page/register/reset/reset_password.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 用户登录页面

class LoginPage extends StatefulWidget {
  static final id = 'Login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  TextEditingController _phone = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
    _pwd.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  loginMethod() {
    loginViewModel
        .login(
      context,
      password: _pwd.text,
      username: _phone.text,
    )
        .catchError((e) {
      JHData.clean();
      if (e?.message != '网络连接失败' || e.code == 999) {
        showToast(context, e.message);
      } else {
        showToast(context, '账号或密码错误');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        backgroundColor: Colors.white,
        iconColor: ThemeColors.colorOrange,
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () => routePush(RegisterPage()),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '注册',
                style: TextStyle(
                  color: ThemeColors.colorOrange,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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
                      SizedBox(height: 18.0),
                      RegisterTips(title: '登录您的'),
                      SizedBox(height: 20.0),
                      RegisterPhoneInputTextFieldWidget(
                        title: '中国大陆 +86',
                        hintText: '输入您的手机号码',
                        controller: _phone,
                      ),
                      SizedBox(height: 16.0),
                      RegisterCodeInputTextFieldWidget(
                        title: '密码',
                        hintText: '您的登录密码',
                        suffixDisplay: true,
                        length: 20,
                        controller: _pwd,
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () => routePush(ResetPassword()),
                        child: Text(
                          '忘记密码',
                          style: TextStyle(
                            color: ThemeColors.color333,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Space(),
                RegisterButtonWidget(
                  title: '登录',
                  onTap: () => loginMethod(),
                ),
                SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
