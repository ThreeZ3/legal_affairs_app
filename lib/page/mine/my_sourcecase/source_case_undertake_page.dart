import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/bid/bid_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import '../../../common/check.dart';
import '../../../widget_common/view/show_toast.dart';

enum TakeType { sourceCase, missions }

class SourceCaseUndertakePage extends StatefulWidget {
  final String id;
  final String value;
  final String limited;
  final TakeType type;

  SourceCaseUndertakePage(
    this.id,
    this.type, {
    this.value,
    this.limited = '',
  });

  @override
  _SourceCaseUndertakePageState createState() =>
      _SourceCaseUndertakePageState();
}

class _SourceCaseUndertakePageState extends State<SourceCaseUndertakePage> {
  static Delta getDelta() =>
      Delta.fromJson(json.decode(r'[{"insert":"\n"}]') as List);

  final ZefyrController _controller =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  TextEditingController valueC = new TextEditingController();
  TextEditingController limitedC = new TextEditingController();

  take() {
    bidViewModel
        .sourceCaseBidding(
      context,
      sourceId: widget.id,
      offer: int.parse(strNoEmpty(valueC.text) ? valueC.text : '0'),
//      limit: 1,
      limit: int.parse(strNoEmpty(limitedC.text) ? limitedC.text : '0'),
      advantage: _controller.plainTextEditingValue.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  missionsTake() {
    bidViewModel
        .missionsBid(
      context,
      missionsId: widget.id,
      offer: int.parse(strNoEmpty(valueC.text) ? valueC.text : '0'),
//      limit: 1,
      limit: int.parse(strNoEmpty(limitedC.text) ? limitedC.text : '0'),
      advantage: _controller.plainTextEditingValue.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    limitedC.text = widget.limited;
    valueC.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    bool isCase = widget.type == TakeType.sourceCase;
    return new Scaffold(
      appBar: new NavigationBar(title: '我要${isCase ? '承接' : '认领'}'),
      bottomSheet: new SmallButton(
        child: new Text('提交'),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        minWidth: winWidth(context) - 32,
        onPressed: () => isCase ? take() : missionsTake(),
      ),
      body: new MainInputBody(
        child: new ListView(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
          children: <Widget>[
            new ItemView(
              new CaseModel('报价', ''),
              subWidget: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      controller: valueC,
                      textAlign: TextAlign.end,
                      inputFormatters: numFormatter,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入报价',
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      onChanged: (String value) {
                        if (!strNoEmpty(value)) {
                          valueC.text = widget.value;
                        } else if (int.parse(value) > int.parse(widget.value)) {
                          showToast(context, '报价不能大于规定报价');
                          valueC.text = widget.value;
                        }
                      },
                    ),
                  ),
                  new Space(),
                  new Text('¥'),
                ],
              ),
            ),
            new Space(),
            new Text(
              '个人优势',
              style: TextStyle(
                color: Color(0xff24262E),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            new Space(),
            Container(
              height: 220,
              child: new EditRichView(
                contentC: _controller,
                hintText: '个人优势',
              ),
            ),
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: new Divider(),
            ),
            new ItemView(
              new CaseModel('完成时限', ''),
              subWidget: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      controller: limitedC,
                      textAlign: TextAlign.end,
                      inputFormatters: numFormatter,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入时限',
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                  ),
                  new Text('天'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
