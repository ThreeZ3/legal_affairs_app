import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/bid/bid_view_model.dart';
import 'package:jh_legal_affairs/api/source/case_source_model.dart';
import 'package:jh_legal_affairs/api/source/case_source_view_model.dart';
import 'package:jh_legal_affairs/api/task/mission_detail_model.dart';
import 'package:jh_legal_affairs/api/task/mission_detail_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_undertake_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class SourceCaseBidDetail extends StatefulWidget {
  final String id;
  final String advantage;
  final TakeType type;
  final String realName;
  final String modelId;

  SourceCaseBidDetail(
      this.id, this.advantage, this.type, this.realName, this.modelId);

  @override
  _SourceCaseBidDetailState createState() => _SourceCaseBidDetailState();
}

class _SourceCaseBidDetailState extends State<SourceCaseBidDetail> {
  SourceCaseDetails sourceCaseDetails = new SourceCaseDetails();
  MissionDetailModel missionDetailModel = new MissionDetailModel();

  @override
  void initState() {
    super.initState();
    widget.type == TakeType.missions ? getMissionDetail() : sourceCaseDetail();
  }

  /// 获取任务详情
  Future getMissionDetail() async {
    missionDetailViewModel
        .missionDetail(
      context,
      widget.id,
    )
        .then((rep) {
      setState(() {
        missionDetailModel = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  sourceCaseDetail() {
    caseSourceViewModel
        .sourceCaseDetails(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        sourceCaseDetails = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    List data;
    if (widget.type == TakeType.sourceCase) {
      String statusStr = strNoEmpty(sourceCaseDetails?.status)
          ? sourceCaseDetails.status.split(";")[1]
          : '未知';
      data = [
        new CaseModel('案源标题', '${sourceCaseDetails?.title ?? '未知'}'),
        new CaseModel('竞价者', '${widget.realName}'),
        new CaseModel('业务类别', '${sourceCaseDetails?.categoryName ?? '未知'}'),
        new CaseModel('执行情况', '$statusStr'),
        new CaseModel('时限', '${sourceCaseDetails?.limited ?? '未知'}天'),
        new CaseModel('案值',
            '¥ ${strNoEmpty(sourceCaseDetails?.value.toString()) ? formatNum(sourceCaseDetails?.value) : '未知'}'),
        new CaseModel('律师费报价',
            '¥ ${strNoEmpty(sourceCaseDetails?.fee.toString()) ? formatNum(sourceCaseDetails?.fee) : '未知'}'),
        new CaseModel('竞争优势', '${widget.advantage ?? '未知'}'),
      ];
    } else {
      String statusStr = strNoEmpty(missionDetailModel?.status)
          ? missionDetailModel.status.split(";")[1]
          : '未知';
      data = [
        new CaseModel('任务标题', '${missionDetailModel?.title ?? '未知'}'),
        new CaseModel('竞价者', '${widget?.realName ?? '未知'}'),
        new CaseModel('业务类别', '${missionDetailModel?.categoryName ?? '未知'}'),
        new CaseModel('执行情况', '$statusStr'),
        new CaseModel('时限', '${missionDetailModel?.limit ?? '未知'}天'),
        new CaseModel('案值', '¥ ${missionDetailModel?.ask ?? '未知'}'),
        new CaseModel('竞争优势', '${widget.advantage ?? '未知'}'),
      ];
    }

    return new Scaffold(
      appBar: new NavigationBar(title: '竞价详情'),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
              children: data.map((item) {
                return ItemView(item);
              }).toList(),
            ),
          ),
          (JHData.id() == (sourceCaseDetails?.lawyerId ?? '未知') ||
                      (missionDetailModel?.own ?? false)) &&
                  !sourceCaseDetails.status.startsWith("2")
              ? new SmallButton(
                  child: new Text('选用该竞价'),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  minWidth: winWidth(context) - 32,
                  onPressed: () {
                    themeAlert(
                      context,
                      okBtn: '确认',
                      cancelBtn: '取消',
                      warmStr: '您确认选用该竞价？',
                      okFunction: () {
                        widget.type == TakeType.sourceCase
                            ? selectSourceCase()
                            : selectMission();
                      },
                      cancelFunction: () {},
                    );
                  },
                )
              : new Container()
        ],
      ),
    );
  }

  selectSourceCase() {
    bidViewModel
        .sourceCaseBidSelect(
      context,
      id: widget.modelId,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  selectMission() {
    bidViewModel
        .missionsBidSelect(
      context,
      id: widget.id,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }
}
