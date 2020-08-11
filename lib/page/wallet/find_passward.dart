import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/wallet/change_pay_password.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

///找回密码
class FindPasswordPage extends StatefulWidget {
  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  TextEditingController _code;
  TextEditingController inputNum;
  var phone = '';
  var _sharedPreferences;

  @override
  void initState() {
    _code = TextEditingController();
    inputNum = TextEditingController();
    getNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainInputBody(
      child: Scaffold(
        backgroundColor: Color(0xffFF333333),
        appBar: NavigationBar(
          title: "找回密码",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Color(0xffFF707070),
              ))),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "手机号",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hiddenPhone(phone),
                      style: TextStyle(color: Color(0xff686868)),
                    ),
//                    TextField(
//                      controller: inputNum,
//                      style: TextStyle(color: Colors.white),
//                      keyboardType: TextInputType.number,
//                      cursorColor: Colors.white,
//                      cursorWidth: 1,
//                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                      ),
//                      onSubmitted: (v) {
//                        print(hiddenPhone(inputNum.text));
//                      },
//                    ),
                  ),
                ],
              ),
            ),
            _widget(),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () => checkCodeMethod(),
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "下一步",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              '*仅用于修改支付密码',
              style: TextStyle(color: Color(0xffe1b96b), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widget() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffFF707070),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  '短信验证码',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Container(
                width: 80.0,
                child: TextField(
                  controller: _code,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
//                    hintText: '输入验证码',
//                    hintStyle: TextStyle(
//                      color: Colors.white,
//                      fontSize: 16.0,
//                    ),
                  ),
                  cursorColor: Colors.white,
                  cursorWidth: 1,
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffFFE1B96B)),
                  color: Color(0xffFF5A5A5A),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: isButtonEnable
                      ? ThemeColors.colorOrange
                      : ThemeColors.color999,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isButtonEnable = true;
  String buttonText = '获取';
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
              buttonText = '获取';
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
      phone,
    )
        .then((rep) {
      isButtonEnable = false;
      _initTimer();
    }).catchError((e) {
      showToast(context, '${e.message}');
    });
  }

  void checkCodeMethod() {
//    if (!isMobilePhoneNumber(inputNum.text)) {
//      showToast(context, '请输入正确手机号');
//    } else {
    loginViewModel
        .checkCode(
      context,
      verifyCode: _code.text,
      mobile: phone,
    )
        .then((rep) {
      routePush(ChangePayPassward(
        verifyCode: _code.text,
        mobileNum: phone,
      ));
    }).catchError((e) {
      showToast(context, e.message);
    });
//    }
  }

  getNumber() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    phone = await _sharedPreferences.getString(JHActions.mobile());
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
    _code.dispose();
    inputNum.dispose();
  }
}
