import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/source/case_source_model.dart';
import 'package:jh_legal_affairs/api/source/case_source_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/publish_sourcecase_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/checkBox/round_check_box.dart';

import '../../../data/data.dart';
import '../../../widget_common/theme_colors.dart';

class MySourcecase extends StatefulWidget {
  final String id;
  final String oc;

  MySourcecase(this.id, this.oc);

  @override
  _MySourcecaseState createState() => _MySourcecaseState();
}

class _MySourcecaseState extends State<MySourcecase>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool _delSwitch = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _delSwitch = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.oc}的案源',
        rightDMActions: widget.id == JHData.id()
            ? <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _delSwitch = !_delSwitch;
                    });
                  },
                  child: new Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/list_icon@3x.png'),
                  ),
                ),
                new InkWell(
                  child: new Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/share_icon@3x.png'),
                  ),
                  onTap: () {
                    routePush(SourcecasePublish());
                    _delSwitch = false;
                  },
                )
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "全部案源",
              ),
              Tab(
                text: "${widget.oc}发布的",
              ),
              Tab(
                text: "${widget.oc}承接的",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SourcecaseOne(0, widget.id, _delSwitch),
                SourcecaseOne(1, widget.id, _delSwitch),
                SourcecaseOne(2, widget.id, _delSwitch)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//全部案源界面
class SourcecaseOne extends StatefulWidget {
  final int type;
  final String id;
  bool delCheckSwitch;

  SourcecaseOne(this.type, this.id, this.delCheckSwitch);

  @override
  _SourcecaseOneState createState() => _SourcecaseOneState();
}

class _SourcecaseOneState extends State<SourcecaseOne>
    with AutomaticKeepAliveClientMixin {
  List _sourcecaseAllList = new List();
  bool isLoadingOk = false;
  List delList = new List();

  @override
  void initState() {
    super.initState();
    getCaseSourceMy();
    if (widget.type == 0 || widget.type == 1) {
      Notice.addListener(JHActions.caseRefresh(), (v) {
        getCaseSourceMy();
      });
    }
  }

  delCaseSource() {
    for (int a = 0; a < delList.length; a++) {
      caseSourceViewModel.caseSourceDelete(context, id: delList[a]).then((rep) {
        setState(() {
          widget.delCheckSwitch = false;
          delList = new List();
          getCaseSourceMy();
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
  }

  Future getCaseSourceMy() {
    return caseSourceViewModel
        .caseSourceMy(
      context,
      type: widget.type,
      limit: 15,
      page: 1,
      id: widget.id,
    )
        .then((rep) {
      if (mounted)
        setState(() {
          _sourcecaseAllList = List.from(rep.data);
          isLoadingOk = true;
        });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: new DataView(
            isLoadingOk: isLoadingOk,
            data: _sourcecaseAllList,
            onRefresh: getCaseSourceMy,
            child: ListView(
              children: _sourcecaseAllList.map((item) {
                CaseSourceModel model = item;
                return Row(
                  children: <Widget>[
                    !widget.delCheckSwitch
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: RoundCheckBox(
                              value: model.delCheck,
                              onCheckColor: ThemeColors.colorOrange,
                              onChanged: (v) {
                                setState(() {
                                  model.delCheck = !model.delCheck;
                                  if (model.delCheck) delList.add(model.id);
                                  if (!model.delCheck) delList.remove(model.id);
                                });
                              },
                            ),
                          ),
                    Expanded(
                      child: new InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[300]))),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${model.title}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${model.status.split(";")[1]}",
                                      style: TextStyle(
                                          color: Color(0xffE1B96B),
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                                SizedBox(height: 7),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      color: ThemeColors.colorf0,
                                      child: Text(
                                        "${model.categoryName}",
                                        style: TextStyle(
                                            color: Color(0xffE1B96B),
                                            fontSize: 12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 3),
                                    ),
                                    Space(),
                                    Container(
                                      color: ThemeColors.colorf0,
                                      child: Text(
                                        "${limitToMonth(model?.limited ?? 0)}",
                                        style: TextStyle(
                                            color: Color(0xffE1B96B),
                                            fontSize: 12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 3),
                                    ),
                                    SizedBox(width: 10),
                                    model.createTime != null
                                        ? Text(
                                            DateTimeForMater
                                                .formatTimeStampToString(
                                              stringDisposeWithDouble(
                                                  model.createTime / 1000),
                                            ),
                                            style: TextStyle(
                                              color: ThemeColors.color999,
                                              fontSize: 12,
                                            ),
                                          )
                                        : Text(
                                            '未知时间',
                                            style: TextStyle(
                                              color: ThemeColors.color999,
                                              fontSize: 12,
                                            ),
                                          ),
                                    Spacer(),
                                    Text(
                                      "￥" + "${formatNum(model?.fee)}",
                                      style: TextStyle(
                                          color: Color(0xffFF002B),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Space(),
                                EditRichShowText(
                                  json: model?.content ?? '未知内容',
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            routePush(new SourceCaseDetailsPage(model.id));
                            print(
                                '获取的时间：createTime：=====> ${model.createTime}');
                            print('nickName：=====> ${model.nickName}');
                          }),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        widget.delCheckSwitch == false
            ? Container()
            : Column(
                children: <Widget>[
                  RegisterButtonWidget(
                    title: '删除',
                    horizontal: 16,
                    onTap: () => delCaseSource(),
                  ),
                  SizedBox(height: 14),
                  RegisterButtonWidget(
                    title: '取消',
                    horizontal: 16,
                    titleColors: ThemeColors.color999,
                    backgroundColors: ThemeColors.colore4,
                    onTap: () {
                      setState(() {
                        widget.delCheckSwitch = false;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (widget.type == 1 || widget.type == 2) {
      Notice.removeListenerByEvent(JHActions.caseRefresh());
    }
  }

  @override
  bool get wantKeepAlive => listNoEmpty(_sourcecaseAllList);
}
