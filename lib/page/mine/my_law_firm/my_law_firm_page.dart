import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_detail_list.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_detail_module.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_lawy_firm_logo.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：李鸿杰
/// 开发者：李鸿杰
/// 创建日期：2020-05-09
///
/// 我的-我的律所-超级管理员
///

class MyLawFirmPage extends StatefulWidget {
  @override
  _MyLawFirmPageState createState() => _MyLawFirmPageState();
}

class _MyLawFirmPageState extends State<MyLawFirmPage> {
  MyFirmModel _data = new MyFirmModel();
  @override
  void initState() {
    super.initState();
    viewMyFirm();
    Notice.addListener(JHActions.viewMyFirmRefresh(), (v) {
      viewMyFirm();
    });
  }

  ///查看我的律所数据
  viewMyFirm() {
    myLawFirmViewModel.viewMyFirm(context).then((rep) {
      setState(() {
        _data = rep.data;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.viewMyFirmRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: NavigationBar(
        title: '律所详情',
      ),
      body: ListView(
        children: <Widget>[
          MyLawFirmLogo(data: _data), //律所logo
          MyLawFirmDetailModule(data: _data), //律所详情模块
          MyLawFirmDetailList(data: _data), //详情列表
        ],
      ),
    );
  }
}
