import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///推送位置选择

class MyAdSelectTypePage extends StatefulWidget {
  @override
  _MyAdSelectTypePageState createState() => _MyAdSelectTypePageState();
}

class _MyAdSelectTypePageState extends State<MyAdSelectTypePage> {
  String pushPath;
  var _select;
  List sysAllList = List();

  //返回数据
  AdSysAllModel returnData = AdSysAllModel();

  ///获取所有推送位置信息
  void getAdSysAll() {
    adViewModel.adSysAll(context).then((rep) {
      setState(() {
        sysAllList = List.from(rep.data);
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getAdSysAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '选择推送位置',
        rightDMActions: <Widget>[
          InkWell(
            onTap: () {
              /*pop(pushPath);*/
              pop(returnData);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              /* child: Image.asset(
                'assets/images/mine/share_icon@3x.png',
                width: 22.0,
              ),
            ),*/
              child: Center(
                child: Text(
                  '确定',
                  style:
                      TextStyle(color: ThemeColors.colorOrange, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: ListView(
          children: sysAllList.map((item) {
            AdSysAllModel model = item;
            return InkWell(
              onTap: () {
                setState(() {
                  _select = item;
                  /*pushPath = model.name.split(';')[0];*/
                  returnData = model;
                  print('选择了::::::${model.name}');
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model?.name ?? '未知位置',
                      style: TextStyle(
                        color: ThemeColors.color333,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _select == item
                        ? Image.asset(
                            'assets/images/mine/icon_select.png',
                            width: 19.25,
                            height: 14,
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
