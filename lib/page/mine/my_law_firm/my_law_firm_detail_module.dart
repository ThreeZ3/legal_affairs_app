import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_category_page.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_setting_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';

///我的律师事务所信息内容模块
class MyLawFirmDetailModule extends StatefulWidget {
  final MyFirmModel data;

  const MyLawFirmDetailModule({Key key, this.data}) : super(key: key);

  @override
  _MyLawFirmDetailModuleState createState() => _MyLawFirmDetailModuleState();
}

class _MyLawFirmDetailModuleState extends State<MyLawFirmDetailModule> {
  String firmName;
  List newLabelList = [];
  String concept; //理念
  String firmInfo; //简介
  String textOfficialLetter = "";

  _changFirmName(context) {
    routePush(MyLawSettingPage(
      title: '律所名称',
      hintText: '律所名称',
    )).then((value) {
      setState(() {
        firmName = value;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  _changeFirmValue() {
    routePush(MyLawSettingPage(
      title: '律所理念',
      hintText: '律所理念',
    )).then((value) {
      setState(() {
        concept = value;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  _changFirmInfo() {
    routePush(MyLawSettingPage(
      title: '律所简介',
      hintText: '律所简介',
    )).then((value) {
      setState(() {
        firmInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFE),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(top: 16, bottom: 12, left: 12, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleWidget(context), //律所名、业务类别
          Space(),
          Container(
            child: editInformation(
              title: '律所理念',
              onTapEdit: () => _changeFirmValue(),
              content: concept ?? widget.data.firmValue,
            ),
          ),
          Space(),
          Container(
            child: editInformation(
              title: '律所简介',
              onTapEdit: () => _changFirmInfo(),
              content: firmInfo ?? widget.data.firmInfo,
            ),
          ),

          SizedBox(height: 12),
        ],
      ),
    );
  }

  ///我的律师理念与简介
  Widget editInformation({String title, Function onTapEdit, String content}) {
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconTitleTileWidget(
            title: title,
            onTapEditTwo: onTapEdit,
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new Text(
              '$content',
              style: TextStyle(color: ThemeColors.color999),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWidget(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconTitleTileWidget(
            title: '${firmName ?? widget.data.firmName}',
            fontSize: 16,
            onTapEditTwo: () => _changFirmName(context),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () => routePush(
                LawFirmCategoryPage(categoryList: widget.data.legalField)),
            child: Column(
              children: <Widget>[
                IconTitleTileWidget(title: '业务类别'),
                SizedBox(height: 9),
                widget.data.legalField == null
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(widget.data.legalField.length,
                              (index) {
                            return LabelBox(
                              text: widget.data.legalField[index]?.name ?? "未知",
                            );
                          }),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
