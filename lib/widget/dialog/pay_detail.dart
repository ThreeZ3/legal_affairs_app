import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/system/pay_view_model.dart';
import 'package:jh_legal_affairs/page/wallet/input_password.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_alipay/flutter_alipay.dart';

enum payType { weChat, aliPay, balance }

///付款详情
Future<bool> payDetailDialog(
  context, {
  payType type,
  String itemId,
  int orderType,
  String price,
  String amount,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return PayDetailDialog(
        type: type,
        itemId: itemId,
        orderType: orderType,
        price: price,
        amount: amount,
      );
    },
  );
}

///选择付款方式
Future selectTimeDialog(
  context, {
  @required final payType type,
  @required final int orderType,
  @required final String itemId,
  @required final String price,
  @required final String amount,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SelectTimeDialog(
        type: type,
        orderType: orderType,
        itemId: itemId,
        price: price,
        amount: amount,
      );
    },
  );
}

class PayDetailDialog extends StatefulWidget {
  final payType type;
  final String price;
  final String itemId;
  final String amount;
  final int orderType;

  const PayDetailDialog({
    Key key,
    this.type,
    this.price,
    this.itemId,
    this.orderType,
    this.amount,
  }) : super(key: key);

  @override
  _PayDetailDialogState createState() => _PayDetailDialogState();
}

class _PayDetailDialogState extends State<PayDetailDialog> {
  Map details;

