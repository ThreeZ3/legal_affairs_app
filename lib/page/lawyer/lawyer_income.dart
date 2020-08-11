import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///律师收入统计
///待优化

class LawyerIncome extends StatefulWidget {
  @override
  _LawyerIncomeState createState() => _LawyerIncomeState();
}

class _LawyerIncomeState extends State<LawyerIncome> {
  List<AdIncomesRequestModel> data = new List();
  int goPage = 1;
  bool isLoadingOk = false;

  @override
  void initState() {
    super.initState();
    getIncomeData();
  }

  Future getIncomeData([bool isInit = false]) async{
    if (isInit) goPage = 1;
    return adViewModel
        .adIncomes(
      context,
      page: goPage,
      limit: 10,
      id: JHData.id(),
    )
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      print('${e.toString()}');
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(title: "收入统计"),
      backgroundColor: Colors.white,
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: data,
        onRefresh: () => getIncomeData(true),
        onLoad: (){
          goPage++;
          return getIncomeData();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: data.map((v) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "assets/images/lawyer/graphic.png",
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "$v 王甜甜",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      _midYellowWord("￥ 4,000.00"),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: <Widget>[
                        _midBlackWord("咨询： "),
                        _smallYellowWord("￥ 4,000.00"),
                        Spacer(),
                        _midBlackWord("合同： "),
                        _smallYellowWord("￥ 4,000.00"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _smallYellowWord(String str) {
    return Text(
      "$str" ?? '',
      style: TextStyle(
        color: Color(0xffFFE1B96B),
        fontSize: 12,
      ),
    );
  }

  Widget _midYellowWord(String str) {
    return Text(
      "$str" ?? '',
      style: TextStyle(
        color: Color(0xffFFE1B96B),
        fontSize: 18,
      ),
    );
  }

  Widget _midBlackWord(String str) {
    return Text(
      "$str" ?? '',
      style: TextStyle(
        color: Color(0xffFF333333),
        fontSize: 14,
      ),
    );
  }
}
