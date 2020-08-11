import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/register_code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_password_tips.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 普通用户注册 - 密码设置

class RegisterPassword extends StatefulWidget {
  final String phone;
  final String code;
  final bool isLawyer;
  final String id;

  RegisterPassword(this.phone, this.code,
      [this.isLawyer = false, this.id = '']);

  @override
  _RegisterPasswordState createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
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
  void dispose() {
    _pwdOne.dispose();
    _pwdTwo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        backgroundColor: Colors.white,
        iconColor: ThemeColors.colorOrange,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      RegisterPasswordTips(title: '账号密码设置'),
                      SizedBox(height: 16.0),
                      RegisterCodeInputTextFieldWidget(
                        title: '密码',
                        hintText: '设置登录密码',
                        suffixDisplay: true,
                        length: 20,
                        controller: _pwdOne,
                        onChanged: (value) {
                          if (_pwdOne.text.length > 0) {
                            _displayOne = true;
                            setState(() {
                              _dataNull();
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16.0),
                      RegisterCodeInputTextFieldWidget(
                        title: '确定密码',
                        hintText: '请再次输入',
                        suffixDisplay: true,
                        length: 20,
                        controller: _pwdTwo,
                        onChanged: (value) {
                          if (_pwdTwo.text.length > 0) {
                            _displayTwo = true;
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
                  title: _display ? '注册' : '下一步',
                  onTap: () => registerMethod(),
                ),
                SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
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
        if (!widget.isLawyer) {
          loginViewModel
              .register(
            context,
            mobile: widget.phone,
            firstPassword: _pwdOne.text,
            secondPassword: _pwdTwo.text,
          )
              .catchError((e) {
            showToast(context, '${e.message}');
          });
        } else {
          lawyerInFoViewModel
              .lawyerSetPassword(
            context,
            id: widget.id,
            mobile: widget.phone,
            firstPassword: _pwdOne.text,
            secondPassword: _pwdTwo.text,
          )
              .catchError((e) {
            showToast(context, '${e.message}');
          });
        }
      }
    }
  }
}
