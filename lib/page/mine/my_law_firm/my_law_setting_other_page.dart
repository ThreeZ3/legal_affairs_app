import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';

class MyLawSettingOtherPage extends StatefulWidget {
  final String title;
  final String hintText;
  final String id;
  final String lawId;

  const MyLawSettingOtherPage({
    Key key,
    this.title,
    this.hintText,
    this.id,
    this.lawId,
  }) : super(key: key);
  @override
  _MyLawSettingOtherPageState createState() => _MyLawSettingOtherPageState();
}

class _MyLawSettingOtherPageState extends State<MyLawSettingOtherPage> {
  TextEditingController textController = new TextEditingController();

  void initState() {
    super.initState();
    textController.text = widget.hintText;
  }

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
              padding: EdgeInsets.all(10.0),
              child: Image.asset(GoodSelectPic),
            ),
            onTap: () {
              if (!strNoEmpty(textController.text)) {
                showToast(context, '请输入内容');
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
            SizedBox(height: 13),
            IconTitleTileWidget(title: '${widget.title}', editIconUrlTwo: null),
            SizedBox(height: 7),
            Container(
              color: Color(0xffF2F2F2),
              height: 115,
              child: TextField(
                controller: textController,
                maxLength: 20,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入20字的内容',
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
    if (widget.title == '律所地址') {
      firmViewModel
          .firmChangeAddress(
        context,
        address: textController.text,
        city: "城市",
        district: "所属区",
        id: widget.lawId,
        lat: "1",
        lng: "21",
        province: "省份",
        town: "所属镇",
      )
          .then((rep) {
        showToast(context, '修改成功');
        Notice.send(JHActions.myFirmDetailRefresh(), '');
      }).catchError((e) {
        print('e====>${e.toString()}');
        showToast(context, e.message);
      });
    }
    if (widget.title == '律所网址') {
      if (widget.id == null) {
        addFirmSettingByType(4);
      } else {
        changeAllFirmSetting();
      }
    }
    if (widget.title == '律所公众号') {
      if (widget.id == null) {
        addFirmSettingByType(5);
      } else {
        changeAllFirmSetting();
      }
    }
    if (widget.title == '律师微博') {
      if (widget.id == null) {
        lawyerContacts(7);
      } else {
        lawyerContactsChange(7);
      }
    }
    if (widget.title == '律师公众号') {
      if (widget.id == null) {
        lawyerContacts(5);
      } else {
        lawyerContactsChange(5);
      }
    }
  }

  ///律所新增属性
  addFirmSettingByType(type) {
    firmViewModel
        .addFirmSetting(
      context,
      lawId: widget.lawId,
      title: '民商',
      type: type,
      value: textController.text,
    )
        .then((rep) {
      showToast(context, '修改成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  ///律所修改属性
  changeAllFirmSetting() {
    firmViewModel
        .changeFirmSetting(
      context,
      id: widget.id,
      title: widget.title,
      value: textController.text,
    )
        .then((rep) {
      showToast(context, '修改成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      setState(() => {});
      showToast(context, e.message);
    });
  }

  ///添加律师详情资料->微信，电话，邮箱，公众号
  void lawyerContacts(type) {
    LawyerInFoViewModel()
        .lawyerContacts(context,
            title: '民商', value: textController.text, type: type)
        .then((rep) {
      showToast(context, '修改成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  ///修改律师详情资料->微信，电话，邮箱，公众号
  void lawyerContactsChange(type) {
    LawyerInFoViewModel()
        .lawyerContactsChange(context,
            id: widget.id, title: '民商', value: textController.text, type: type)
        .then((rep) {
      showToast(context, '修改成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }
}
