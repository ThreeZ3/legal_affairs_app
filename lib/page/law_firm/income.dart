import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///今日收入
///

class Income extends StatelessWidget {
  final  String title;

  const Income({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: title,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
          child: Column(
            children: [1,2,3,4,5,6,7].map((v){
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.2))
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: Image.asset("assets/images/lawyer/graphic.png",width: 45,height: 45,fit: BoxFit.cover,),
                        ),
                        SizedBox(width: 12,),
                        Text("$v 王甜甜",style: TextStyle(fontSize: 16),),
                        Spacer(),
                        _midYellowWord("￥ 4，000.00"),
                      ],
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
              );
            }).toList(),
          ),
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
