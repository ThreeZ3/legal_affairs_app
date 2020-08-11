import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/mine/my_case/case_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_case/publish_case_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';
import 'package:nav_router/nav_router.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';

/// ${widget.oc}的案例

class MyCasePage extends StatefulWidget {
  final String id;
  final String oc;

  MyCasePage(this.id, this.oc);

  @override
  _MyCasePageState createState() => _MyCasePageState();
}

class _MyCasePageState extends State<MyCasePage> {
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
        title: '${widget.oc}的案例',
        rightDMActions: widget.id == JHData.id()
            ? <Widget>[
                new GestureDetector(
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
                ),
                new SizedBox(
                  width: 20,
                ),
                new GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    routePush(PublishCasePage());
                  },
                  child: Image.asset(
                    'assets/images/mine/share_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                new SizedBox(
                  width: 15,
                ),
              ]
            : [],
      ),
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
          Container(
            height: 17,
            color: Colors.white,
          ),
          Visibility(
            visible: _openDel,
            child: Column(
              children: <Widget>[
                RegisterButtonWidget(
                  title: '删除',
                  horizontal: 16,
                  onTap: () => delCase(),
                ),
                SizedBox(height: 14),
                RegisterButtonWidget(
                  title: '取消',
                  horizontal: 16,
                  titleColors: ThemeColors.color999,
                  backgroundColors: ThemeColors.colore4,
                  onTap: () {
                    setState(() {
                      _openDel = false;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 获取${widget.oc}的全部案例列表
  Future getMyCaseData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    return CaseViewModel()
        .caseList(
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

  ///删除案例
  delCase() {
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

///${widget.oc}的案例Item
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
            : Container(
                margin: EdgeInsets.only(left: 15, right: 5),
                width: 22,
                height: 22,
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
                          color: Color(0xffE1B96B),
                        )
                      : Icon(
                          Icons.panorama_fish_eye,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                ),
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
                  model?.title ?? '未知标题',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeColors.color333,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              new Space(),
              new Text(
                listNoEmpty(model?.trialStage?.split(';'))
                    ? model?.trialStage?.split(';')[1] ?? '未知'
                    : '',
                style: TextStyle(
                    color: Color.fromRGBO(225, 185, 107, 1), fontSize: 14.0),
              ),
            ],
          ),
          new Space(),
          new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: ThemeColors.color999.withOpacity(0.2),
                  )
                ]),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  child: new Text(
                    model?.categoryName ?? '未知',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color.fromRGBO(225, 185, 107, 1),
                        fontSize: 14.0),
                  ),
                ),
              ),
              new Space(),
              new Expanded(
                child: new Text(
                  "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ThemeColors.color999, fontSize: 14.0),
                ),
              ),
              new Space(),
              new Text(
                formatNum(model.value) ?? '未知',
                style: TextStyle(color: ThemeColors.colorRed),
              ),
            ],
          ),
          new Space(),
          new EditRichShowText(json: model?.detail),
          new Space(),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  model?.url ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromRGBO(225, 185, 107, 1), fontSize: 14.0),
                ),
              ),
              new Space(),
              new Text(
                '编号:  ${model?.no ?? ''}',
                style: TextStyle(
                    color: Color.fromRGBO(225, 185, 107, 1), fontSize: 14.0),
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
