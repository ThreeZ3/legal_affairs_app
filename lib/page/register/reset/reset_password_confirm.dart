import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/register_code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_password_tips.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 重置密码设置

class ResetPasswordConfirm extends StatefulWidget {
  final String phone;

  ResetPasswordConfirm(this.phone);

  @override
  _ResetPasswordConfirmState createState() => _ResetPasswordConfirmState();
}

class _ResetPasswordConfirmState extends State<ResetPasswordConfirm> {
  TextEditingController _pwdOne = TextEditingController();
  TextEditingController _pwdTwo = TextEditingController();

  //判断两次密码是否输入完成
  bool _display = false;
  bool _displayOne = false;
  bool _displayTwo = false;

  void _dataNull() {
    if (_displayOne == true && _displayTwo == true) {
      if (_pwdOne.text.length == _pwdTwo.text.length) {
        _display = true;
      } else {
        _display = false;
      }
    } else {
      _display = false;
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              '两次填写的密码不一致',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.color333,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child:
                    RegisterButtonWidget(title: '确定', onTap: () => maybePop()),
              ),
            ],
          );
        });
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
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 31.0),
                      RegisterPasswordTips(title: '设置新登录密码'),
                      SizedBox(height: 16.0),
                      RegisterCodeInputTextFieldWidget(
                        title: '密码',
                        hintText: '设置登录密码',
                        suffixDisplay: true,
                        length: 12,
                        controller: _pwdOne,
                        onChanged: (value) {
                          if (_pwdTwo.text.length > 0) {
                            _displayTwo = true;
                            print("_displayTwo$_displayTwo");
                          }
                          setState(() {
                            _dataNull();
                          });
                        },
                      ),
                      SizedBox(height: 14.0),
                      RegisterCodeInputTextFieldWidget(
                        title: '确定密码',
                        hintText: '请再次输入密码',
                        suffixDisplay: true,
                        length: 12,
                        controller: _pwdTwo,
                        onChanged: (value) {
                          if (_pwdTwo.text.length > 0) {
                            _displayTwo = true;
                            print("_displayTwo$_displayTwo");
                          }
                          setState(() {
                            _dataNull();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                RegisterButtonWidget(
                  title: _display ? '登录' : '下一步',
                  onTap: () => registerMethod(),
                ),
                SizedBox(height: 42.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerMethod() {
    if (_pwdOne.text != _pwdTwo.text) {
      _showDialog();
    } else {
      //当没有输入值时判断
      if (_pwdOne.text.length == null && _pwdTwo.text.length == null) {
        _showDialog();
      } else {
//        print('设置成功');
        loginViewModel
            .resetPw(
          context,
          mobile: widget.phone,
          firstPassword: _pwdOne.text,
          secondPassword: _pwdTwo.text,
        )
            .catchError((e) {
          showToast(context, e.message);
        });
        /*routePush(ResetComplete());*/
      }
    }
  }
}
