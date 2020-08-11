import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';

///绑定支付宝账号
class AlipayBinding extends StatefulWidget {
  @override
  _AlipayBindingState createState() => _AlipayBindingState();
}

class _AlipayBindingState extends State<AlipayBinding> {
  TextEditingController alipayAccount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: new NavigationBar(
        title: "绑定支付宝账号",
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 50),
        child: ListView(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  children: <Widget>[
                    Text(
                      "支付宝账号     ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Expanded(
                        child: TextField(
                      controller: alipayAccount,
                      onChanged: (v) {
                        setState(() {});
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(color: Color(0xffE1B96B), fontSize: 14),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                )),
            RaisedButton(
              color: strNoEmpty(alipayAccount.text)
                  ? Color(0xffE1B96B)
                  : Colors.grey,
              onPressed: () {
                strNoEmpty(alipayAccount.text)
                    ? showDialog(
                        context: context,
                        builder: (context) {
                          return bindingdialog();
                        })
                    : showToast(context, "请输入支付宝账号");
              },
              child: Text(
                "登陆",
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

///弹窗
bindingdialog() {
  return AlertDialog(
    titlePadding: EdgeInsets.all(40),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "确定要",
          style: TextStyle(fontSize: 15),
        ),
        Text(
          "绑定",
          style: TextStyle(fontSize: 15, color: Color(0xffE1B96B)),
        ),
        Text(
          "此账户?",
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
    contentPadding: EdgeInsets.all(0),
    content: Row(
      children: <Widget>[
        Expanded(
            child: InkWell(
          onTap: () {
            pop();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey[300])),
            height: 40,
            child: Text(
              "取消",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            alignment: Alignment.center,
          ),
        )),
        Expanded(
            child: Container(
          color: Color(0xffE1B96B),
          height: 40,
          child: Text(
            "确定",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          alignment: Alignment.center,
        )),
      ],
    ),
  );
}