  payType _type;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatPaymentResponse) {
        if (res.isSuccessful) {
          pop(true);
          if (mounted) showToast(context, '支付成功');
        }
      }
    });
  }

  placeOrder(payType type) {
    print('当前::${widget.itemId}');
    if (type == payType.balance) {
      return routePush(
          new ChongZhiPay(
            money: widget.price,
            itemId: widget.itemId,
            type: actionType.pay,
            orderType: widget.orderType,
          ),
          RouterType.fade);
//      payPassWordDialog(context);
    } else {
      payViewModel
          .placeOrder(
        context,
        amount: widget.amount,
        orderType: widget.orderType,
        //下单类型:1咨询，2合同，3.课程，11.充值
        payType: type == payType.weChat ? 2 : type == payType.aliPay ? 1 : 3,
        // 1=支付宝 2=微信 3=余额
        sourceId: widget.itemId,
      )
          .then((rep) {
        type == payType.weChat ? wxPay(rep) : aliPay(rep.data['data']);
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
  }

  aliPay(payOrder) async {
    FlutterAlipay.pay(payOrder).then((rep) {
      AlipayResult alipayResult = rep;
      pop(alipayResult.resultStatus == '9000');
      if (!strNoEmpty(alipayResult.resultStatus)) {
        showToast(context, '未知错误');
      } else if (alipayResult.resultStatus == '9000') {
        showToast(context, '支付成功');
      } else if (alipayResult.resultStatus == '4000') {
        showToast(context, '订单支付失败');
      } else if (alipayResult.resultStatus == '8000') {
        showToast(context, '正在处理中');
      } else if (alipayResult.resultStatus == '6001') {
        showToast(context, '用户中途取消');
      } else if (alipayResult.resultStatus == '6002') {
        showToast(context, '网络连接出错');
      } else if (alipayResult.resultStatus == '5000') {
        showToast(context, '重复请求');
      }
    });
  }

  wxPay(rep) {
    Map data = json.decode(rep.data['data']);
    fluwx
        .payWithWeChat(
      appId: data['appid'].toString(),
      partnerId: data['partnerid'].toString(),
      prepayId: data['prepayid'].toString(),
      packageValue: data['package'].toString(),
      nonceStr: data['noncestr'].toString(),
      timeStamp: int.parse(data['timestamp'].toString()),
      sign: data['sign'].toString(),
    )
        .then((data) {
      if (!data) {
        showToast(context, '调用微信支付失败');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '付款详情',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff707070),
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: new InkWell(
          onTap: () => pop(false),
          child: Icon(
            Icons.cancel,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    '￥${formatNum(widget.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff707070),
                      fontSize: 27,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 29, right: 22, bottom: 70),
                  child: new InkWell(
                    onTap: () {
                      selectTimeDialog(
                        context,
                        itemId: widget.itemId,
                        type: _type,
                        orderType: widget.orderType,
                        price: widget.price,
                        amount: widget.amount,
                      ).then((thenType) {
                        if (thenType == null) {
                          return;
                        } else {
                          setState(() => _type = thenType);
                        }
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          '支付方式',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff707070),
                              fontSize: 16),
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            Text(
                              '${_type == payType.weChat ? '微信支付' : _type == payType.aliPay ? '支付宝' : '余额支付'}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff707070),
                                  fontSize: 16),
                            ),
                            Space(),
                            new Icon(
                              CupertinoIcons.right_chevron,
                              color: ThemeColors.color999,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: ThemeColors.colorOrange,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: FlatButton(
                          onPressed: () => placeOrder(_type),
                          child: Text('立即支付'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    /*return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            '付款详情',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff707070),
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          leading: new InkWell(
            onTap: () => pop(false),
            child: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50.0),
                    child: Text(
                      '￥${formatNum(widget.price)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                        fontSize: 27,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 29, right: 22, bottom: 70),
                    child: new InkWell(
                      onTap: () {
                        selectTimeDialog(
                          context,
                          itemId: widget.itemId,
                          type: _type,
                          orderType: widget.orderType,
                          price: widget.price,
                          amount: widget.amount,
                        ).then((thenType) {
                          if (thenType == null) {
                            return;
                          } else {
                            setState(() => _type = thenType);
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '支付方式',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff707070),
                                fontSize: 16),
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              Text(
                                '${_type == payType.weChat ? '微信支付' : _type == payType.aliPay ? '支付宝' : '余额支付'}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff707070),
                                    fontSize: 16),
                              ),
                              Space(),
                              new Icon(
                                CupertinoIcons.right_chevron,
                                color: ThemeColors.color999,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: ThemeColors.colorOrange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: FlatButton(
                            onPressed: () => placeOrder(_type),
                            child: Text('立即支付'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        bool result = await confirmAlert<bool>(
          context,
          (bool isOk) {
            if (isOk == null || !isOk) return false;
            return pop(false);
          },
          input: false,
          tips: '你确定要放弃支付吗？',
          length: 6,
          hintTextSize: 12.0,
        );
        return result ?? false;
      },
    );*/
  }
}

class SelectTimeDialog extends StatefulWidget {
  final payType type;
  final int orderType;
  final String itemId;
  final String price;
  final String amount;

  SelectTimeDialog({
    @required this.type,
    @required this.orderType,
    @required this.itemId,
    @required this.price,
    @required this.amount,
  });

  @override
  _SelectTimeDialogState createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<SelectTimeDialog> {
  payType _type;

  @override
  void initState() {
    super.initState();
    _type = payType.weChat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    '取消',
                    style: TextStyle(color: Color(0xff181111), fontSize: 14),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  '付款方式',
                  style: TextStyle(
                      color: Color(0xff181111),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                CupertinoButton(
                  child: Text(
                    '确定',
                    style: TextStyle(color: Color(0xff181111), fontSize: 14),
                  ),
                  onPressed: () {
                    pop(_type);
//                    return payDetailDialog(
//                      context,
//                      type: _type,
//                      orderType: widget.orderType,
//                      itemId: widget.itemId,
//                      price: widget.price,
//                      amount: widget.amount,
//                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.0,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (i) {
                if (i == 0) {
                  _type = payType.weChat;
                } else if (i == 1) {
                  _type = payType.aliPay;
                } else {
                  _type = payType.balance;
                }
              },
              children: <Widget>[
                new Container(
                  height: 30.0,
                  alignment: Alignment.center,
                  child: Text('微信支付'),
                ),
                new Container(
                  height: 30.0,
                  alignment: Alignment.center,
                  child: Text('支付宝支付'),
                ),
                new Container(
                  height: 30.0,
                  alignment: Alignment.center,
                  child: Text('余额支付'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
