import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/other/complaint_page.dart';
import 'package:jh_legal_affairs/page/other/privacy_policy_page.dart';
import 'package:jh_legal_affairs/page/other/protocol_page.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/update_dialog.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  TextStyle style = TextStyle(
      color: Color(0xffE1B96B),
      fontSize: 16,
      decoration: TextDecoration.underline);

  List data = [
    AboutModel('版本更新', '已是最新版本'),
    AboutModel('官方网站', ''),
    AboutModel('意见反馈', ''),
    AboutModel('客服电话', '13326675584'),
  ];

  handle(label) {
    switch (label) {
      case '客服电话':
        launchTel(context, '13326675584');
        break;
      case '版本更新':
        checkVersion();
        break;
      case '官方网站':
        launchURL(context, 'http://fazhikeji.cn/');
        break;
      case '意见反馈':
        routePush(new FeedbackPage());
        break;
    }
  }

  /// 检查更新 [check update]
  checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    systemViewModel.getVersion(context).then((rep) {
      VersionModel model = rep.data;
      int currentVersion = int.parse(removeDot(packageInfo.version));
      int netVersion = int.parse(removeDot(model.version));
      if (currentVersion >= netVersion) {
        showToast(context, '当前版本是最新版本');
        return;
      } else if (Platform.isIOS) {
        showToast(context, '当前版本需要更新，请手动切换到AppStore更新');
        return;
      }

      showDialog(
        context: context,
        builder: (ctx2) {
          return UpdateDialog(
            version: model.version,
            updateUrl: model.url,
            updateInfo: model.content,
            isForce: model.isUpdate == 1,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NavigationBar(title: '关于法π与帮助'),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView(
              children: <Widget>[
                new Space(),
                new Image.asset('assets/images/logo.png',
                    width: 90, height: 149),
                new Space(height: mainSpace * 2),
              ]..addAll(data.map((e) {
                  return new Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: new FlatButton(
                      onPressed: () => handle(e.label),
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: new Row(
                        children: <Widget>[
                          new Text(
                            e.label,
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          new Spacer(),
                          new Text(
                            e.subLabel,
                            style: TextStyle(
                              color: e.label == '客服电话'
                                  ? Color(0xffE1B96B)
                                  : Color(0xffBFBFBF),
                              fontSize: 14,
                            ),
                          ),
                          new Icon(
                            CupertinoIcons.right_chevron,
                            color: Color(0xffBFBFBF),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()),
            ),
          ),
          new Container(
            color: Colors.white,
            width: winWidth(context),
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      child: new Text('服务协议 | ', style: style),
                      onTap: () => routePush(new ProtocolPage()),
                    ),
                    new InkWell(
                      child: new Text('隐私政策', style: style),
                      onTap: () => routePush(new PrivacyPolicyPage()),
                    ),
                  ],
                ),
                new Text(
                  '群林科技 Copyright © 2020-06-03 V1.0',
                  style: TextStyle(color: Color(0xffBFBFBF), fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AboutModel {
  String label;
  String subLabel;

  AboutModel(this.label, this.subLabel);
}
