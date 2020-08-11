import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class SocialHonor extends StatefulWidget {
  @override
  _SocialHonorState createState() => _SocialHonorState();
}

final doc =
    r'[{"insert":"社会荣誉"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"wdwdwdwdwdwdw\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

class _SocialHonorState extends State<SocialHonor> {
  String niubi;

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
  lawyerChangeValue() {
    if (strNoEmpty(_controller.plainTextEditingValue.text)) {
      String lawyerInfoIdea = _controller.plainTextEditingValue.text;
      Store(JHActions.lawyerValue()).value = lawyerInfoIdea;
    }
    putLawyerIdea();
  }
  Future putLawyerIdea() async {
    lawyerInFoViewModel
        .updateLawyerHonor(context,
        id: JHData.id(), value: _controller.plainTextEditingValue.text)
        .catchError((e) => showToast(context, e.message));
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
            child: InkWell(
                child: Image.asset('assets/images/mine/return_icon@3x.png')),
          ),
        ),
        title: '社会荣誉',
        rightDMActions: <Widget>[
          done,
          new Container(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                lawyerChangeValue();
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

void socialHonor(){
  LawyerInFoViewModel().addLawyerHonor(context,title: 'sasdas',value: '');
}
}
