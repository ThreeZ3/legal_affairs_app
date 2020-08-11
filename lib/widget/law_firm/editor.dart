import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:oktoast/oktoast.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 自定义编辑页面
///
// class EditorPage extends StatefulWidget {
//   final String text;
//   final String hintText;
//   final TextEditingController textController;
//   final Widget page;
//   final Widget child;
//   final Function picOnTap;
//   EditorPage(
//       {this.text,
//       this.hintText,
//       this.textController,
//       this.page,
//       this.child,
//       this.picOnTap});
//   @override
//   _EditorPageState createState() => _EditorPageState();
// }

// class _EditorPageState extends State<EditorPage> {
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light,
//       child: Container(
//         color: Color(0xff333333),
//         child: SafeArea(
//           child: Scaffold(
//             backgroundColor: Color(0xffffffffE),
//             appBar: AppBar(
//               backgroundColor: Color(0xff333333),
//               elevation: 0,
//               leading: IconButton(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   icon: Image.asset(
//                     ARROWPIC,
//                     width: 26.26,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   }),
//               title: Text(
//                 widget.text,
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               centerTitle: true,
//               actions: <Widget>[
//                 IconButton(
//                   icon: Image.asset(
//                     GoodSelectPic,
//                     width: 25.39,
//                   ),
//                   onPressed: () {
//                     if (widget.textController.text.toString().isEmpty) {
//                       showToast('内容不能为空',
//                           textPadding: EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 16,
//                           ),
//                           position: ToastPosition.center);
//                     } else {
//                       Navigator.pop(
//                           context, widget.textController.text.toString());
//                     }
//                   },
//                 ),
//               ],
//             ),
//             body: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.only(left: 17, right: 16),
//                 child: ListView(
//                   children: <Widget>[
//                     SizedBox(height: 17),
//                     Container(
//                       height: 27.23,
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.symmetric(horizontal: 12),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Image.asset("assets/images/law_firm/left_icon.png"),
//                           lineSpace(), //竖线间隔
//                           Image.asset("assets/images/law_firm/center_icon.png"),
//                           lineSpace(), //竖线间隔
//                           Image.asset("assets/images/law_firm/right_icon.png"),
//                           lineSpace(), //竖线间隔
//                           InkWell(
//                               onTap: widget.picOnTap,
//                               child: Image.asset(
//                                   "assets/images/law_firm/picture.png"),),
//                           lineSpace(), //竖线间隔
//                           Container(
//                             alignment: Alignment.center,
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Text(
//                                 'B',
//                                 style: TextStyle(
//                                   color: Color(0xff626262),
//                                   fontSize: 23,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 19),
//                     Container(
//                       color: Color(0xffF2F2F2),
//                       height: 302,
//                       child: TextField(
//                         controller: widget.textController,
//                         maxLines: 80,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: widget.hintText,
//                           hintStyle: TextStyle(
//                             color: Color(0xff666666),
//                             fontSize: 14,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 18),
//                         ),
//                         cursorColor: Colors.black,
//                         cursorWidth: 1,
//                         onTap: () {},
//                       ),
//                     ),
//                     widget.child,
//                   ],
//                 ),
//               ),
//           ),
//         ),
//       ),
//     );
//   }
class EditorPage extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController textController;
  final Widget page;
  final Widget child;
  final Function picOnTap;

  EditorPage(
      {this.text,
      this.hintText,
      this.textController,
      this.page,
      this.child,
      this.picOnTap});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Color(0xff333333),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffffffffE),
            appBar: AppBar(
              backgroundColor: Color(0xff333333),
              elevation: 0,
              leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Image.asset(
                    ARROWPIC,
                    width: 26.26,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Image.asset(
                    GoodSelectPic,
                    width: 22.38,
                  ),
                  onPressed: () {
                    if (widget.textController.text.toString().isEmpty) {
                      showToast('内容不能为空',
                          textPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          position: ToastPosition.center);
                    } else {
                      Navigator.pop(
                          context, widget.textController.text.toString());
                    }
                  },
                ),
              ],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 17, right: 16),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 17),
                  Container(
                    height: 27.23,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/law_firm/left_icon.png"),
                        lineSpace(), //竖线间隔
                        Image.asset("assets/images/law_firm/center_icon.png"),
                        lineSpace(), //竖线间隔
                        Image.asset("assets/images/law_firm/right_icon.png"),
                        lineSpace(), //竖线间隔
                        InkWell(
                          onTap: widget.picOnTap,
                          child:
                              Image.asset("assets/images/law_firm/picture.png"),
                        ),
                        lineSpace(), //竖线间隔
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'B',
                              style: TextStyle(
                                color: Color(0xff626262),
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 19),
                  Container(
                    color: Color(0xffF2F2F2),
                    height: 302,
                    child: TextField(
                      controller: widget.textController,
                      maxLines: 80,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      onTap: () {},
                    ),
                  ),
                  Container(
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //间隔竖线
  Widget lineSpace() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 2,
      height: 25,
      color: Color(0xffEAEAEA),
    );
  }
}

//图片选择器
class ImagePicked extends StatelessWidget {
  final File images;
  final int index;
  final ValueChanged<int> valueChanged;

  ImagePicked({this.images, this.index, this.valueChanged});

  void _handleCancel() {
    valueChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1.20, -0.80),
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.file(
                images,
                width: 72,
                height: 72,
              ),
            )),
        GestureDetector(
          onTap: _handleCancel,
          child: Container(
            child: Image.asset("assets/images/law_firm/minus.png"),
          ),
        )
      ],
    );
  }
}
