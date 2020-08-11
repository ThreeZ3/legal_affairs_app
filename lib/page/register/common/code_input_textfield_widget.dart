import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 倒计时

class CodeInputTextFieldWidget extends StatefulWidget {
  final int length;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String phone;
  final bool isAuthInit;

  const CodeInputTextFieldWidget({
    Key key,
    this.length = 6,
    this.controller,
    this.onChanged,
    this.phone,
    this.isAuthInit = true,
  }) : super(key: key);

  @override
  _CodeInputTextFieldWidgetState createState() =>
      _CodeInputTextFieldWidgetState();
}

class _CodeInputTextFieldWidgetState extends State<CodeInputTextFieldWidget> {
  bool isButtonEnable = true;
  String buttonText = '发送验证码';
  int count = 60;
  Timer timer;

  void _initTimer() {
    timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        count--;
        setState(
          () {
            if (count == 0) {
              timer.cancel();
              isButtonEnable = true;
              count = 60;
              buttonText = '重新获取';
            } else {
              buttonText = '$count秒后可重发';
            }
          },
        );
      },
    );
  }

  void _buttonClickListen() {
    if (!isButtonEnable) {
      showToast(context, '验证码已发送，请稍后重试');
    } else {
      sendCode();
    }
  }

  void sendCode() {
    loginViewModel
        .sendCode(
      context,
      widget.phone,
    )
        .then((rep) {
      isButtonEnable = false;
      _initTimer();
    }).catchError((e) {
      showToast(context, '${e.message}');
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isAuthInit) _buttonClickListen();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '验证码',
              style: TextStyle(color: ThemeColors.color999, fontSize: 14.0),
            ),
            SizedBox(width: 16.0),
            Container(
              width: 100.0,
              child: TextField(
                controller: widget.controller,
                maxLines: 1,
                autofocus: false,
                onChanged: widget.onChanged,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(widget.length),
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '输入验证码',
//                  hintStyle: TextStyle(
//                    color: Color.fromARGB(1, 51, 51, 51),
//                    fontSize: 14.0,
//                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(17, 21, 43, 0.08),
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            _buttonClickListen();
          },
          child: Container(
            child: Text(
              buttonText,
              style: TextStyle(
                color: isButtonEnable
                    ? ThemeColors.colorOrange
                    : ThemeColors.color999,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
