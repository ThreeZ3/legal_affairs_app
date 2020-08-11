import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/wallet/waller_detail_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///钱包 设置新支付密码

class ChangePayPassward extends StatefulWidget {
  final String verifyCode;
  final String mobileNum;

  const ChangePayPassward({Key key, this.verifyCode, this.mobileNum})
      : super(key: key);

  @override
  _ChangePayPasswardState createState() => _ChangePayPasswardState();
}

class _ChangePayPasswardState extends State<ChangePayPassward> {
  TextEditingController oldController;
  TextEditingController newController;
  TextEditingController reallyNewController;

  @override
  void initState() {
    oldController = TextEditingController();
    newController = TextEditingController();
    reallyNewController = TextEditingController();
    super.initState();
  }

  void putWallerPaymentCode() {
    print('我是；；；；；；' + widget.mobileNum);
    WallerPaymentCodeViewModel()
        .putWallerPaymentCode(
      context,
      code: widget.verifyCode,
      firstPassword: newController.text,
      secondPassword: reallyNewController.text,
      mobile: widget.mobileNum,
    )
        .catchError((e) {
      print('${e.toString()}');
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    oldController.dispose();
    newController.dispose();
    reallyNewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: Scaffold(
        appBar: NavigationBar(
          title: "设置新支付密码",
        ),
        backgroundColor: Color(0xffFF333333),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          children: <Widget>[
//            inputWidget(oldController, "原支付密码  ( 如未设置则留空 )"),
            inputWidget(newController, "输入新密码"),
            inputWidget(reallyNewController, "确认新密码"),
            new Space(),
            InkWell(
              onTap: () => putWallerPaymentCode(),
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "确定",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              '*仅用于修改支付密码',
              style: TextStyle(color: Color(0xffe1b96b), fontSize: 14),
            ),
//            InkWell(
//                onTap: () => routePush(new FindPasswordPage()),
//                child: Text(
//                  "忘记密码",
//                  style: TextStyle(color: themeColor, fontSize: 14),
//                ))
          ],
        ),
      ),
    );
  }

  Widget inputWidget(TextEditingController controller, String init) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.2, color: Color(0xffFF707070)))),
      child: TextField(
        controller: controller,
        style: inputStyle(),
        keyboardType: TextInputType.number,
        inputFormatters: numFormatter,
        decoration: InputDecoration.collapsed(
          hintText: init,
          hintStyle: inputTextStyle(),
        ),
        onChanged: (v) {
          if (v.length > 6) {
            controller.text = v.substring(0, 6);
          }
        },
      ),
    );
  }
}

TextStyle inputTextStyle() => TextStyle(
      color: Colors.white.withOpacity(0.8),
      fontSize: 16,
    );

TextStyle inputStyle() => TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
