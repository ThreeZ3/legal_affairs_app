import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/wallet/record_tab_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class WalletMoneyDetail extends StatefulWidget {
  @override
  _WalletMoneyDetailState createState() => _WalletMoneyDetailState();
}

class _WalletMoneyDetailState extends State<WalletMoneyDetail>
    with SingleTickerProviderStateMixin {
  String start;
  String end;

  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);

    String time30 =
        DateTime.now().subtract(new Duration(days: 3 * 30)).toIso8601String();
    start = time30.toString().substring(0, time30.toString().indexOf('T'));
    String now = DateTime.now().toIso8601String();
    end = now.toString().substring(0, time30.toString().indexOf('T'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new NavigationBar(
        title: '收支明细',
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(50, 50, 50, 1),
            child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelColor: Color(0xff999999),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              tabs: <Widget>[
                new Tab(text: '支出'),
                new Tab(text: '收入'),
              ],
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                OutRecordPage('ex', start, end),
                OutRecordPage('in', start, end),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String data;
  final String option;

  const Details({
    Key key,
    this.data,
    this.option = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: winWidth(context),
      color: Color(0xff5a5a5a),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Space(height: mainSpace / 1.5),
          Text(
            data,
            style: TextStyle(
                fontSize: 16,
                color: Color(0XFFE1B96B),
                fontWeight: FontWeight.bold),
          ),
          strNoEmpty(option)
              ? new Space(height: mainSpace / 2)
              : new Container(),
          strNoEmpty(option)
              ? Text(
                  '$option',
                  style: TextStyle(color: Colors.white),
                )
              : new Container(),
          new Space(height: mainSpace / 1.5),
        ],
      ),
    );
  }
}
