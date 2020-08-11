import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/source/case_source_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_publish_task_page.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

//发布案源

class SourcecasePublish extends StatefulWidget {
  @override
  _SourcecasePublishState createState() => _SourcecasePublishState();
}

class _SourcecasePublishState extends State<SourcecasePublish> {
  List<CategoryModel> category = new List();
  CategoryModel currentCategory = new CategoryModel();

  /*String categoryId = '';*/
  int limit = 0;

  String categoryId;
  List<String> categoryName = List();
  Map type = Map();

  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);
  final ZefyrController _questionC =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  List businessTimeList = [
    {
      "time": "一个月",
      "isTime": false,
      'value': 1 * 30,
    },
    {
      "time": "1~2个月",
      "isTime": false,
      'value': 2 * 30,
    },
    {
      "time": "半年",
      "isTime": false,
      'value': 6 * 30,
    },
    {
      "time": "一年",
      "isTime": false,
      'value': 12 * 30,
    },
  ];

  TextEditingController _titleC;
  TextEditingController _valueC;
  TextEditingController _priceC;

  bool isInputA = true;
  bool isInputB = true;

  @override
  void initState() {
    super.initState();
    getCategory();
    _titleC = TextEditingController();
    _valueC = TextEditingController();
    _priceC = TextEditingController();
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _maxWidth = MediaQuery.of(context).size.width - (16 * 2 + 8 * 3);
    double _width = _maxWidth / 4;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: "发布案源",
        rightDMActions: <Widget>[
          new GestureDetector(
            onTap: () => release(),
            child: Container(
              padding: EdgeInsets.all(13.0),
              child: Image.asset('assets/images/mine/share_icon@3x.png'),
            ),
          )
        ],
      ),
      body: new MainInputBody(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Text(
              "案件标题",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: ThemeColors.color333.withOpacity(0.1),
                  ),
                ),
              ),
              child: TextField(
                controller: _titleC,
                onChanged: (v) {
                  print(_titleC.text.length);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: "请填写案件标题(30个字以内)",
                  hintStyle: TextStyle(color: Color(0xff999999), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "案件原由",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Container(
              height: 210,
              child: EditRichView(
                hintText: '请输入案件原由',
                contentC: _questionC,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  "案件标值",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "￥",
                  style: TextStyle(color: isInputB ? Colors.grey : Colors.red),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    onChanged: (txt) {
                      if (!strNoEmpty(txt)) {
                        setState(() {
                          isInputB = true;
                        });
                      } else {
                        setState(() {
                          isInputB = false;
                        });
                      }
                    },
                    textAlign: TextAlign.end,
                    controller: _priceC,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      WhitelistingTextInputFormatter(
                          RegExp(r'^\d*\.{0,2}\d{0,2}')),
                    ],
                    style: TextStyle(color: ThemeColors.color999, fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.00',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "业务类型",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  children: category.map((item) {
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
            SizedBox(height: 16),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "业务时限",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      new Expanded(
                        child: new Text(
                          '当前选择的是:${limitToMonth(limit)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      new Space(),
                      new InkWell(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                          width: 20,
                          height: 20,
                        ),
                        onTap: () => selectTimeDialog(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 20,
                    children: businessTimeList.map((item) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (item["isTime"] == false) {
                              item["isTime"] = true;
                              limit = item['value'];
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
            Row(
              children: <Widget>[
                Text(
                  "报价",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "￥",
                  style: TextStyle(color: isInputA ? Colors.grey : Colors.red),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    onChanged: (txt) {
                      if (!strNoEmpty(txt)) {
                        setState(() {
                          isInputA = true;
                        });
                      } else {
                        setState(() {
                          isInputA = false;
                        });
                      }
                    },
                    textAlign: TextAlign.end,
                    controller: _valueC,
                    style: TextStyle(color: ThemeColors.color999, fontSize: 14),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(11),
                      WhitelistingTextInputFormatter(
                          RegExp(r'^\d*\.{0,2}\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.00',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void selectTimeDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectTimeDialog();
      },
    ).then((v) {
      if (limit == null) return;
      setState(() {
        limit = v;
      });
    });
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
      category.forEach((inItem) {
        CategoryModel inModel = inItem;
        if (inModel.name != model.name) {
          inModel.isType = false;
        }
      });
    });
  }

  release() {
    caseSourceViewModel
        .caseSourceRelease(
      context,
      category: categoryId,
      title: _titleC.text,
      content: jsonEncode(List.from(_questionC.document.toJson())),
      fee: _valueC.text,
      limited: limit,
      value: _priceC.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }
}
