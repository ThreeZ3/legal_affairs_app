import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/source/case_source_model.dart';
import 'package:jh_legal_affairs/api/source/case_source_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/souce_case_bid_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_undertake_page.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class SourceCaseDetailsPage extends StatefulWidget {
  final String id;

  SourceCaseDetailsPage(this.id);

  @override
  _SourceCaseDetailsPageState createState() => _SourceCaseDetailsPageState();
}

class _SourceCaseDetailsPageState extends State<SourceCaseDetailsPage> {
  SourceCaseDetails model = new SourceCaseDetails();
  bool isLawyer;

  @override
  void initState() {
    super.initState();

    print("当前用户Id： ${JHData.id()}");

    initData();
    JHData.userType().startsWith("2") ? isLawyer = true : isLawyer = false;
  }

  initData() {
    caseSourceViewModel
        .sourceCaseDetails(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        model = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    List data = [
      new CaseModel('案源标题', '${model?.title ?? '未知'}'),
      new CaseModel('发布者', '${model?.nickName ?? '未知'}'),
      new CaseModel('业务类别', '${model?.categoryName ?? '未知'}'),
      new CaseModel('执行情况',
          '${strNoEmpty(model?.status) ? model.status.split(";")[1] : '无'}'),
      new CaseModel('时限', '${limitToMonth(model?.limited)}'),
      new CaseModel('案件标的额', "¥ ${formatNum(model?.value)}"),
      new CaseModel('律师费预算', "¥ ${formatNum(model?.fee)}"),
      new CaseModel('案情简介', '${model?.content ?? '未知'}'),
      new CaseModel('竞价列表', ''),
    ];

    return new Scaffold(
      appBar: new NavigationBar(title: '案源详情'),
      bottomSheet: strNoEmpty(model.status) &&
              (model.status.startsWith("2") || model.status.startsWith("3"))
          ? Offstage(
              offstage: !((JHData.id() == model.lawyerId &&
                  (model.status.startsWith("2") &&
                      JHData.id() == model.underTakes))),
              child: new SmallButton(
                child: new Text('确认完成'),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                minWidth: winWidth(context) - 32,
                onPressed: () {
                  themeAlert(
                    context,
                    okBtn: '确认',
                    cancelBtn: '取消',
                    warmStr: '您确认已经完成了吗？',
                    okFunction: () {
                      print('确认完成了！！！！！！！！！！！');
                      if (JHData.id() == model.lawyerId) {
                        sourceCaseConfirm();
                      } else {
                        sourceCaseCompleted();
                      }
                    },
                    cancelFunction: () {},
                  );
                },
              ),
            )
          : Offstage(
              offstage: !(isLawyer && (JHData.id() != model.lawyerId)),
              child: new SmallButton(
                child: new Text('我要承接'),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                minWidth: winWidth(context) - 32,
                onPressed: () => routePush(new SourceCaseUndertakePage(
                  widget.id,
                  TakeType.sourceCase,
                  value: '${model?.value ?? 0}',
                  limited: '${model?.limited ?? '未知'}',
                )),
              ),
            ),
      body: new ListView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
        children: data.map((item) {
          if (item.label == '竞价列表') {
            return BidListButton(
              onPressed: () => routePush(new SourceCaseBidPage(
                  model.id, model?.title ?? '未知', TakeType.sourceCase)),
            );
          }
          return ItemView(item);
        }).toList(),
      ),
    );
  }

  /// 发布者确认完成
  sourceCaseConfirm() {
    caseSourceViewModel
        .sourceCaseConfirm(
          context,
          id: widget.id,
        )
        .then((rep) {})
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  /// 承接者确认完成
  sourceCaseCompleted() {
    caseSourceViewModel
        .sourceCaseCompleted(
          context,
          id: widget.id,
        )
        .then((rep) {})
        .catchError((e) {
      showToast(context, e.message);
    });
  }
}

class BidListButton extends StatelessWidget {
  final VoidCallback onPressed;

  BidListButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            '竞价列表',
            style: TextStyle(
              color: Color(0xff24262E),
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          new Icon(CupertinoIcons.right_chevron),
        ],
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final CaseModel model;
  final bool isBorder;
  final Widget subWidget;

  ItemView(this.model, {this.isBorder = true, this.subWidget});

  @override
  Widget build(BuildContext context) {
    bool isWrap = model.label != '案情简介' &&
        model.label != '要求' &&
        model.label != '竞争优势' &&
        model.label != '简介';
    bool isRich = model.label == '案情简介';
    return Container(
      width: winWidth(context) - 40,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: isBorder
            ? Border(
                bottom: BorderSide(
                    color: Color(0xff11152B).withOpacity(0.2), width: 0.5),
              )
            : null,
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(
                model.label,
                style: TextStyle(
                  color: Color(0xff24262E),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              new Space(width: 30.0),
              new Expanded(
                child: subWidget != null
                    ? subWidget
                    : new Text(
                        isWrap ? model.value : '',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Color(0xff666666).withOpacity(0.8),
                            fontSize: 14.0),
                      ),
              )
            ],
          ),
          new Visibility(
            visible: !isWrap,
            child: new Space(),
          ),
          new Visibility(
            visible: !isWrap,
            child: isRich
                ? new EditRichShow(
                    json: model?.value ?? '未知内容',
                  )
                : new Text(
                    model.value,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xff666666).withOpacity(0.8),
                        fontSize: 14.0),
                  ),
          )
        ],
      ),
    );
  }
}

class CaseModel {
  final String label;
  final String value;

  CaseModel(this.label, this.value);
}
