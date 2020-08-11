import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class PracticeAgencyPage extends StatefulWidget {
  @override
  _PracticeAgencyPageState createState() => _PracticeAgencyPageState();
}

class _PracticeAgencyPageState extends State<PracticeAgencyPage> {
  List names = new List();
  TextEditingController textEditingController = new TextEditingController();
  bool isLoadingOk = false;
  bool isShow = false;

  Map irmAllShortInfo = Map();

  @override
  void initState() {
    super.initState();
    getData();
  }

  /*getData() {
    firmViewModel.firmAllName(context).then((rep) {
      setState(() {
        names = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }*/

  getData() {
    firmViewModel.firmAllShortInfo(context).then((rep) {
      setState(() {
        names = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(
        color: Color(0xff333333), fontSize: 16, fontWeight: FontWeight.w600);
    return new Scaffold(
      appBar: new NavigationBar(title: '执业机构'),
      body: new MainInputBody(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.2),
                ),
              ),
              child: new FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: new Row(
                  children: <Widget>[
                    new Space(),
                    new Text('手动输入', style: labelStyle),
                    new Spacer(),
                    new CupertinoSwitch(
                        value: isShow,
                        onChanged: (v) {
                          setState(() {
                            isShow = v;
                          });
                        }),
                    new Space(),
                  ],
                ),
              ),
            ),
            new Visibility(
              visible: isShow,
              child: new Row(
                children: <Widget>[
                  new Space(),
                  new Text('律所名字', style: labelStyle),
                  new Space(),
                  new Expanded(
                    child: new TextField(
                      controller: textEditingController,
                    ),
                  ),
                  new FlatButton(
                    onPressed: () {
                      if (strNoEmpty(textEditingController.text)) {
                        pop(textEditingController.text);
                      } else {
                        showToast(context, '请输入律所名');
                      }
                    },
                    child: new Text('确定'),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 15, left: 10),
              child: new Text('律所列表', style: labelStyle),
            ),
            new Expanded(
              child: new DataView(
                isLoadingOk: isLoadingOk,
                data: names,
                child: new ListView(
                  children: names.map((item) {
                    return new Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: new ListTile(
                        title: new Text(item['firmName'] ?? '未知'),
                        onTap: () {
                          setState(() {
                            irmAllShortInfo = item;
                          });
                          pop(irmAllShortInfo);
                          print('选择了::::::$irmAllShortInfo');
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
