import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/souce_case_bid_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_undertake_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/api/task/mission_detail_model.dart';
import 'package:jh_legal_affairs/api/task/mission_detail_view_model.dart';

class LawyerTaskDetailsPage extends StatefulWidget {
  final String id;

  LawyerTaskDetailsPage(this.id);

  @override
  _LawyerTaskDetailsPageState createState() => _LawyerTaskDetailsPageState();
}

class _LawyerTaskDetailsPageState extends State<LawyerTaskDetailsPage> {
  MissionDetailModel missionDetail = MissionDetailModel();
  bool isLawyer;

  @override
  void initState() {
    super.initState();
    getMissionDetail();
    JHData.userType().startsWith("2") ? isLawyer = true : isLawyer = false;
//    Notice.addListener(JHActions.taskRefresh(), (data) => getMissionDetail());
  }

  /// 获取任务详情
  getMissionDetail() {
    missionDetailViewModel.missionDetail(context, widget.id).then((rep) {
      setState(() {
        missionDetail = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
//    Notice.removeListenerByEvent(JHActions.taskRefresh());
  }

  @override
  Widget build(BuildContext context) {
    List data = [
      new CaseModel('任务标题', '${missionDetail?.title ?? '无'}'),
      new CaseModel('发布', '${missionDetail?.issuerNickName ?? '承接人名称'}'),
      new CaseModel('业务类别', '${missionDetail?.categoryName ?? '未知'}'),
      new CaseModel('执行情况',
          '${strNoEmpty(missionDetail?.status) ? missionDetail.status.split(";")[1] : '无'}'),
      new CaseModel('时限', '${missionDetail?.limit ?? '未知多少'}' + '天'),
      new CaseModel('区域',
          '${missionDetail?.province ?? '未知省'} ${missionDetail?.city ?? '未知市'} ${missionDetail?.district ?? '未知区'}'),
      new CaseModel('报价', '￥${formatNum(missionDetail?.ask)}'),
      new CaseModel('简介', '${missionDetail?.content ?? '无'}'),
      new CaseModel('要求', '${missionDetail?.require ?? '无'}'),
      new CaseModel('竞价列表', ''),
    ];

    return Scaffold(
      appBar: NavigationBar(title: '任务详情'),
      bottomSheet: strNoEmpty(missionDetail?.status) &&
              (missionDetail.status.startsWith("2") ||
                  missionDetail.status.startsWith("3"))
          ? Offstage(
              offstage: !((JHData.id() == missionDetail?.issuerId &&
                  (missionDetail.status.startsWith("2") &&
                      JHData.id() == missionDetail.underTakes))),
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
                      if (JHData.id() == missionDetail.issuerId) {
                        missionPublishConfirm();
                      } else {
                        missionCompleted();
                      }
                    },
                    cancelFunction: () {},
                  );
                },
              ),
            )
          : new Offstage(
              offstage: !(isLawyer && (JHData.id() != missionDetail?.issuerId)),
              child: new SmallButton(
                child: new Text('认领'),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                minWidth: winWidth(context) - 32,
                onPressed: () => routePush(new SourceCaseUndertakePage(
                  widget.id,
                  TakeType.missions,
                  value: '${missionDetail?.ask ?? 0}',
                  limited: '${missionDetail?.limit ?? '未知'}',
                )),
              ),
            ),
      body: new ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 100),
        children: data.map((item) {
          if (item.label == '竞价列表') {
            return BidListButton(
              onPressed: () => routePush(new SourceCaseBidPage(missionDetail.id,
                  missionDetail?.title ?? '未知', TakeType.missions)),
            );
          }
          return ItemView(item);
        }).toList(),
      ),
//      new Column(
//        children: <Widget>[
//          new ListView(
//            shrinkWrap: true,
//            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 100),
//            children: data.map((item) {
//              if (item.label == '竞价列表') {
//                return BidListButton(
//                  onPressed: () => routePush(new SourceCaseBidPage(
//                      missionDetail.id,
//                      missionDetail?.title ?? '未知',
//                      TakeType.missions)),
//                );
//              }
//              return ItemView(item);
//            }).toList(),
//          ),
//          new Visibility(
//            visible: strNoEmpty(missionDetail.status)
//                ? missionDetail.status.split(';')[1] == '待支付'
//                : false,
//            child: new SmallButton(
//                child: new Text('支付'),
//                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                minWidth: winWidth(context) - 32,
//                onPressed: () {
//                  payDetailDialog(
//                    context,
//                    type: payType.weChat,
//                    itemId: missionDetail.id,
//                    orderType: 4,
//                    price: missionDetail.ask,
//                  ).then((v) {
//                    if (v == null || !v) {
////          showToast(context, '请支付');
//                    } else {
//                      Notice.send(JHActions.taskRefresh(), '');
//                      showToast(context, '支付成功');
//                      pop(true);
//                      popUntil(ModalRoute.withName(
//                          LawyerTaskDetailsPage(widget.id).toStringShort()));
//                    }
//                  });
//                }),
//          )
//        ],
//      ),
    );
  }

  /// 发布者确认完成
  missionPublishConfirm() {
    missionDetailViewModel
        .missionPublishConfirm(
          context,
          id: widget.id,
        )
        .then((rep) {})
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  /// 承接者确认完成
  missionCompleted() {
    missionDetailViewModel
        .missionCompleted(
          context,
          id: widget.id,
        )
        .then((rep) {})
        .catchError((e) {
      showToast(context, e.message);
    });
  }
}
