import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/business/consult_model.dart';
import 'package:jh_legal_affairs/api/business/consult_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/advisory_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/advisory_release_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/checkBox/round_check_box.dart';

class MyAdvisoryPage extends StatefulWidget {
  final String id;
  final String oc;

  MyAdvisoryPage(this.id, this.oc);

  @override
  _MyAdvisoryPageState createState() => _MyAdvisoryPageState();
}

class _MyAdvisoryPageState extends State<MyAdvisoryPage>
    with TickerProviderStateMixin {
  TabController tabC;
  List tabs;

  @override
  void initState() {
    super.initState();
    tabs = ['全部咨询', '${widget.oc}发布的', '${widget.oc}承接的'];
    tabC = new TabController(length: tabs.length, vsync: this);
    allData();
    curData();
    underTakeData();
    Notice.addListener(JHActions.mineAdvisoryRefresh(), (v) {
      curData();
      allData();
    });
  }

  bool isLoadingOk = false;

  //全部咨询数组
  List<ConsultViewListModel> allRecords = new List();

  //${widget.oc}发布的咨询数组
  List<ConsultViewListModel> myRecords = new List();

  //承接咨询数组
  List<ConsultViewListModel> otherRecords = new List();

  //全部的咨询
  Future allData() {
    consultViewModel
        .consultList(
      context,
      page: 1,
      limit: 10,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        allRecords = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  //${widget.oc}发布的咨询
  Future curData() {
    consultViewModel
        .consultReleaseList(
      context,
      page: 1,
      limit: 10,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        myRecords = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  //承接咨询
  Future underTakeData() {
    consultViewModel
        .consultByUnderList(
      context,
      page: 1,
      limit: 10,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        otherRecords = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
    return Future.value(null);
  }

  //判断是否删除状态
  bool _delSwitch = false;

  //接收咨询ID的数组
  List delList = new List();

  //删除咨询
  delRecords() {
    for (int a = 0; a < delList.length; a++) {
      consultViewModel.deletesConsult(context, delList[a]).then((rep) {
        setState(() {
          allData();
          curData();
          underTakeData();
          _delSwitch = false;
          delList = new List();
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
  }

  @override
  void dispose() {
    Notice.removeListenerByEvent(JHActions.mineAdvisoryRefresh());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        title: '${widget.oc}的咨询',
        rightDMActions: widget.id == JHData.id()
            //判断是否是自己，显示按钮
            ? <Widget>[
                listNoEmpty(allRecords)
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
                new GestureDetector(
                  onTap: () {
                    routePush(AdvisoryReleasePage());
                  },
                  child: Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/share_icon@3x.png'),
                  ),
                ),
              ]
            : [],
      ),
      body: new Column(
        children: <Widget>[
          //导航切换页面
          new Container(
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: new TabBar(
              controller: tabC,
              tabs: tabs.map((tab) => new Tab(text: tab)).toList(),
            ),
          ),
          new Expanded(
            child: new TabBarView(
              controller: tabC,
              children: [
                //全部咨询
                DataView(
                  onRefresh: allData,
                  isLoadingOk: isLoadingOk,
                  data: allRecords,
                  child: ListView.builder(
                      itemCount: allRecords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemBuild(allRecords[index]);
                      }),
                ),
                //${widget.oc}的咨询
                DataView(
                  onRefresh: curData,
                  isLoadingOk: isLoadingOk,
                  data: myRecords,
                  child: ListView.builder(
                      itemCount: myRecords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            itemBuild(myRecords[index]),
                          ],
                        );
                      }),
                ),
                //承接的咨询
                DataView(
                  onRefresh: underTakeData,
                  isLoadingOk: isLoadingOk,
                  data: otherRecords,
                  child: ListView.builder(
                      itemCount: otherRecords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemBuild(otherRecords[index]);
                      }),
                ),
              ],
            ),
          ),
          //点击删除按钮后底部显示的删除,取消按键
          _delSwitch == true
              ? Column(
                  children: <Widget>[
                    RegisterButtonWidget(
                      title: '删除',
                      horizontal: 16,
                      onTap: () => delRecords(),
                    ),
                    SizedBox(height: 14),
                    RegisterButtonWidget(
                      title: '取消',
                      horizontal: 16,
                      titleColors: ThemeColors.color999,
                      backgroundColors: ThemeColors.colore4,
                      onTap: () {
                        setState(() {
                          _delSwitch = false;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

//咨询数列模型
  Widget itemBuild(ConsultViewListModel model) {
    return Row(
      children: <Widget>[
        _delSwitch == true
            ? Padding(
                padding: EdgeInsets.only(left: 16),
                child: RoundCheckBox(
                    value: model.isDel,
                    onCheckColor: ThemeColors.colorOrange,
                    onChanged: (v) {
                      setState(() {
                        model.isDel = !model.isDel;
                        if (model.isDel == true) delList.add(model.id);
                        if (model.isDel == false) delList.remove(model.id);
                      });
                    }),
              )
            : Container(),
        Expanded(
          child: new InkWell(
            child: new Container(
              margin: EdgeInsets.symmetric(vertical: mainSpace, horizontal: 16),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          '${model?.title ?? '未知标题'}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Space(width: winWidth(context) * 0.2053),
                      new Text(
                        '${model.status?.split(';')[1] ?? '未知'}',
                        style:
                            TextStyle(color: Color(0xffE1B96B), fontSize: 14.0),
                      ),
                    ],
                  ),
                  new Space(height: 8),
                  new Row(
                    children: <Widget>[
                      labelItem('${model?.category ?? '未知类别'}'),
                      labelItem('${limitToMonth(model?.limit)}'),
                      new Time(
                        time:
                            '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0')}',
                      ),
                      new Spacer(),
                      new Text(
                        '￥${model?.totalAsk ?? '0'}',
                        style: TextStyle(
                            color: Color(0xffFF3333),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  new Space(height: 6),
                  new EditRichShowText(
                    json: model?.content ?? '未知内容',
                  ),
                ],
              ),
            ),
            onTap: () => routePush(new AdvisoryDetailsPage(model?.id ?? '0')),
          ),
        ),
      ],
    );
  }
}
