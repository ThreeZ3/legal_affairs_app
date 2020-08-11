import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/all_mission_model.dart';
import 'package:jh_legal_affairs/api/all_mission_view_model.dart';
import 'package:jh_legal_affairs/api/task/mission_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_publish_task_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_task_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class LawyerMyTaskPage extends StatefulWidget {
  final String id;
  final String oc;

  LawyerMyTaskPage(this.id, this.oc);

  @override
  _LawyerMyTaskPageState createState() => _LawyerMyTaskPageState();
}

class _LawyerMyTaskPageState extends State<LawyerMyTaskPage>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;
  bool _delSwitch = false;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        _delSwitch = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.oc}的任务',
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
                new GestureDetector(
                  onTap: () {
                    routePush(LawyerPublicTask());
                    _delSwitch = false;
                  },
                  child: Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/share_icon@3x.png'),
                  ),
                )
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: "全部任务"),
              Tab(text: "${widget.oc}的发布"),
              Tab(text: "${widget.oc}的承接"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                AllTask(0, widget.id, _delSwitch),
                AllTask(1, widget.id, _delSwitch),
                AllTask(2, widget.id, _delSwitch),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//全部任务界面
class AllTask extends StatefulWidget {
  final int index;
  final String id;
  bool delCheckSwitch;
  var value = false;

  Function(bool) onChanged;

  AllTask(this.index, this.id, this.delCheckSwitch,
      {Key key, @required this.value, this.onChanged});

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> with AutomaticKeepAliveClientMixin {
  bool isLoadingOk = false;
  List<MissionRecords> records = new List();
  List delList = new List();
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    reqMethod;
    if (widget.index == 0 || widget.index == 1) {
      Notice.addListener(JHActions.taskRefresh(), (v) {
        reqMethod;
      });
    }
  }

  delMission() {
    for (int i = 0; i < delList.length; i++) {
      missionViewModel
          .deleteMission(
        context,
        id: delList[i],
      )
          .then((rep) {
        setState(() {
          widget.delCheckSwitch = false;
          delList = new List();
          reqMethod;
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
  }

  Future get reqMethod {
    switch (widget.index) {
      case 0:
        return allData();
        break;
      case 1:
        return curData();
        break;
      case 2:
        return underTakeData();
        break;
    }
    return allData();
  }

  Future allData([bool isInit = false]) {
    if (isInit) goPage = 1;
    allMissionViewModel
        .getAllMission(
      context,
      page: goPage,
      limit: 15,
      id: widget.id,
    )
        .then((rep) {
      if (mounted)
        setState(() {
          if (goPage == 1) {
            records = List.from(rep.data);
          } else {
            records.addAll(List.from(rep.data));
          }
          isLoadingOk = true;
        });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  Future curData([bool isInit = false]) {
    if (isInit) goPage = 1;
    missionViewModel
        .missionUserList(
      context,
      page: goPage,
      limit: 15,
      id: widget.id,
    )
        .then((rep) {
      if (mounted)
        setState(() {
          if (goPage == 1) {
            records = List.from(rep.data);
          } else {
            records.addAll(List.from(rep.data));
          }
          isLoadingOk = true;
        });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  Future underTakeData([bool isInit = false]) {
    if (isInit) goPage = 1;
    missionViewModel
        .missionUnderTake(
      context,
      page: goPage,
      limit: 15,
      id: widget.id,
    )
        .then((rep) {
      if (mounted)
        setState(() {
          if (goPage == 1) {
            records = List.from(rep.data);
          } else {
            records.addAll(List.from(rep.data));
          }
          isLoadingOk = true;
        });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  Widget itemBuild(item) {
    MissionRecords model = item;
    List statusList = model.status.split(';');
    return Row(
      children: <Widget>[
        !widget.delCheckSwitch
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 16),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        model.delCheck = !model.delCheck;
                        if (model.delCheck) delList.add(model.id);
                        if (!model.delCheck) delList.remove(model.id);
                      });
                    },
                    child: model.delCheck
                        ? Icon(
                            Icons.check_circle,
                            size: 22,
                            color: ThemeColors.colorOrange,
                          )
                        : Icon(
                            Icons.panorama_fish_eye,
                            size: 22,
                            color: Colors.grey,
                          )),
              ),
        Expanded(
          child: InkWell(
            onTap: () {
              routePush(LawyerTaskDetailsPage(model.id));
            },
            child: Container(
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '${model?.title ?? '未知'}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFE1B96B), width: 1),
                        ),
                        child: Text(
                          '${statusList[1] ?? '未知'}',
                          style: TextStyle(
                            color: Color(0xffE1B96B),
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 22,
                        height: 22,
                        margin: EdgeInsets.only(left: 6, right: 3),
                        child: new CircleAvatar(
                            backgroundImage: strNoEmpty(model?.issuerAvatar)
                                ? CachedNetworkImageProvider(
                                    model?.issuerAvatar)
                                : AssetImage(avatarCommon),
                            radius: 11),
                      ),
                      Text(
                        "${model?.issuerNickName ?? '未知'}",
                        style:
                            TextStyle(color: Color(0xff181111), fontSize: 10),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        color: Colors.grey[300],
                        child: Text(
                          "${model?.category ?? '未知'}",
                          style:
                              TextStyle(color: Color(0xffE1B96C), fontSize: 10),
                        ),
                      ),
                      new Expanded(
                        child: Text(
                          "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}",
                          style:
                              TextStyle(color: Color(0xff181111), fontSize: 10),
                        ),
                      ),
                      Text(
                        '￥${model?.ask ?? 0}',
                        style: TextStyle(
                          color: Color(0xffE12A2A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: new DataView(
            onRefresh: () => allData(true),
            isLoadingOk: isLoadingOk,
            data: records,
            onLoad: () {
              goPage++;
              return allData();
            },
            child: ListView(
              children: records.map(itemBuild).toList(),
            ),
          ),
        ),
        Container(
          height: 17,
          color: Colors.white,
        ),
        widget.delCheckSwitch == false
            ? Container()
            : Column(
                children: <Widget>[
                  RegisterButtonWidget(
                    title: '删除',
                    horizontal: 16,
                    onTap: () => delMission(),
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
    if (widget.index == 0 || widget.index == 1) {
      Notice.removeListenerByEvent(JHActions.taskRefresh());
    }
  }

  @override
  bool get wantKeepAlive => listNoEmpty(records);
}
