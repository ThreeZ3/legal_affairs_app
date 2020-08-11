import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class AccusationPage extends StatefulWidget {
  final String id;
  final int type;

  const AccusationPage({Key key, this.id, this.type}) : super(key: key);

  @override
  _AccusationPageState createState() => _AccusationPageState();
}

class _AccusationPageState extends State<AccusationPage> {
  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);

  final ZefyrController _controller =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  String img;
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

  //发布举报
  _accusation() {
    lawyerViewModel
        .lawyerAccusation(
      context,
      lawId: widget.id,
      img: img,
      content: _controller.plainTextEditingValue.text,
      type: widget.type,
    )
        .then((rep) {
      pop();
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
        title: '举报',
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () {
              if (image == null) {
                img = image;
              } else {
                _imageUrl();
              }
              return _accusation();
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              height: MediaQuery.of(context).size.height * 0.4,
              child: new EditRichView(
                contentC: _controller,
                hintText: '请编辑举报内容',
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
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
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
//            new Wrap(
//              spacing: 16,
//              runSpacing: 16,
//              crossAxisAlignment: WrapCrossAlignment.start,
//              children: [
//                new InkWell(
//                  child: new Container(
//                    color: Colors.grey.withOpacity(0.5),
//                    height: 100,
//                    width: (winWidth(context) - 64) / 3,
//                    child: new Icon(Icons.add),
//                  ),
//                  onTap: () {},
//                ),
//              ],
//            ),
            new Space(),
          ],
        ),
      ),
    );
  }
}
