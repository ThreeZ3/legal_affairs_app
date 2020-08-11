import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/api/task/mission_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class LawyerPublicTask extends StatefulWidget {
  @override
  _LawyerPublicTaskState createState() => _LawyerPublicTaskState();
}

class _LawyerPublicTaskState extends State<LawyerPublicTask> {
  List tools = [
    'assets/images/lawyer/align_left.png',
    'assets/images/lawyer/center.png',
    'assets/images/lawyer/align_right.png',
    'assets/images/lawyer/picture.png',
    'assets/images/lawyer/camera.png',
    'assets/images/lawyer/font.png',
  ];
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> category = new List();

  int currentTime = 0;
  List timeList = [
    {"time": "24小时", "isTime": false, 'value': 1},
    {"time": "2天", "isTime": false, 'value': 2},
    {"time": "3天", "isTime": false, 'value': 3},
    {"time": "一周", "isTime": false, 'value': 7},
    {"time": "两周", "isTime": false, 'value': 14},
  ];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceC = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController _rController = TextEditingController();

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
        title: '发布任务',
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
        child: Container(
          padding: EdgeInsets.all(11),
          child: ListView(
            children: <Widget>[
              Text(
                '任务标题',
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "请填写任务标题",
                    hintStyle:
                        TextStyle(color: Color(0xff999999), fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Text(
                "任务简介",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 11),
              Container(
                height: 210,
                child: TextField(
                  maxLines: 15,
                  controller: _controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(100),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    hintText: '请输入任务简介',
                    hintStyle:
                        TextStyle(color: Color(0xff666666), fontSize: 14.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 13),
              Text(
                "要求",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 11),
              Container(
                height: 210,
                child: TextField(
                  maxLines: 15,
                  controller: _rController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    hintText: '请输入任务要求',
                    hintStyle:
                        TextStyle(color: Color(0xff666666), fontSize: 14.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 13),
              Row(
                children: <Widget>[
                  Text(
                    "报价",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    "￥",
                    style: TextStyle(
                        color: Color(0xffBEB5B5),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                      width: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _priceC,
                        inputFormatters: priceFormatter,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0.00",
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ))
                ],
              ),
              SizedBox(height: 16),
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
                                    callback: (res) {
                                      showToast(context, '类别已提交等待审核');
                                    },
                                  );
                                });
                          },
                          child: CachedNetworkImage(
                              imageUrl:
                                  "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                              width: 21,
                              height: 21),
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
                        Spacer(),
                        GestureDetector(
                          onTap: () => selectTimeDialog(context),
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
                      runSpacing: 15,
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
//              Row(
//                children: <Widget>[
//                  Text(
//                    "律师费用",
//                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                  ),
//                  Spacer(),
//                  Text(
//                    "￥",
//                    style: TextStyle(
//                        color: Color(0xffBEB5B5),
//                        fontSize: 16,
//                        fontWeight: FontWeight.w600),
//                  ),
//                  Container(
//                      width: 50,
//                      child: TextField(
//                        inputFormatters: priceFormatter,
//                        keyboardType: TextInputType.number,
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: "0.00",
//                          hintStyle: TextStyle(
//                            fontSize: 16,
//                            fontWeight: FontWeight.w600,
//                          ),
//                        ),
//                      ))
//                ],
//              ),
            ],
          ),
        ),
      ),
    );
  }

  release() {
    missionViewModel
        .missionRelease(
      context,
      title: _titleController.text,
      ask: _priceC.text,
      categoryId: categoryId,
      content: _controller.text,
      limit: currentTime,
      require: _rController.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  void selectTimeDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectTimeDialog();
      },
    ).then((v) {
      if (v != null) {
        showToast(context, '您选择时限为$v天');
        timeList.insert(5, {"time": "$v天", "isTime": true, 'value': v});
        if (timeList.length >= 7) {
          timeList.removeLast();
        }
        setState(() {});
        currentTime = v;
      }
    });
  }
}

class SelectTimeDialog extends StatefulWidget {
  @override
  _SelectTimeDialogState createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<SelectTimeDialog> {
  int dayOptional = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
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
                    Navigator.of(context).pop(dayOptional);
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 30.0,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (i) {
                dayOptional = i + 1;
                print('dayOptional:$dayOptional');
              },
              children: List.generate(
                9,
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
      ),
    );
  }
}

class TaskContentEdit extends StatefulWidget {
  final ZefyrController contentC;

  const TaskContentEdit({Key key, this.contentC}) : super(key: key);

  @override
  _TaskContentEditState createState() => _TaskContentEditState();
}

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

final doc = r'[{"insert":"请输入任务简介\n"}]';

class _TaskContentEditState extends State<TaskContentEdit> {
  final FocusNode _focusNode = FocusNode();
  StreamSubscription<NotusChange> _sub;
  bool _editing = true;

  @override
  void initState() {
    super.initState();
    _sub = widget.contentC.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: ThemeColors.colorDivider,
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: winKeyHeight(context) == 0
          ? winHeight(context) - 100
          : (winHeight(context) - 90) - winKeyHeight(context),
      child: ZefyrScaffold(
        child: ZefyrEditor(
          controller: widget.contentC,
          focusNode: _focusNode,
          mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
          imageDelegate: CustomImageDelegate(),
          keyboardAppearance: Brightness.light,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
