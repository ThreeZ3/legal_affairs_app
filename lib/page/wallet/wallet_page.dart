import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/wallet/waller_detail_view_model.dart';
import 'package:jh_legal_affairs/page/wallet/wallet_money_detail.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:jh_legal_affairs/page/wallet/wallet_recharge_page.dart';

import 'find_passward.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double _money;

  @override
  void initState() {
    super.initState();
    getWallerDetailMoney();
  }

  void getWallerDetailMoney() {
    WallerMoneyViewModel().getWallerMoneyViewModel(context).then((rep) {
      setState(() {
        _money = rep.data["data"];
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      backgroundColor: Colors.white,
      backgroundColor: Color(0xff333333),
      appBar: new NavigationBar(
        title: '钱包',
        rightDMActions: <Widget>[
          InkWell(
            onTap: () {
              routePush(FindPasswordPage());
            },
            child: new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.lock, color: Color(0xffE1B96B)),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
//            Container(
//              decoration: BoxDecoration(
//                border: Border.all(color: Color(0xffE1B96B)),
//              ),
//              width: 240.0,
//              height: 240.0,
//            ),
            SizedBox(height: 20),
            Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Color(0xffE1B96B),
                      radius: 120.0,
                      child: CircleAvatar(
                        backgroundColor: Color(0xff333333),
                        radius: 112.0,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              '0.0',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                            Text(
                              "累计收入",
                              style: TextStyle(
                                  color: Color(0xff999999), fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${_money?.toString() ?? '0'}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                            Text(
                              "钱包余额",
                              style: TextStyle(
                                  color: Color(0xff999999), fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Container(
                        color: Color(0xff333333),
                        child: SizedBox(
                          height: 60,
                        )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff5A5A5A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffE1B96B))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, right: 17, bottom: 6, left: 17),
                      child: Text(
                        "收支明细",
                        style:
                            TextStyle(color: Color(0xffE1B96B), fontSize: 18.0),
                      ),
                    ),
                  ),
                  onTap: () => routePush(new WalletMoneyDetail()),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      routePush(RechargPage(OptionType.topUp));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff5A5A5A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffE1B96B))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 6, right: 17, bottom: 6, left: 17),
                        child: Text(
                          "充值",
                          style: TextStyle(color: Colors.white, fontSize: 26.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      routePush(RechargPage(OptionType.withdraw));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff5A5A5A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffE1B96B))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 6, right: 17, bottom: 6, left: 17),
                        child: Text(
                          "提现",
                          style: TextStyle(color: Colors.white, fontSize: 26.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '今日收入',
                        style:
                            TextStyle(color: Color(0xffE1B96B), fontSize: 18),
                      ),
                      Text(
                        '${0.0}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '昨日收入',
                        style:
                            TextStyle(color: Color(0xffE1B96B), fontSize: 18),
                      ),
                      Text(
                        '${0.0}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text("今日收入统计",
//                    style: TextStyle(color: Color(0xff999999), fontSize: 18))
//              ],
//            ),
//            SizedBox(height: 20),
//            Container(
//              height: 200,
//              child: SparkBar(SparkBar._createSampleData()),
//            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

///============================================
class SparkBar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SparkBar(this.seriesList, {this.animate});

  factory SparkBar.withSampleData() {
    return new SparkBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
//      domainAxis: new charts.OrdinalAxisSpec(),

      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
//                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.yellow.shadeDefault.darker),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent))),
    );
  }

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('2007', 3100),
      new OrdinalSales('2008', 3500),
      new OrdinalSales('2009', 5000),
      new OrdinalSales('2010', 2500),
      new OrdinalSales('2011', 3200),
      new OrdinalSales('2012', 4500),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Global Revenue',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: globalSalesData,
          outsideLabelStyleAccessorFn: (OrdinalSales sales, _) {
            final color = charts.MaterialPalette.yellow.shadeDefault.darker;

            return new charts.TextStyleSpec(color: color);
          },
          insideLabelStyleAccessorFn: (OrdinalSales sales, _) {
            final color = charts.MaterialPalette.black;
            return new charts.TextStyleSpec(color: color);
          },
          colorFn: (_, __) => charts.Color(r: 225, b: 107, g: 185, a: 100),
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.sales.toString()}'),
    ];
  }
}
