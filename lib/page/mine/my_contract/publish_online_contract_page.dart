//合同发布页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/contract/contract_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';

class ContractIssuePage extends StatefulWidget {
  @override
  _ContractIssuePageState createState() => _ContractIssuePageState();
}

class _ContractIssuePageState extends State<ContractIssuePage> {
  String _title;

//  String _category;
  int _videoLimitMinute;

  int _voiceLimitMinute;

  int _textLimitMinute;
  String _image =
      "https://lanhu.oss-cn-beijing.aliyuncs.com/xd3c0aedc1-e8e5-4f46-8e54-edc0164c2e72";
  int _price;
  String _review;
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> category = new List();
  TextEditingController _tC = new TextEditingController();

//  List onlineVoiceTime = [
//    {"voiceTime": "20", "isVoiceTime": false},
//    {"voiceTime": "40", "isVoiceTime": false},
//    {"voiceTime": "60", "isVoiceTime": false},
//    {"voiceTime": "80", "isVoiceTime": false},
//    {"voiceTime": "100", "isVoiceTime": false},
//    {"voiceTime": "120", "isVoiceTime": false},
//  ];

//  List onlineVideoTime = [
//    {"videoTime": "20", "isVideoTime": false},
//    {"videoTime": "40", "isVideoTime": false},
//    {"videoTime": "60", "isVideoTime": false},
//    {"videoTime": "80", "isVideoTime": false},
//    {"videoTime": "100", "isVideoTime": false},
//    {"videoTime": "120", "isVideoTime": false},
//  ];
//  List onlineTextTime = [
//    {"textTime": "20", "isTextTime": false},
//    {"textTime": "40", "isTextTime": false},
//    {"textTime": "60", "isTextTime": false},
//    {"textTime": "80", "isTextTime": false},
//    {"textTime": "100", "isTextTime": false},
//    {"textTime": "120", "isTextTime": false}
//  ];
  List contractPctureStyle = [
    {
      "contractStyle":
          "https://lanhu.oss-cn-beijing.aliyuncs.com/xd3c0aedc1-e8e5-4f46-8e54-edc0164c2e72",
      "isContractStyle": false
    },
    {
      "contractStyle":
          "https://lanhu.oss-cn-beijing.aliyuncs.com/xd21d92faa-202e-4713-8dfd-08af709f5590",
      "isContractStyle": false
    },
    {
      "contractStyle":
          "https://lanhu.oss-cn-beijing.aliyuncs.com/xd5f4abdbd-a51c-4938-942c-0deec9d06255",
      "isContractStyle": false
    },
    {
      "contractStyle":
          "https://lanhu.oss-cn-beijing.aliyuncs.com/xd43768a55-d90d-4996-89f7-4a78d6777663",
      "isContractStyle": false
    },
  ];

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

