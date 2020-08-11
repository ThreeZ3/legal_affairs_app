import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/api/task/mission_view_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_task_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-23
///
/// 律所详情-任务列表
class TaskListPage extends StatefulWidget {
  final String id;
  final bool isMe;

  TaskListPage(this.id, this.isMe);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isLoadingOk = false;
  bool isStart = false;
  int _goPage = 1;
  List<MissionFirmModel> data = new List();
  bool _delSwitch = false;
  List delList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    missionFirmListHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: new NavigationBar(
        title: '任务列表',
        rightDMActions: widget.isMe
            //判断是否是自己，显示按钮
            ? <Widget>[
                listNoEmpty(data)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _delSwitch = !_delSwitch;
                          });
                        },
                        child: new Container(
                          padding: EdgeInsets.all(13.0),
                          child: Image.asset(
                              'assets/images/mine/list_icon@3x.png'),
                        ),
                      )
                    : new Container(),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DataView(
              isLoadingOk: isLoadingOk,
              data: data,
              onRefresh: () => missionFirmListHandle(),
              child: ListView(
                shrinkWrap: true,
                children: data.map((item) {
                  MissionFirmModel model = item;
                  return Row(
                    children: <Widget>[
                      !_delSwitch
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(left: 16),
                              width: 20,
                              child: Checkbox(
                                  value: model.isDel,
                                  onChanged: (v) {
                                    setState(() {
                                      model.isDel = !model.isDel;
                                      if (model.isDel) delList.add(model.id);
                                      if (!model.isDel)
                                        delList.remove(model.id);
                                    });
                                  },
                                  activeColor: Color(0xffFFE1B96B)),
                            ),
                      new InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: 1 == 0
                              ? EdgeInsets.only(top: 16, bottom: 8)
                              : EdgeInsets.only(top: 8, bottom: 8),
                          width: !_delSwitch
                              ? winWidth(context) - 32
                              : winWidth(context) - 68,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[300]),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model?.title ?? '未知标题',
                                    style: TextStyle(
                                      color: Color(0xff24262E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          radius: 25 / 2,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  model?.issuerAvatar ??
                                                      HeadPortrait),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        model?.issuerNickName ?? '未知咨询者名',
                                        style: TextStyle(
                                          color: Color(0xffaaaaaa),
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 8),
                                      LabelBox(
                                        height: 18,
                                        width: 31,
                                        text: model?.category ?? '未知类别',
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        DateTimeForMater
                                            .formatTimeStampToString(
                                                stringDisposeWithDouble(
                                                    (model?.createTime ?? 0) /
                                                        1000)),
                                        style: TextStyle(
                                          color: Color(0xffaaaaaa),
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '${strNoEmpty(model.status) ? model.status.split(";")[1] : ""}',
                                    style: TextStyle(
                                      color: 1 <= 3
                                          ? Color(0xffEBB769)
                                          : Color(0xff999999),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Space(),
                                  Text(
                                    '￥${formatNum(model?.ask ?? '未知价格')}',
                                    style: TextStyle(
                                        color: Color(0xffFF3333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () =>
                            routePush(new LawyerTaskDetailsPage(model.id)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          new Visibility(
            visible: _delSwitch,
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
                        delFunction();
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
                          _delSwitch = false;
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

  void delFunction() {
    for (int a = 0; a < delList.length; a++) {
      missionViewModel.deletesMission(context, ids: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _delSwitch = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 2000), () {}).then((v) {
        missionFirmListHandle();
      });
    });
  }

  //律所获取任务列表
  Future missionFirmListHandle() {
    return myLawFirmViewModel
        .missionFirmList(context, id: widget.id, page: _goPage, limit: 15)
        .then((rep) {
      setState(() {
        isStart = true;
        isLoadingOk = true;
        data = List.from(rep.data);
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }
}
