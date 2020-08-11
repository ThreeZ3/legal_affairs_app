//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:jh_legal_affairs/widget/law_firm/editor.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-07
///
/// 律所详情(律师)-详细资料-律所照片
///

//class LawFirmPicturePage extends StatefulWidget {
//  @override
//  _LawFirmPicturePageState createState() => _LawFirmPicturePageState();
//}
//
//class _LawFirmPicturePageState extends State<LawFirmPicturePage> {
//  TextEditingController textOfficialLetter = TextEditingController();
//  File localImages = new File('');
//
//  @override
//  Widget build(BuildContext context) {
//    return EditorPage(
//      text: '律所照片',
//      hintText: '文字内容',
//      textController: textOfficialLetter,
//      picOnTap: () => _openGallery(),
//      child: Container(
//        width: MediaQuery.of(context).size.width,
//        child: Wrap(
//          spacing: 4.0,
//          runSpacing: 4.0,
//          alignment: WrapAlignment.start,
//          children: [
//            ImagePicked(
//              images: localImages,
////          index: index,
//              valueChanged: (index) {
////            setState(() {
////              localImages.removeAt(index);
////            });
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _openGallery() async {
//    File image = await ImagePicker.pickVideo(source: ImageSource.gallery);
//
//    setState(() {
//      localImages = image;
//    });
//  }
//}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';

class LawFirmPicturePage extends StatefulWidget {
  final String title;
  final String id;
  final int type;
  final String from;

  const LawFirmPicturePage({Key key, this.id, this.type, this.title, this.from})
      : super(key: key);

  @override
  _LawFirmPicturePageState createState() => _LawFirmPicturePageState();
}

class _LawFirmPicturePageState extends State<LawFirmPicturePage> {
  final ZefyrController _controller =
      ZefyrController(NotusDocument.fromDelta(getDelta()));
  final TextEditingController _editingController = new TextEditingController();

  String content, img;
  var image;

  //获取图片地址
  _imageUrl() {
    systemViewModel.uploadFile(context, file: image).then((rep) {
      print('上传文件成功,最终地址为：：${rep.data['data']}');
      img = rep.data['data'];
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///新增属性
  addFirmSettingByType() {
    firmViewModel
        .addFirmSetting(
      context,
      lawId: widget.id,
      title: _controller.plainTextEditingValue.text,
      type: widget.type,
      value: img,
    )
        .then((rep) {
      showToast(context, '修改成功');
      pop();
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
      title: _controller.plainTextEditingValue.text,
      value: img,
    )
        .then((rep) {
      showToast(context, '修改成功');
      pop();
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      setState(() => {});
      showToast(context, e.message);
    });
  }

  ///添加律师详情资料->微信，电话，邮箱，公众号
  void lawyerContacts() {
    LawyerInFoViewModel()
        .lawyerContacts(
      context,
      //      title: _controller.plainTextEditingValue.text,
      title: _editingController.text,
      value: img,
      type: widget.type,
    )
        .then((rep) {
      showToast(context, '修改成功');
      pop();
      Notice.send(JHActions.myFirmDetailRefresh(), '');
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  //添加图片
  testFile() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    systemViewModel.uploadFile(context, file: image).then((rep) {
      print('上传文件成功,最终地址为：：${rep.data['data']}');
      img = rep.data['data'];
      setState(() {});
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new NavigationBar(
        title: widget.title ?? '律所照片',
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () {
              if (img == null) {
                showToast(context, "请添加图片");
              } else {
                if (widget.from == '律师') {
                  lawyerContacts();
                } else {
                  if (widget.title == '律所公函') {
                    changeAllFirmSetting();
                  } else {
                    addFirmSettingByType();
                  }
                }
              }
            },
            child: Container(
              width: 60,
              height: 28,
              margin: EdgeInsets.symmetric(vertical: 13),
              child: Image.asset(
                  'assets/images/law_firm/3.0x/good_select_pic.png'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: new MainInputBody(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Visibility(
              visible: widget.title != '律所公函',
              child: new Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                height: MediaQuery.of(context).size.height * 0.4,
                child: new Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.colorDivider,
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ThemeColors.color333.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: _editingController != null
                        ? _editingController
                        : new TextEditingController(),
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    ),
                  ),
                ),
//                    new ContentEdit(
//                  contentC: _controller,
//                ),
              ),
            ),
            new Space(),
            image == null
                ? InkWell(
                    child: new Container(
                      margin: EdgeInsets.only(
                          left: winWidth(context) * 0.0427,
                          top: winWidth(context) * 0.0267),
                      color: Colors.grey.withOpacity(0.5),
                      height: winWidth(context) * 0.192,
                      width: winWidth(context) * 0.192,
                      child: new Icon(Icons.add),
                    ),
                    onTap: () {
                      testFile();
                    },
                  )
                : Container(
                    margin: EdgeInsets.only(left: winWidth(context) * 0.016),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: winWidth(context) * 0.2454,
                          width: winWidth(context) * 0.2454,
                          padding: EdgeInsets.all(winWidth(context) * 0.0267),
                          child: Image.network(
                            img != null ? img : '',
                            fit: BoxFit.cover,
                            height: winWidth(context) * 0.192,
                            width: winWidth(context) * 0.192,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          height: winWidth(context) * 0.2454,
                          width: winWidth(context) * 0.2454,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                img = null;
                                image = null;
                              });
                            },
                            child: Image.asset(
                              "assets/images/commom/img_delete.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ContentEdit extends StatefulWidget {
  final ZefyrController contentC;

  const ContentEdit({Key key, this.contentC}) : super(key: key);

  @override
  _ContentEditState createState() => _ContentEditState();
}

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

final doc = r'[{"insert":"\n"}]';

class _ContentEditState extends State<ContentEdit> {
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
