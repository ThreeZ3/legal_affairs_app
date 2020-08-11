import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/source/case_source_view_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/api/source/case_source_model.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 律所详情-案源共享
///
class ShareDiabetesMellitusPage extends StatefulWidget {
  final String id;
  final bool isMe;

  ShareDiabetesMellitusPage(this.id, this.isMe);

  @override
  _ShareDiabetesMellitusPageState createState() =>
      _ShareDiabetesMellitusPageState();
}

class _ShareDiabetesMellitusPageState extends State<ShareDiabetesMellitusPage> {
  List<CaseSourceModel> data = new List();
  bool isLoadingOk = false;
  int _goPage = 1;
  bool openDel = false;
  List delList = new List();

  @override
  void initState() {
    super.initState();
    getData();
    Notice.addListener(JHActions.sourceCaseRefresh(), (v) => getData(true));
  }

  Future getData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    caseSourceViewModel
        .sourceCaseShare(
      context,
      limit: 15,
      page: _goPage,
      firmId: widget.id,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  ///超级管理员-删除案源
  void caseSourceDelete() {
    for (int a = 0; a < delList.length; a++) {
      caseSourceViewModel
          .caseSourceDelete(context, id: delList[a])
          .catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      openDel = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        getData(true);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.sourceCaseRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: new NavigationBar(
        title: '案源共享',
        rightDMActions: widget.isMe
            ? <Widget>[
                new GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      openDel = !openDel;
                    });
                  },
                  child: Image.asset(
                    'assets/images/mine/list_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                new SizedBox(
                  width: 15,
                ),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: new DataView(
              isLoadingOk: isLoadingOk,
              data: data,
              onRefresh: () => getData(true),
              onLoad: () {
                _goPage++;
                return getData();
              },
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return SourceCaseItem(
                    index: index,
                    data: data[index],
                    openDel: openDel,
                    itemList: data,
                    delList: delList,
                  );
                },
              ),
            ),
          ),
          new Visibility(
            visible: openDel,
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: MagicBt(
                      onTap: () {
                        caseSourceDelete();
                      },
                      text: '删除',
                      radius: 10.0,
                      height: 40,
                      color: Color.fromRGBO(225, 185, 107, 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: MagicBt(
                      onTap: () {
                        setState(() {
                          openDel = false;
                        });
                      },
                      text: '取消',
                      radius: 10.0,
                      height: 40,
                      color: ThemeColors.color999,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SourceCaseItem extends StatefulWidget {
  final CaseSourceModel data;
  final bool openDel;
  final List itemList;
  final List delList;
  final int index;

  const SourceCaseItem(
      {Key key,
      this.data,
      this.openDel,
      this.itemList,
      this.delList,
      this.index})
      : super(key: key);
  @override
  _SourceCaseItemState createState() => _SourceCaseItemState();
}

class _SourceCaseItemState extends State<SourceCaseItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 15, right: 2),
                width: 16,
                height: 16,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.data.delCheck = !widget.data.delCheck;
                        if (widget.data.delCheck)
                          widget.delList.add(widget.data.id);
                        if (!widget.data.delCheck)
                          widget.delList.remove(widget.data.id);
                      });
                    },
                    child: widget.data.delCheck
                        ? Icon(
                            Icons.check_circle,
                            size: 20.0,
                            color: Color(0xffC0984E),
                          )
                        : Icon(
                            Icons.panorama_fish_eye,
                            size: 20.0,
                            color: Colors.grey,
                          )),
              ),
        Expanded(child: sourceCase(context, widget.index, widget.data)),
      ],
    );
  }
}

Widget sourceCase(context, index, item) {
  CaseSourceModel model = item;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: index == 0
        ? EdgeInsets.only(top: 16, bottom: 8)
        : EdgeInsets.only(top: 8, bottom: 8),
    width: MediaQuery.of(context).size.width - 32,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey[300]),
      ),
    ),
    child: InkWell(
      onTap: () => routePush(new SourceCaseDetailsPage(model.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${model?.title ?? '未知'}',
                      style: TextStyle(
                        color: Color(0xff24262E),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            radius: 25 / 2,
                            backgroundImage: AssetImage(HeadPortrait),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${model?.nickName ?? '未知发布者'}',
//                          '${strNoEmpty(model?.underTakes) ? model.underTakes.length > 15 ? model.underTakes.substring(0, 15) : model.underTakes : '承接者昵称'}',
                          style: TextStyle(
                            color: Color(0xffaaaaaa),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(width: 8),
                        LabelBox(
                          height: 18,
                          width: 31,
                          text: '${model?.categoryName ?? '未知'}',
                        ),
                        SizedBox(width: 8),
                        new Expanded(
                          child: Text(
                            '${model?.limited ?? '未知'}天',
//                                      '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.limited / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                            style: TextStyle(
                              color: Color(0xffaaaaaa),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    model.status?.split(';')[1] ?? '未知状态',
                    style: TextStyle(
                      color: 1 <= 3 ? Color(0xffEBB769) : Color(0xff999999),
                      fontSize: 12,
                    ),
                  ),
                  Space(),
                  Text(
                    '￥${formatNum(model?.fee ?? '未知')}',
                    style: TextStyle(
                        color: Color(0xffFF3333),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              '${model?.content ?? '未知'}',
              style: TextStyle(
                color: Color(0xff24262E),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
