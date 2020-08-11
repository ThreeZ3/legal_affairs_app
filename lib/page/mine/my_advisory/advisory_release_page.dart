import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/business/consult_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';
import 'package:jh_legal_affairs/widget/mine/price_field.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class AdvisoryReleasePage extends StatefulWidget {
  @override
  _AdvisoryReleasePageState createState() => _AdvisoryReleasePageState();
}

class _AdvisoryReleasePageState extends State<AdvisoryReleasePage> {
  List tools = [
    'assets/images/lawyer/align_left.png',
    'assets/images/lawyer/center.png',
    'assets/images/lawyer/align_right.png',
    'assets/images/lawyer/font.png',
    'assets/images/lawyer/picture.png',
  ];
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> category = new List();

//  TextEditingController _controller = new TextEditingController();

  int currentTime = 0;
  List timeList = [
    {"time": "24小时", "isTime": false, 'value': 1},
    {"time": "2天", "isTime": false, 'value': 2},
    {"time": "3天", "isTime": false, 'value': 3},
    {"time": "一周", "isTime": false, 'value': 7},
    {"time": "两周", "isTime": false, 'value': 14},
    {"time": "一个月", "isTime": false, 'value': 30},
  ];

  TextEditingController _priceC = TextEditingController();
  TextEditingController _optimalC = TextEditingController();
  TextEditingController _approximateC = TextEditingController();

  TextEditingController _titleController = TextEditingController();

  TextEditingController _claimC = TextEditingController();

  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);
  final ZefyrController _questionC =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  double _totalPrice = 0.0;

  String categoryId;
  List<String> categoryName = List();
  Map type = Map();

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
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

  @override
  Widget build(BuildContext context) {
    double _maxWidth = MediaQuery.of(context).size.width - (16 * 2 + 8 * 3);
    double _width = _maxWidth / 4;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '发布咨询',
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
      body: MainInputBody(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(11),
          child: ListView(
            children: <Widget>[
              Text(
                '标题',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                  controller: _titleController != null
                      ? _titleController
                      : TextEditingController(),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(30),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "请输入此次标题咨询的问题(限制30字)",
                    hintStyle:
                        TextStyle(color: Color(0xff999999), fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Text(
                "问题",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 11),
              new SizedBox(
                height: 270,
                child: EditRichView(
                  contentC: _questionC,
                  hintText: '请编辑详细的问题内容',
                ),
              ),
              SizedBox(height: 13),
              Text(
                "要求",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Space(),
              Container(
                height: 210,
                child: TextField(
                  maxLines: 15,
                  controller: _claimC,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(100),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    hintText: '请输入要求',
                    hintStyle:
                        TextStyle(color: Color(0xff666666), fontSize: 14.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 23),
              Row(
                children: <Widget>[
                  Text(
                    "报价",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  new Text(
                    '总价格',
                    style: TextStyle(color: Color(0xff666666), fontSize: 14.0),
                  ),
                  new Space(),
                  Text(
                    "￥$_totalPrice",
                    style: TextStyle(
                      color: Color(0xffFF3333),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              new PriceField(
                title: '首个答案',
                hintText: "输入价格",
                controller: _priceC,
                onChanged: onChangeHandle,
              ),
              new PriceField(
                title: '最佳答案',
                hintText: "输入价格",
                controller: _optimalC,
                onChanged: onChangeHandle,
              ),
              new PriceField(
                title: '近似答案',
                hintText: "输入价格",
                controller: _approximateC,
                onChanged: onChangeHandle,
              ),
              SizedBox(height: 26),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "业务类别",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: '新增类型',
                                    hintText: '请输入新增类别名称',
                                    enterTxt: '提交',
                                    callback: (res) => legalFieldAdd(res),
                                  );
                                });
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                            width: 21,
                            height: 21,
                          ),
                        )
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
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "时限",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        new Expanded(
                          child: new Text(
                            '当前选择的是:${limitToMonth(currentTime)}',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        new Space(),
                        GestureDetector(
                          onTap: () {
                            selectTimeDialog(context).then((v) {
                              if (v != null) {
                                setState(() {
                                  currentTime = int.parse(v.toString());
                                });
                              }
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                            width: 21,
                            height: 21,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: timeList.map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (item["isTime"] == false) {
                                currentTime = item["value"];
                                item["isTime"] = true;
                              } else {
                                return;
                              }
                              timeList.forEach((inItem) {
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
              SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }

  onChangeHandle(v) {
    double _firstAsk = double.parse(_priceC.text);
    double optimumAsk = double.parse(_optimalC.text);
    double _approximate = double.parse(_approximateC.text);
    setState(() {
      _totalPrice = _firstAsk + optimumAsk + _approximate;
    });
  }

  release() {
    consultViewModel
        .consultAdd(
      context,
      title: _titleController.text,
      categoryId: categoryId,
      content: jsonEncode(List.from(_questionC.document.toJson())),
      synopsis: _questionC.document.toPlainText(),
//      content: _controller.text,
      limit: currentTime,
      require: _claimC.text,
      totalAsk: '$_totalPrice',
      firstAsk: _priceC.text,
      optimumAsk: _optimalC.text,
      similarAsk: _approximateC.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  legalFieldAdd(String name) {
    systemViewModel
        .legalField(
      context,
      name: name,
    )
        .then((rep) {
      showToast(context, rep.data.toString());
    }).catchError((e) {
      showToast(context, e.message);
    });
  }
}

Future selectTimeDialog(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SelectTimeDialog();
    },
  );
}

class SelectTimeDialog extends StatefulWidget {
  @override
  _SelectTimeDialogState createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<SelectTimeDialog> {
  int select = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Text(
                  '取消',
                  style: TextStyle(color: Color(0xff181111), fontSize: 14),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                '选择时限',
                style: TextStyle(
                    color: Color(0xff181111),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              CupertinoButton(
                child: Text(
                  '确定',
                  style: TextStyle(color: Color(0xff181111), fontSize: 14),
                ),
                onPressed: () {
                  pop(select);
                },
              )
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: CupertinoPicker(
            itemExtent: 30.0,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (i) {
              print('change:$i');
              setState(() {
                select = i + 1;
              });
            },
            children: List.generate(
              10,
              (index) {
                return Container(
                  height: 30.0,
                  alignment: Alignment.center,
                  child: Text('${index + 1} 天'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
