import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class LawyerIntroductionEdit extends StatefulWidget {
  final String defaultText;

  const LawyerIntroductionEdit({Key key, this.defaultText}) : super(key: key);

  @override
  _LawyerIntroductionEditState createState() => _LawyerIntroductionEditState();
}

//final doc =
//    r'[{"insert":"律师简介"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"\n"}]';
//
//Delta getDelta() {
//  return Delta.fromJson(json.decode(doc) as List);
//}

class _LawyerIntroductionEditState extends State<LawyerIntroductionEdit> {
  final TextEditingController _textC = new TextEditingController();
//  final ZefyrController _controller =
//      ZefyrController(NotusDocument.fromDelta(getDelta()));
//  StreamSubscription<NotusChange> _sub;
//  bool _editing = true;
//  String _text;

  @override
  void initState() {
    _textC.text = widget.defaultText;
//    super.initState();
//    _sub = _controller.document.changes.listen((change) {
//      print('${change.source}: ${change.change}');
//    });
  }

  ///修改律师简介
  Future putLawyerInfo() async {
    lawyerInFoViewModel
        .changeLawyerInfo(context, id: JHData.id(), info: _textC.text)
        .catchError((e) => showToast(context, e.message));
  }

  lawyerChangeValue() {
    if (strNoEmpty(_textC.text)) {
      String lawyerInfo = _textC.text;
      storeString(JHActions.lawyerInfo(), lawyerInfo);
      Store(JHActions.lawyerInfo()).value = lawyerInfo;
    }
    putLawyerInfo();
  }

  @override
  Widget build(BuildContext context) {
//    final done = _editing
//        ? IconButton(
//            onPressed: _stopEditing, icon: Icon(Icons.save, color: themeColor))
//        : IconButton(
//            onPressed: _startEditing,
//            icon: Icon(Icons.edit, color: themeColor));

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '律师简介',
        rightDMActions: <Widget>[
//          done,
          new Container(
            padding: EdgeInsets.all(13.0),
            child: InkWell(
              onTap: () {
                /* lawyerChangeValue();*/
                putLawyerInfo();
              },
              child: Image.asset('assets/images/mine/ok_icon@3x.png'),
            ),
          ),
        ],
      ),
      body: new MainInputBody(
        child: new SingleChildScrollView(
          child: new Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            height: 302,
            color: Color(0xffF2F2F2),
            child: TextField(
              controller: _textC,
              maxLines: 15,
//              onChanged: (v) {
//                setState(() {
//                  _textC.text = v;
//                });
//              },
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(100),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: widget?.defaultText ?? '律师简介',
                hintStyle: TextStyle(color: Color(0xff666666), fontSize: 14.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

//  void _startEditing() {
//    setState(() {
//      _editing = true;
//    });
//  }
//
//  void _stopEditing() {
//    setState(() {
//      _editing = false;
//    });
//  }
//
//  @override
//  void dispose() {
//    _sub.cancel();
//    super.dispose();
//  }
}
