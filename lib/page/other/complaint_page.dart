import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class FeedbackPage extends StatefulWidget {
  final String id;
  final int type;

  const FeedbackPage({Key key, this.id, this.type}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);

  final ZefyrController _controller =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

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

  //发布反馈
  _complaint() {
    lawyerViewModel
        .lawyerComplaint(
      context,
      lawId: widget.id,
      img: img,
      content: _controller.plainTextEditingValue.text,
      type: widget.type,
    )
        .then((rep) {
      Navigator.of(context).pop();
      showToast(context, '反馈成功');
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  //添加图片
  testFile() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
    if (image == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new NavigationBar(
        title: '反馈',
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () {
              if (image == null) {
                img = image;
              } else {
                _imageUrl();
              }
              return _complaint();
            },
            child: Container(
              width: 60,
              height: 28,
              margin: EdgeInsets.symmetric(vertical: 13),
              child: Image.asset('assets/images/mine/share_icon@3x.png'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: new MainInputBody(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              height: MediaQuery.of(context).size.height * 0.4,
              child: new EditRichView(
                contentC: _controller,
                hintText: '请编辑反馈内容',
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
                      FocusScope.of(context).requestFocus(new FocusNode());
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
                          child: Image.file(
                            image,
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