  postContractAdd() {
    contractViewModel
        .contractAdd(
      context,
      // category: _category,
      category: categoryId,
      contractReview: _review,
      title: _title,
      img: _image,
      price: int.parse(_tC.text),
      lawyerId: JHData.id(),
      videoLimit: _videoLimitMinute,
      voiceLimit: _voiceLimitMinute,
      textLimit: _textLimitMinute,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

//  List aa = [
//    [
//      "1小时",
//      "2小时",
//      "3小时",
//      "4小时",
//      "5小时",
//      "6小时",
//      "7小时",
//      "8小时",
//      "9小时",
//      "10小时",
//      "11小时",
//      "12小时",
//    ],
//    [
//      "10分钟",
//      "20分钟",
//      "30分钟",
//      "40分钟",
//      "50分钟",
//      "60分钟",
//    ]
//  ];
  String categoryId;
  List<String> categoryName = List();
  Map type = Map();

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
        title: '发布在线顾问合同',
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () {
              postContractAdd();
            },
            child: new Container(
              padding: EdgeInsets.all(13.0),
              child: Image.asset('assets/images/mine/share_icon@3x.png'),
            ),
          ),
        ],
      ),
      body: MainInputBody(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "合同名称",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.color333,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    child: TextField(
                      onChanged: (v) {
                        _title = v;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          hintText: "请填写合同名称(30字以内)",
                          hintStyle: TextStyle(
                              color: ThemeColors.color999, fontSize: 12),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[300]))),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "价格",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          "输入价格  ￥",
                          style: TextStyle(
                              color: ThemeColors.color999, fontSize: 12.0),
                        ),
                        Container(
                            width: _tC.text == ''
                                ? 30
                                : _tC.text.length * 10.toDouble(),
                            child: TextField(
                              controller: _tC,
                              textAlign: TextAlign.right,
                              onChanged: (v) {
                                _price = int.parse(v);
                                setState(() {});
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "0.00",
                                hintStyle: TextStyle(
                                    fontSize: 12, color: ThemeColors.color999),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        "类别类型",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "(请选择业务类别)",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xda020433e-6aca-46f6-b82d-2b28ce463487",
                          height: 16,
                          width: 16,
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
                  /* GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        crossAxisCount: 4,
                        childAspectRatio: 8 / 4),
                    children: category.map((item) {
                      CategoryModel model = item;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (model.isType == false) {
                              currentCategory = model;
                              model.isType = true;
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
                        },
                        child: Container(
                            margin:
                                EdgeInsets.only(bottom: 12, left: 2, right: 2),
                            alignment: Alignment.center,
                            child: Text(
                              model.name.toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: !model.isType
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                            color: !model.isType
                                ? Colors.grey[300]
                                : Color(0xffE1B96B)),
                      );
                    }).toList(),
                  ),*/
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[300]))),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "审查合同次数",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            onChanged: (v) {
                              _review = v;
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "请输入次数",
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 7.0,
              color: Color(0xfff0f0f0),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "在线视频咨询时长",
                          style: TextStyle(
                            color: ThemeColors.color333,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            onChanged: (v) {
                              _videoLimitMinute = int.parse(v);
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入时长(分钟)",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: ThemeColors.color999,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "在线语音咨询时长",
                          style: TextStyle(
                            color: ThemeColors.color333,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            onChanged: (v) {
                              _voiceLimitMinute = int.parse(v);
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入时长(分钟)",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: ThemeColors.color999,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "在线文字咨询时长",
                          style: TextStyle(
                            color: ThemeColors.color333,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            onChanged: (v) {
                              _textLimitMinute = int.parse(v);
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入时长(分钟)",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: ThemeColors.color999,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "选择图片",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    children: contractPctureStyle.map((item) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (item["isContractStyle"] == false) {
                                item["isContractStyle"] = true;
                                _image = item["contractStyle"];
                              } else {
                                return;
                              }
                              contractPctureStyle.forEach((inItem) {
                                if (inItem["contractStyle"] !=
                                    item["contractStyle"]) {
                                  inItem["isContractStyle"] = false;
                                }
                              });
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: item["contractStyle"],
                              ),
                              item["isContractStyle"] == true
                                  ? Container(
                                      alignment: Alignment.center,
                                      color: Color(0xff666666).withOpacity(0.5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd1b3322fc-2159-4d83-b8ee-bca20f15f921",
                                        width: 32,
                                        height: 23,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ));
                    }).toList(),
                  ),
                ],
              ),
            ),
