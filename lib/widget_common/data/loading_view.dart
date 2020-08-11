import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/common/global_variable.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-18
///
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: winWidth(context),
      height: 300,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(themeColor),
          ),
          new Space(),
          new Text(
            '加载中',
            style: TextStyle(color: themeColor),
          ),
        ],
      ),
    );
  }
}
