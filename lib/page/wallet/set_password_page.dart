import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///钱包 登录钱包 设置密码

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: NavigationBar(title: "设置密码"),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF707070)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF707070)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "设置支付密码",
                hintStyle: TextStyle(color: Color(0xffffffff), fontSize: 16),
              ),
            ),
          ),
          Space(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF707070)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF707070)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "确认支付密码",
                hintStyle: TextStyle(color: Color(0xffffffff), fontSize: 16),
              ),
            ),
          ),
          Space(height: 24),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 44,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Color(0xFFE1B96B),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                "确定",
                style: TextStyle(color: Color(0xff333333), fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
