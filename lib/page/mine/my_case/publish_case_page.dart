import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

/// 我的案例-发布案例（待优化）

class PublishCasePage extends StatefulWidget {
  @override
  _PublishCasePageState createState() => _PublishCasePageState();
}

class _PublishCasePageState extends State<PublishCasePage> {
  TextEditingController _titleC = new TextEditingController();
  TextEditingController _priceC = new TextEditingController();
  TextEditingController _courtC = new TextEditingController();
  TextEditingController _judgeC = new TextEditingController();
  TextEditingController _urlC = new TextEditingController();
  TextEditingController _numC = new TextEditingController();
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> _categoryList = new List();
  int _trialStage;

  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);
  final ZefyrController _questionC =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  List<String> categoryName = List();
  String categoryId;
  Map type = Map();

//  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    double _maxWidth = MediaQuery.of(context).size.width - (16 * 2 + 8 * 3);
    double _width = _maxWidth / 4;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        rightDMActions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _isPublish,
            child: new Image.asset(
              'assets/images/mine/share_icon@3x.png',
              width: 22.0,
            ),
          ),
          new SizedBox(
            width: 15,
          ),
        ],
        title: '发布案例',
      ),
      body: MainInputBody(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              new Text(
                "案例标题",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              new Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.3, color: ThemeColors.color999))),
                child: TextField(
                  controller: _titleC,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: "请填写案例标题",
                      hintStyle:
                          TextStyle(color: Color(0xff999999), fontSize: 14),
                      border: InputBorder.none),
                ),
              ),
              new SizedBox(height: 16),
              new Text(
                "案例内容",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Space(),
              Container(
                height: 210,
                child: EditRichView(
                  contentC: _questionC,
                  hintText: '请输入案例内容',
                ), //
              ),
              new Space(),
              new Row(
                children: <Widget>[
                  Text(
                    "案例标值",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),

//                  Text(
//                    "￥",
//                    style: TextStyle(color: ThemeColors.colorRed),
//                  ),
                  Expanded(
                    child: Container(
                        child: TextField(
                      textAlign: TextAlign.end,
                      controller: _priceC,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0.00",
                          hintStyle: TextStyle(color: ThemeColors.colorRed)),
                    )),
                  )
                ],
              ),
              CaseInformationInput(
                title: '经办法院',
                textC: _courtC,
              ),
              CaseInformationInput(
                title: '审判长',
                textC: _judgeC,
              ),
              CaseInformationInput(
                title: '案例网址',
                textC: _urlC,
              ),
              CaseInformationInput(
                title: '案例编号',
                textC: _numC,
              ),
              SizedBox(height: 16),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "审判阶段",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: businessTimeList.map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (item["isTime"] == false) {
                                item["isTime"] = true;
                                _trialStage = item['trialStage'];
                              } else {
                                return;
                              }
                              businessTimeList.forEach((inItem) {
                                if (inItem["time"] != item["time"]) {
                                  inItem["isTime"] = false;
                                }
                              });
                            });
                          },
                          child: Container(
                            width: _width,
                            height: 28,
                            alignment: Alignment.center,
                            child: Text(
                              item["time"],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: item["isTime"] == false
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                            color: item["isTime"] == false
                                ? Color(0xffF0F0F0)
                                : ThemeColors.colorOrange,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "业务类型",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      new InkWell(
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                            width: 20,
                            height: 20),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: '新增类型',
                                  hintText: '请输入新增类别名称',
                                );
                              });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 20,
                    children: _categoryList.map((item) {
                      CategoryModel model = item;
                      return ButtonCheckBox(
                        width: _width,
                        onTap: () => _select(model),
                        title: model.name.toString(),
                        state: model.isType ? true : false,
                      );
                    }).toList(),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  _select(model) {
    setState(() {
      if (model.isType == false) {
        currentCategory = model;
        model.isType = true;
        categoryId = model.id;
        print(categoryId);
      } else {
        return;
      }
      _categoryList.forEach((inItem) {
        CategoryModel inModel = inItem;
        if (inModel.name != model.name) {
          inModel.isType = false;
        }
      });
    });
    /* setState(() {
      if (!model.isType) {
        currentCategory = model;
        model.isType = true;
        print('ID:${model.id},类别:${model.name}');
      } else {
        model.isType = false;
        print('当前取消的类别:${model.name}');
      }
      if (model.isType == true) {
        categoryId.add(model.id);
        categoryName.add(model.name);
      } else {
        categoryId.remove(model.id);
        categoryName.remove(model.name);
      }
      type.addAll({'id': categoryId, 'name': categoryName});
      print(type);
    });*/
  }

  /// 案例新增
  void caseAdd() {
//    print('$_controller');
    caseViewModel
        .caseAdd(
      context,
      title: _titleC.text,
      detail: jsonEncode(List.from(_questionC.document.toJson())),
      synopsis: _questionC.document.toPlainText(),
      value: _priceC.text,
      court: _courtC.text,
      judge: _judgeC.text,
      trialStage: _trialStage,
      category: categoryId,
      caseUrl: _urlC.text,
      caseNo: _numC.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  ///请求业务类别
  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => _categoryList = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  //是否发布
  _isPublish() {
    themeAlert(context, warmStr: '确认发布该案例？', okFunction: () => caseAdd());
  }

  List businessTimeList = [
    {
      "time": "未审判",
      "isTime": false,
      'trialStage': 0,
    },
//    {
//      "time": "审判中",
//      "isTime": false,
//      'trialStage': 1,
//    },
    {
      "time": "已结案",
      "isTime": false,
      'trialStage': 2,
    },
  ];
}

class CaseInformationInput extends StatefulWidget {
  final String title;
  final TextEditingController textC;

  CaseInformationInput({
    Key key,
    this.title,
    this.textC,
  }) : super(key: key);

  @override
  _CaseInformationInputState createState() => _CaseInformationInputState();
}

class _CaseInformationInputState extends State<CaseInformationInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 70,
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        new Expanded(
          child: Container(
            child: TextField(
              textAlign: TextAlign.end,
              keyboardType:
                  widget.title != '案例编号' ? null : TextInputType.number,
              controller: widget.textC,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff999999),
              ),
              inputFormatters: widget.title == "案例编号"
                  ? [WhitelistingTextInputFormatter(RegExp("[0-9.]"))]
                  : null,
              onSubmitted: (text) {
                if (widget.title == "案例网址" && !isUrl(text)) {
                  showToast(context, "输入的网址不对");
                  widget.textC.text = "";
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.title == '案例网址' ? '选填' : '请输入',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff999999),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: ThemeColors.color333.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
