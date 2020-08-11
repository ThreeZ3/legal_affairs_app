import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';

/// 我的课件-订阅情况

class MyCourseWareSubscriptionPage extends StatefulWidget {
  final String id;

  const MyCourseWareSubscriptionPage({Key key, this.id}) : super(key: key);

  @override
  _MyCourseWareSubscriptionPageState createState() =>
      _MyCourseWareSubscriptionPageState();
}

class _MyCourseWareSubscriptionPageState
    extends State<MyCourseWareSubscriptionPage> {
  List lectureSubList = new List();
  double inCome;
  bool isLoadingOk = false;
  bool isShow = true;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    lectureSubscriptionDetails();
    lectureSubscriptionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: '订阅情况',
      ),
      body: Column(
        children: <Widget>[
          new Container(
            height: 65,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 10, color: ThemeColors.colorDivider),
              bottom: BorderSide(width: 10, color: ThemeColors.colorDivider),
            )),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: <Widget>[
                  new Text(
                    '已收入',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  new Text(
                    '￥ ${inCome.toString()}',
                    style:
                        TextStyle(fontSize: 16.0, color: ThemeColors.colorRed),
                  ),
                ],
              ),
            ),
          ),
          new ListTile(
            leading: new Text(
              '收入明细',
              style: TextStyle(fontSize: 16),
            ),
            trailing: new Icon(
              isShow ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              size: 45,
            ),
            onTap: () {
              setState(() {
                isShow = !isShow;
              });
            },
          ),
          new HorizontalLine(
            color: ThemeColors.colorDivider,
            height: 1,
          ),
          new Expanded(
            child: new Visibility(
              visible: isShow,
              child: new DataView(
                data: lectureSubList,
                isLoadingOk: isLoadingOk,
                onRefresh: () => lectureSubscriptionList(true),
                onLoad: () {
                  goPage++;
                  return lectureSubscriptionList();
                },
                child: ListView(
                  children: lectureSubList.map((item) {
                    return IncomeDetails(
                      data: item,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///获取订阅情况详情
  void lectureSubscriptionDetails() {
    ///获取课件总收入
    lectureViewModel
        .lectureSubscriptionIncome(context, id: widget.id)
        .then((rep) {
      setState(() {
        inCome = rep.data;
      });
    }).catchError((e) => showToast(context, e.message));
  }

  ///获取订阅收入明细
  Future lectureSubscriptionList([bool isInit = false]) async {
    if (isInit) goPage = 1;
    return lectureViewModel
        .lectureSubscriptionList(context,
            id: widget.id, limit: 10, page: goPage)
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          lectureSubList = rep.data;
        } else {
          lectureSubList.addAll(rep.data);
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }
}

class IncomeDetails extends StatelessWidget {
  final LectureSubscriptionModel data;

  const IncomeDetails({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 12.0, right: 12, top: 8),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ThemeColors.colorDivider, width: 0.7))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: 5.0),
              child: new CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(
                    '${data?.avatar}' ?? NETWORK_IMAGE),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${data?.nickName}' ?? 'null',
                style: TextStyle(fontSize: 16.0),
              ),
              Space(),
              Text(
                '${data?.createTime}' ?? 'null',
                style: TextStyle(color: ThemeColors.color999),
              ),
            ],
          ),
          Spacer(),
          new Text(
            '${data?.charges?.toString() ?? '0.0'}',
            style: TextStyle(fontSize: 16.0, color: ThemeColors.colorRed),
          ),
        ],
      ),
    );
  }
}
