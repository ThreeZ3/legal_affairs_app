import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'add_member.dart';

///创建律所-创建完成

class CreateOk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: "创建律所",
        rightDMActions: <Widget>[
          InkWell(
              onTap: () =>
                  popToRootPage(),
              child: Container(
                padding: EdgeInsets.only(top: 16, right: 16,left: 16),
                child: Text(
                  "完成",
                  style: TextStyle(fontSize: 14, color: themeMainColor),
                ),
              ))
        ],
      ),
      body: Container(
          width: winWidth(context),
          color: Colors.white,
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Icon(Icons.check_circle, color: themeMainColor, size: 44),
              SizedBox(
                height: 16,
              ),
              Text(
                "创建完成等待审核",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
