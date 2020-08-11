import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/page/wallet/recharge_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-16
///
/// 钱包 充值

enum OptionType { topUp, withdraw }

class RechargPage extends StatefulWidget {
  final OptionType type;
  RechargPage(this.type);

  @override
  _RechargPageState createState() => _RechargPageState();
}

class _RechargPageState extends State<RechargPage> {
  @override
  Widget build(BuildContext context) {
    String typeStr = widget.type == OptionType.topUp ? '充值' : '提现';
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Color(0xff333333),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xff333333),
            appBar: new NavigationBar(title: typeStr),
            body: Container(
              margin: EdgeInsets.only(left: 16, top: 24, right: 16),
              child: ListView(
                children: <Widget>[
                  ReChargeDemo(
                    text: '支付宝',
                    tall: typeStr,
                    pic: Image.asset("assets/images/mine/zhifubao.png"),
                    onTap: () => routePush(new RechargeDetailsPage(
                        RechargeType.aliPay, widget.type)),
                  ),
                  SizedBox(height: 24),
                  ReChargeDemo(
                    text: '微信',
                    tall: typeStr,
                    pic: Image.asset("assets/images/mine/weixin.png"),
                    onTap: () => routePush(new RechargeDetailsPage(
                        RechargeType.weChat, widget.type)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//充值Container样式
class ReChargeDemo extends StatefulWidget {
  final String text;
  final String tall;
  final Function onTap;
  final Widget pic;

  ReChargeDemo({this.text, this.tall, this.onTap, this.pic});

  @override
  _ReChargeDemoState createState() => _ReChargeDemoState();
}

class _ReChargeDemoState extends State<ReChargeDemo> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 88,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE1B96B),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 24,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '从  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.text,
                      style: TextStyle(
                        color: Color(0xffD9B368),
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: '  ${widget.tall}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                width: 40,
                height: 40,
                child: widget.pic,
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
