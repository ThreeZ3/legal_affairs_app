import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/page/law_firm/income.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///收入统计
///
class IncomeStatistics extends StatefulWidget {
  final String id;
  final MyFirmModel data;

  const IncomeStatistics({
    Key key,
    this.id,
    this.data,
  }) : super(key: key);
  @override
  _IncomeStatisticsState createState() => _IncomeStatisticsState();
}

class _IncomeStatisticsState extends State<IncomeStatistics> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List categoryList = widget.data?.legalField ?? [];
    return Scaffold(
      appBar: NavigationBar(
        title: "收入统计",
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
            widget.data?.firmAvatar ??
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590051812871&di=c2413ccce6d546a32ab966100ff8b02d&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F64%2F76%2F20300001349415131407760417677.jpg',
            width: winWidth(context),
            height: winWidth(context) * 0.64,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.data?.firmName ?? '未知',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    _smallYellowWord("350"),
                    Container(
                      padding: EdgeInsets.only(left: 4, right: 8),
                      child: _smallBlackWord("名律师"),
                    ),
                    _smallBlackWord('${widget.data?.district ?? '未知'}'),
                    SizedBox(
                      width: 5,
                    ),
                    VerticalLine(
                      height: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    _smallBlackWord("${widget.data?.town ?? '未知'}"),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: categoryList.map((v) {
                    return _label(v.name);
                  }).toList(),
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                  children: ["今日收入", "本周收入", "本月收入", "本年收入"].map((v) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Income(
                                    title: v,
                                  ))),
                      child: Container(
                        padding: EdgeInsets.only(top: 9, bottom: 4),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.2))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _subTitleBlackWord(v),
                                Spacer(),
                                _midYellowWord("￥ 4，000.00")
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: <Widget>[
                                  _midBlackWord("咨询： "),
                                  _smallYellowWord("￥ 4，000.00"),
                                  Spacer(),
                                  _midBlackWord("合同： "),
                                  _smallYellowWord("￥ 4，000.00"),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: <Widget>[
                                  _midBlackWord("咨询： "),
                                  _smallYellowWord("￥ 4，000.00"),
                                  Spacer(),
                                  _midBlackWord("合同： "),
                                  _smallYellowWord("￥ 4，000.00"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _label(String str) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        color: Color(0xffFFF0F0F0),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        "$str",
        style: TextStyle(
          color: Color(0xffFFE1B96B),
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _smallYellowWord(String str) {
    return Text(
      "$str",
      style: TextStyle(
        color: Color(0xffFFE1B96B),
        fontSize: 12,
      ),
    );
  }

  Widget _midYellowWord(String str) {
    return Text(
      "$str",
      style: TextStyle(
        color: Color(0xffFFE1B96B),
        fontSize: 18,
      ),
    );
  }

  Widget _smallBlackWord(String str) {
    return Text(
      "$str",
      style: TextStyle(
        color: Color(0xffFF333333),
        fontSize: 12,
      ),
    );
  }

  Widget _subTitleBlackWord(String str) {
    return Text(
      "$str",
      style: TextStyle(
        color: Color(0xffFF333333),
        fontSize: 16,
      ),
    );
  }

  Widget _midBlackWord(String str) {
    return Text(
      "$str",
      style: TextStyle(
        color: Color(0xffFF333333),
        fontSize: 14,
      ),
    );
  }
}
