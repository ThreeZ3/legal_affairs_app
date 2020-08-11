import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/wallet/withdrawal_view_model.dart';
import 'package:jh_legal_affairs/page/wallet/input_password.dart';
import 'package:jh_legal_affairs/page/wallet/wallet_recharge_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';
import 'package:jh_legal_affairs/widget/wallet_keybroad.dart';

///充值 充值详情
enum RechargeType { weChat, aliPay }

class RechargeDetailsPage extends StatefulWidget {
  final RechargeType type; //微信、支付宝
  final OptionType optionType; //充值、提现

  RechargeDetailsPage(
    this.type,
    this.optionType,
  );

  @override
  _RechargeDetailsPageState createState() => _RechargeDetailsPageState();
}

class _RechargeDetailsPageState extends State<RechargeDetailsPage> {
  String _result;

  TextEditingController _priceC = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _priceC.text = '';
    super.initState();
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatPaymentResponse) {
        if (mounted)
          setState(() {
            _result = "pay:${res.isSuccessful}";
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String typeStr = widget.optionType == OptionType.topUp ? '充值' : '提现';
    String type = widget.type == RechargeType.weChat ?  '微信' : '支付宝';

    return new MainInputBody(
      child: Scaffold(
        backgroundColor: Color(0xff333333),
        appBar: NavigationBar(
          title: _result ?? typeStr,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$typeStr金额",
                style: TextStyle(color: Color(0xFFE1B96B), fontSize: 16),
              ),
              InkWell(
                child: TextField(
                  controller: _priceC,
                  style: TextStyle(color: Colors.white, fontSize: 36),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Text(
                      "￥",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "0.00",
                    hintStyle:
                        TextStyle(color: Color(0xffffffff), fontSize: 36),
                  ),
                  enabled: false,
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return NumberKeyboardActionSheet(
                          controller: _priceC,
                          label: typeStr,
                          onTap: () {
                            if (!strNoEmpty(_priceC.text)) {
                              showToast(context, '请输入金额');
                              return;
                            } else if (double.parse(_priceC.text) == 0.0) {
                              showToast(context, '金额不能为0');
                              return;
                            }
                            if (typeStr == '充值') {
                              if (type == '支付宝') {
                                payDetailDialog(
                                  context,
                                  type: payType.aliPay,
                                  orderType: 11,
                                  price: _priceC.text,
                                  amount: _priceC.text,
                                ).then((v) => pop(v));
                              } else if (type == '微信') {
                                payDetailDialog(
                                  context,
                                  type: payType.weChat,
                                  orderType: 11,
                                  price: _priceC.text,
                                  amount: _priceC.text,
                                ).then((v) => pop(v));
                              }
                            } else {
                              if (type == '支付宝') {
                                print('进入支付宝提现');
                                showDialog(
                                    context: context,
                                    builder: (b) {
                                      return ChongZhiPay(
                                        money: '￥${formatNum(_priceC.text)}',
                                        type: actionType.withdraw,
                                        orderType: 1,
                                      );
                                    });
                              } else if (type == '微信') {
                                showDialog(
                                    context: context,
                                    builder: (b) {
                                      return ChongZhiPay(
                                        money: '￥${formatNum(_priceC.text)}',
                                        type: actionType.withdraw,
                                        orderType: 2,
                                      );
                                    });
                              }
                            }
                          },
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
