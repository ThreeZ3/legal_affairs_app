import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class QualificationProof extends StatefulWidget {
  @override
  _QualificationProofState createState() => _QualificationProofState();
}

final doc =
    r'[{"insert":"资质证明"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"wdwdwdwdwdwdw\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

class _QualificationProofState extends State<QualificationProof> {
  final ZefyrController _controller =
  ZefyrController(NotusDocument.fromDelta(getDelta()));
  final FocusNode _focusNode = FocusNode();
  StreamSubscription<NotusChange> _sub;
  bool _editing = true;

  @override
  void initState() {
    super.initState();
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final done = _editing
        ? IconButton(
        onPressed: _stopEditing, icon: Icon(Icons.save, color: themeColor))
        : IconButton(
        onPressed: _startEditing,
        icon: Icon(Icons.edit, color: themeColor));

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        leading: new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: new Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset('assets/images/mine/return_icon@3x.png'),
          ),
        ),
        title: '资质证明',
        rightDMActions: <Widget>[
          done,
          new Container(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                print('内容：：${jsonEncode(_controller.document.toJson())}');
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
              vertical: winKeyHeight(context) == 0 ? 20 : 10,
            ),
            height: winKeyHeight(context) == 0
                ? winHeight(context) - 100
                : (winHeight(context) - 90) - winKeyHeight(context),
            color: Color(0xffF2F2F2),
            child: ZefyrScaffold(
              child: ZefyrEditor(
                controller: _controller,
                focusNode: _focusNode,
                mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
                imageDelegate: CustomImageDelegate(),
                keyboardAppearance: Brightness.light,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