//            Container(
//              color: Colors.white,
//              padding: EdgeInsets.all(16),
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Text(
//                        "在线视频咨询时长",
//                        style: TextStyle(fontSize: 16),
//                      ),
//                      SizedBox(width: 6),
//                      Spacer(),
//                      new InkWell(
//                        onTap: () {
//                          showToast(context, '敬请期待');
////                          JhPickerTool.showArrayPicker(context,
////                              data: aa, title: "在线视频咨询时长", normalIndex: [0, 1],
////                              clickCallBack: (var index, var str) {
////                                print(str[0]);
////                                print(str[1]);
////                              });
//                        },
//                        child: CachedNetworkImage(
//                          imageUrl:
//                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xda020433e-6aca-46f6-b82d-2b28ce463487",
//                          height: 16,
//                          width: 16,
//                        ),
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 12),
//                  Wrap(
//                    spacing: 8,
//                    runSpacing: 6,
//                    children: onlineVideoTime.map((item) {
//                      return GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            if (item["isVideoTime"] == false) {
//                              item["isVideoTime"] = true;
//                              String _videoLimitString = item["videoTime"];
//                              int _videoLimit = int.parse(_videoLimitString);
//                              _videoLimitMinute = _videoLimit * 60;
//                            } else {
//                              return;
//                            }
//                            onlineVideoTime.forEach((inItem) {
//                              if (inItem["videoTime"] != item["videoTime"]) {
//                                inItem["isVideoTime"] = false;
//                              }
//                            });
//                          });
//                        },
//                        child: Container(
//                          width: _width,
//                          height: 28,
//                          alignment: Alignment.center,
//                          child: Text(
//                            "${item["videoTime"]}分钟",
//                            style: TextStyle(
//                              fontSize: 12,
//                              color: item["isVideoTime"] == false
//                                  ? Colors.grey
//                                  : Colors.white,
//                            ),
//                          ),
//                          color: item["isVideoTime"] == false
//                              ? ThemeColors.colorf0
//                              : ThemeColors.colorOrange,
//                        ),
//                      );
//                    }).toList(),
//                  ),
//                  SizedBox(height: 16),
//                  Row(
//                    children: <Widget>[
//                      Text(
//                        "在线语音咨询时长",
//                        style: TextStyle(fontSize: 16),
//                      ),
//                      Spacer(),
//                      GestureDetector(
//                        onTap: () {
//                          showToast(context, '敬请期待');
////                          JhPickerTool.showArrayPicker(context,
////                              data: aa, title: "在线语音咨询时长", normalIndex: [0, 1],
////                              clickCallBack: (var index, var str) {
////                            print(str[0]);
////                            print(str[1]);
////                          });
//                        },
//                        child: CachedNetworkImage(
//                          imageUrl:
//                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xda020433e-6aca-46f6-b82d-2b28ce463487",
//                          height: 16,
//                          width: 16,
//                        ),
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 12),
//                  Wrap(
//                    spacing: 8,
//                    runSpacing: 6,
//                    children: onlineVoiceTime.map((item) {
//                      return GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            if (item["isVoiceTime"] == false) {
//                              item["isVoiceTime"] = true;
//                              String _voiceLimitString = item["voiceTime"];
//                              int _voiceLimit = int.parse(_voiceLimitString);
//                              _voiceLimitMinute = _voiceLimit * 60;
//                            } else {
//                              return;
//                            }
//                            onlineVoiceTime.forEach((inItem) {
//                              if (inItem["voiceTime"] != item["voiceTime"]) {
//                                inItem["isVoiceTime"] = false;
//                              }
//                            });
//                          });
//                        },
//                        child: Container(
//                          width: _width,
//                          height: 28,
//                          alignment: Alignment.center,
//                          child: Text(
//                            "${item["voiceTime"]}分钟",
//                            style: TextStyle(
//                              fontSize: 12,
//                              color: item["isVoiceTime"] == false
//                                  ? Colors.grey
//                                  : Colors.white,
//                            ),
//                          ),
//                          color: item["isVoiceTime"] == false
//                              ? ThemeColors.colorf0
//                              : ThemeColors.colorOrange,
//                        ),
//                      );
//                    }).toList(),
//                  ),
//                  SizedBox(height: 16),
//                  Row(
//                    children: <Widget>[
//                      Text(
//                        "在线文字咨询时长",
//                        style: TextStyle(fontSize: 16),
//                      ),
//                      Spacer(),
//                      new InkWell(
//                        onTap: () {
//                          showToast(context, '敬请期待');
////                          JhPickerTool.showArrayPicker(context,
////                              data: aa, title: "在线文字咨询时长", normalIndex: [0, 1],
////                              clickCallBack: (var index, var str) {
////                                print(str[0]);
////                                print(str[1]);
////                              });
//                        },
//                        child: CachedNetworkImage(
//                          imageUrl:
//                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xda020433e-6aca-46f6-b82d-2b28ce463487",
//                          height: 16,
//                          width: 16,
//                        ),
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 12),
//                  Wrap(
//                    spacing: 8,
//                    runSpacing: 6,
//                    children: onlineTextTime.map((item) {
//                      return GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            if (item["isTextTime"] == false) {
//                              item["isTextTime"] = true;
//                              String _textLimitString = item["textTime"];
//                              int _textLimit = int.parse(_textLimitString);
//                              _textLimitMinute = _textLimit * 60;
//                            } else {
//                              return;
//                            }
//                            onlineTextTime.forEach((inItem) {
//                              if (inItem["textTime"] != item["textTime"]) {
//                                inItem["isTextTime"] = false;
//                              }
//                            });
//                          });
//                        },
//                        child: Container(
//                          width: _width,
//                          height: 28,
//                          alignment: Alignment.center,
//                          child: Text(
//                            "${item["textTime"]}分钟",
//                            style: TextStyle(
//                                fontSize: 12,
//                                color: item["isTextTime"] == false
//                                    ? Colors.grey
//                                    : Colors.white),
//                          ),
//                          color: item["isTextTime"] == false
//                              ? ThemeColors.colorf0
//                              : ThemeColors.colorOrange,
//                        ),
//                      );
//                    }).toList(),
//                  ),
//                  SizedBox(height: 16),
//                  Container(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "选择图片",
//                      style: TextStyle(fontSize: 16),
//                    ),
//                  ),
//                  SizedBox(height: 12),
//                  GridView(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisSpacing: 10,
//                      crossAxisCount: 4,
//                      childAspectRatio: 1,
//                    ),
//                    children: contractPctureStyle.map((item) {
//                      return GestureDetector(
//                          onTap: () {
//                            setState(() {
//                              if (item["isContractStyle"] == false) {
//                                item["isContractStyle"] = true;
//                                _image = item["contractStyle"];
//                              } else {
//                                return;
//                              }
//                              contractPctureStyle.forEach((inItem) {
//                                if (inItem["contractStyle"] !=
//                                    item["contractStyle"]) {
//                                  inItem["isContractStyle"] = false;
//                                }
//                              });
//                            });
//                          },
//                          child: Stack(
//                            children: <Widget>[
//                              CachedNetworkImage(
//                                imageUrl: item["contractStyle"],
//                              ),
//                              item["isContractStyle"] == true
//                                  ? Container(
//                                      alignment: Alignment.center,
//                                      color: Color(0xff666666).withOpacity(0.5),
//                                      child: CachedNetworkImage(
//                                        imageUrl:
//                                            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd1b3322fc-2159-4d83-b8ee-bca20f15f921",
//                                        width: 32,
//                                        height: 23,
//                                      ),
//                                    )
//                                  : Container(),
//                            ],
//                          ));
//                    }).toList(),
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
