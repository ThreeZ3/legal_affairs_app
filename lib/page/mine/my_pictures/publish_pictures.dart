import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/video_card.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:video_player/video_player.dart';
import 'package:zefyr/zefyr.dart';

class PublishPictures extends StatefulWidget {
  @override
  _PublishPicturesState createState() => _PublishPicturesState();
}

class _PublishPicturesState extends State<PublishPictures> {
  List list = [
    "assets/images/law_firm/left_icon.png",
    "assets/images/law_firm/center_icon.png",
    "assets/images/law_firm/right_icon.png",
    "assets/images/lawyer/fill.png",
    "assets/images/lawyer/thickening.png",
    "assets/images/law_firm/picture.png"
  ];

  //标题，类型，内容
  bool isHead = true;
  String position;
  List positionList = ['头部视频', '尾部视频'];
  TextEditingController title = new TextEditingController();

  //发布图文
  void _postPictures() {
    if (isShow && !strNoEmpty(_videoPath1)) {
      showToast(context, '请上传视频');
      return;
    }
    sketchViewModel
        .sketchRelease(
      context,
      category: categoryId,
      title: title.text,
      detail: jsonEncode(List.from(_questionC.document.toJson())),
      describe: _questionC.document.toPlainText(),
      headUrl: isHead ? _videoPath1 : null,
      footUrl: !isHead ? _videoPath1 : null,
      pictures: stringBuffer.toString(),
    )
        .then((rep) {
      Notice.send(JHActions.myPicturesRefresh(), '');
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  //类型
  List<CategoryModel> category = new List();
  CategoryModel currentCategory = new CategoryModel();

  void getFieldList() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  //添加类型
  String name;

  void _postLegalField() {
    systemViewModel.legalField(context, name: name).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getFieldList();
  }

  String categoryId;
  StringBuffer stringBuffer = new StringBuffer();
  List<String> categoryName = List();
  Map type = Map();
  File _video1;
  VideoPlayerController _videoPlayerController1;
  String _videoPath1;
  bool isShow = false;

  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);
  final ZefyrController _questionC =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  ///获取图库视频
  _getVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    setState(() {
      _video1 = video;
      _videoPlayerController1 = VideoPlayerController.file(_video1)
        ..initialize().then((_) {
          setState(() {});
        });
    });
    systemViewModel
        .uploadFile(
      context,
      file: video,
      second: 180,
      isVideo: true,
    )
        .then((rep) {
      setState(() {
        _videoPath1 = rep.data["data"];
      });
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
        title: '发布图文',
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () => _postPictures(),
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
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "图文标题",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
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
                      controller: title,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        hintText: "请编写图文标题(限制30字)",
                        hintStyle:
                            TextStyle(color: Color(0xff999999), fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Space(height: 16),
                  Text(
                    "图文内容",
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Space(height: 12),
                  Container(
                    height: 210,
                    child: EditRichView(
                      contentC: _questionC,
                      hintText: '请输入图文内容',
                      callImg: (img) {
                        stringBuffer.write(img + ';');
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Space(height: 16),
                  new FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '发布视频',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        new CupertinoSwitch(
                            value: isShow,
                            onChanged: (v) {
                              setState(() {
                                isShow = v;
                              });
                            }),
                      ],
                    ),
                  ),
                  new Visibility(
                    visible: isShow,
                    child: new FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      onPressed: () {
                        position = '头部视频';
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  height: 25,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.2648,
                                  width: double.infinity,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.014),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  '取消',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff666666)),
                                                )),
                                            Spacer(),
                                            Text(
                                              '选择视频位置',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff333333),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                print(position);
                                                if (position == null ||
                                                    position == '头部视频') {
                                                  isHead = true;
                                                } else if (position == '尾部视频') {
                                                  isHead = false;
                                                }
                                                pop();
                                                setState(() {});
                                              },
                                              child: Text(
                                                '确定',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffE1B96B)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Space(height: MediaQuery.of(context).size.height*0.051),
                                      Expanded(
                                        //height: MediaQuery.of(context).size.height*0.170,
                                        child: CupertinoPicker(
                                          useMagnifier: true,
                                          //diameterRatio:1,
                                          squeeze: 1,
                                          backgroundColor: Colors.white,
                                          //选择器背景色
                                          itemExtent: 35,
                                          //item的高度
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              position = positionList[index]
                                                  .toString();
                                            });
                                          },
                                          children: <Widget>[
                                            //所有的选择项
                                            Text(positionList[0]),
                                            Text(positionList[1]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            "视频位置",
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          new Text(
                            isHead ? '头部' : '尾部',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Visibility(
                    visible: isShow,
                    child: Space(height: 16),
                  ),
                  new Visibility(
                    visible: isShow,
                    child: VideoCard(
                      _video1,
                      videoPlayerController: _videoPlayerController1,
                      onTap: () => _getVideo(),
                      clean: () {
                        setState(() => _video1 = null);
                      },
                    ),
                  ),
                  Space(height: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        "图文类型",
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
                          confirmAlert(
                            context,
                            (bool isOk) {},
                            input: true,
                            tips: '添加类别',
                            length: 6,
                            hintTextSize: 12.0,
                          ).then((result) {
                            print('新增的类别::::::::::$result');
                          }).catchError((e) {
                            showToast(context, e.message);
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
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
