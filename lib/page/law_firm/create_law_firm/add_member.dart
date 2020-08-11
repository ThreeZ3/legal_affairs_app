import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

import 'add_member_two.dart';

///添加成员

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  TextEditingController nameC = new TextEditingController();
  TextEditingController idC = new TextEditingController();
  TextEditingController numC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<MemberModel> list = [
      MemberModel(name: "律师姓名", init: "输入律师姓名", controller: nameC),
      MemberModel(name: "身份证号", init: "输入身份证号", controller: idC),
      MemberModel(name: "执业证号", init: "输入执业证号", controller: numC),
    ];
    return new MainInputBody(
      child: Scaffold(
        appBar: NavigationBar(
          title: "添加成员",
          rightDMActions: <Widget>[
            InkWell(
              onTap: () => handle(),
              child: Container(
                padding: EdgeInsets.only(top: 16, right: 16),
                child: Text(
                  "下一步",
                  style: TextStyle(fontSize: 14, color: themeMainColor),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: new Text(
                  '*任意填写一个参数即可',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              new Expanded(
                  child: Column(
                      children: list.map((v) {
                return MemberBuild(
                  data: v,
                );
              }).toList())),
            ],
          ),
        ),
      ),
    );
  }

  handle() {
    if (strNoEmpty(nameC.text) ||
        strNoEmpty(numC.text) ||
        strNoEmpty(idC.text)) {
      routePush(
        AddMemberPageTwo(
          name: nameC.text,
          num: numC.text,
          id: idC.text,
        ),
      );
    } else {
      showToast(context, '请任意添加一项参数');
    }
  }
}

Color themeMainColor = Color(0xffFFE1B96B);
Color themeGrayColor = Color(0xffFF999999);
Color lightGrayColor = Color(0xffFFF0F0F0);

class MemberBuild extends StatelessWidget {
  final MemberModel data;

  const MemberBuild({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border:
                  Border(left: BorderSide(width: 2, color: themeMainColor))),
          padding: EdgeInsets.only(left: 2),
          margin: EdgeInsets.only(bottom: 8, top: 16),
          child: Text(
            data.name ?? "name",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 100,
          child: TextField(
            controller: data.controller,
            decoration: InputDecoration.collapsed(
              hintStyle: TextStyle(fontSize: 14, color: themeGrayColor),
              hintText: data.init ?? "init",
            ),
          ),
        )
      ],
    );
  }
}

class MemberModel {
  final String name;
  final String init;
  final TextEditingController controller;

  MemberModel({this.name, this.init, this.controller});
}
