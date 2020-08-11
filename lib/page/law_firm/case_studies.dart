import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_case/case_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/checkCircle_Widget.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

///案例分享
class CaseStudies extends StatefulWidget {
  final String id;
  final bool isMe;

  CaseStudies(this.id, this.isMe);

  @override
  _CaseStudiesState createState() => _CaseStudiesState();
}

class _CaseStudiesState extends State<CaseStudies> {
  bool _openDel = false;
  bool _isLoadingOk = false;
  int _goPage = 1;
  List _delList = new List();

  List<ConsultListModel> _consultList = new List();

  @override
  void initState() {
    super.initState();
    getMyCaseData();
    Notice.addListener(JHActions.caseRefresh(), (v) {
      getMyCaseData(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
          title: '案例分享',
          rightDMActions: widget.isMe
              ? <Widget>[
                  listNoEmpty(_delList)
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _openDel = !_openDel;
                            });
                          },
                          child: Image.asset(
                            'assets/images/mine/list_icon@3x.png',
                            width: 22.0,
                          ),
                        )
                      : Container(),
                  new SizedBox(
                    width: 15,
                  ),
                ]
              : []),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new DataView(
              isLoadingOk: _isLoadingOk,
              data: _consultList,
              onRefresh: () => getMyCaseData(true),
              onLoad: () {
                _goPage++;
                return getMyCaseData();
              },
              child: new ListView(
                children: _consultList.map((item) {
                  return MuCaseItem(
                    openDel: _openDel,
                    data: item,
                    itemList: _consultList,
                    delList: _delList,
                  );
                }).toList(),
              ),
            ),
          ),
          new Visibility(
            visible: _openDel,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: MagicBt(
                      onTap: () {
                        delCaseFirm();
                      },
                      text: '删除',
                      radius: 5.0,
                      height: 40,
                      color: Color.fromRGBO(225, 185, 107, 1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: MagicBt(
                      onTap: () {
                        setState(() {
                          _openDel = false;
                        });
                      },
                      text: '取消',
                      radius: 5.0,
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

  /// 获取律所全部案例分享列表
  Future getMyCaseData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    return CaseViewModel()
        .caseFirm(
      context,
      id: widget.id,
      limit: 10,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          _consultList = List.from(rep.data);
        } else {
          _consultList.addAll(List.from(rep.data));
        }
        _isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        _isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  ///删除案例分享
  delCaseFirm() {
    for (int a = 0; a < _delList.length; a++) {
      caseViewModel.deleteCase(context, id: _delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _openDel = false;
      _delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        getMyCaseData(true);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.caseRefresh());
  }
}

///我的案例Item
class MuCaseItem extends StatefulWidget {
  final ConsultListModel data;
  final bool openDel;
  final List itemList;
  final List delList;

  const MuCaseItem(
      {Key key, this.openDel, this.data, this.itemList, this.delList})
      : super(key: key);

  @override
  _MuCaseItemState createState() => _MuCaseItemState();
}

class _MuCaseItemState extends State<MuCaseItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : CheckCircle(
                value: widget.data.delCheck,
                onTap: () {
                  setState(() {
                    widget.data.delCheck = !widget.data.delCheck;
                    if (widget.data.delCheck)
                      widget.delList.add(widget.data.id);
                    if (!widget.data.delCheck)
                      widget.delList.remove(widget.data.id);
                  });
                },
              ),
        Expanded(child: myCaseItem(widget.data)),
      ],
    );
  }
}

//案例Item
Widget myCaseItem(item) {
  ConsultListModel model = item;
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      routePush(CaseDetailsPage(
        id: model.id,
        url: model?.url ?? '',
        no: model?.no ?? '',
      ));
    },
    child: new Container(
      margin: EdgeInsets.only(right: 14.0, left: 14.0, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  model?.title ?? 'null',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeColors.color333,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              new Space(),
              new Text(
                model.trialStage.split(";")[1] ?? 'null',
                style: TextStyle(
                  color: ThemeColors.colorOrange,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          new Space(),
          new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.color999.withOpacity(0.2),
                    )
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  child: new Text(
                    model?.categoryName ?? 'null',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeColors.colorOrange,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              new Space(),
              new Expanded(
                child: new Text(
                  "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ThemeColors.color999,
                    fontSize: 12,
                  ),
                ),
              ),
              new Space(),
              new Text(
                "￥${model?.value ?? "0.00"}",
                style: TextStyle(
                  color: Color(0xffFFF94D4D),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          new Space(),
          new Text(
            "[案情介绍]：${model?.detail ?? "    "}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ThemeColors.color666, fontSize: 11),
          ),
          new Space(),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  model?.url ?? 'null',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ThemeColors.colorOrange,
                    fontSize: 10,
                  ),
                ),
              ),
              new Space(),
              new Text(
                '编号:  ${model?.no ?? 'null'}',
                style: TextStyle(
                  color: Color(0xffFFE1B96B),
                  fontSize: 10,
                ),
              )
            ],
          ),
          new Space(),
          new HorizontalLine(
            color: ThemeColors.colorDivider,
            height: 0.7,
          ),
        ],
      ),
    ),
  );
}

////圆形选择按钮
//Widget checkCircle({bool value, Function onTap}) {
//  return Center(
//    child: InkWell(
//      onTap: onTap,
//      child: Padding(
//        padding: EdgeInsets.all(0),
//        child: value
//            ? Icon(
//                Icons.check_circle,
//                size: 22.0,
//                color: ThemeColors.colorOrange,
//              )
//            : Icon(
//                Icons.panorama_fish_eye,
//                size: 22.0,
//                color: Colors.grey,
//              ),
//      ),
//    ),
//  );
//}
