import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';

class MyLawSettingPage extends StatefulWidget {
  final String title;
  final String hintText;

  const MyLawSettingPage({
    Key key,
    this.title,
    this.hintText,
  }) : super(key: key);
  @override
  _MyLawSettingPageState createState() => _MyLawSettingPageState();
}

class _MyLawSettingPageState extends State<MyLawSettingPage> {
  TextEditingController textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.title}',
        rightDMActions: <Widget>[
          InkWell(
            child: new Container(
              padding: EdgeInsets.all(13.0),
              child: Image.asset(GoodSelectPic),
            ),
            onTap: () {
              if (!strNoEmpty(textController.text)) {
                showToast(context, '请输入内容');
                return;
              } else if (widget.title == '律所名称' &&
                  textController.text.length > 20) {
                showToast(context, '文字长度在10-20字符之间');
              } else if (widget.title != '律所名称' &&
                  textController.text.length < 20) {
                showToast(context, '文字长度在20-100字符之间');
                return;
              }
              changFun(context);
              pop('${textController.text}');
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 17, right: 16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 19),
            Container(
              color: Color(0xffF2F2F2),
              height: 302,
              child: TextField(
                controller: textController,
                maxLines: 80,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                ),
                cursorColor: Colors.black,
                cursorWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///判断修改什么
  changFun(context) {
    if (widget.title == '律所理念') {
      firmViewModel
          .changeFirmValue(
        context,
        content: textController.text,
      )
          .catchError((e) {
        print('e====>${e.toString()}');
        showToast(context, e.message);
      });
    } else if (widget.title == '律所简介') {
      firmViewModel
          .changeInfo(
        context,
        content: textController.text,
      )
          .catchError((e) {
        print('e====>${e.toString()}');
        showToast(context, e.message);
      });
    } else if (widget.title == '律所名称') {
      firmViewModel
          .changFirmName(
        context,
        firmName: textController.text,
      )
          .catchError((e) {
        print('e====>${e.toString()}');
        showToast(context, e.message);
      });
    }
  }
}
