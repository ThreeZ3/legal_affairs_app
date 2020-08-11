import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/home/home_ranking_widget.dart';
import 'package:jh_legal_affairs/page/law_firm/case_studies.dart';
import 'package:jh_legal_affairs/page/law_firm/details/consultant_contract_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/consulting_the_listing_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/share_diabetes_mellitus_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/task_list_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/the_lawyer_talents_page.dart';
import 'package:jh_legal_affairs/page/law_firm/study_courseware.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'add_member.dart';

///确认加入律所页面
class ReallyAddFirmPage extends StatefulWidget {
  final String id;
  final String firmId;

  ReallyAddFirmPage({
    Key key,
    this.id,
    this.firmId,
  }) : super(key: key);

  @override
  _ReallyAddFirmPageState createState() => _ReallyAddFirmPageState();
}

class _ReallyAddFirmPageState extends State<ReallyAddFirmPage> {
  @override
  void initState() {
    getFirmDetails(context);
    super.initState();
  }

  FirmDetailsInfoModel model = new FirmDetailsInfoModel();
  bool isLoadingOk = false;

  Future getFirmDetails(context) async {
    await firmViewModel.viewFirmInfo(context, id: widget.firmId).then((rep) {
      print(rep);
      setState(() {
        model = rep.data;
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  Future firmInviteHandle(int mode) async {
    await firmViewModel
        .firmInviteHandle(
          context,
          id: widget.id,
          mode: mode,
        )
        .catchError(
          (e) => showToast(context, e.message),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: "律所详情",
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () => firmInviteHandle(-1),
                child: _rightBtn(context, false)),
            InkWell(
                onTap: () => firmInviteHandle(1),
                child: _rightBtn(context, true)),
          ],
        ),
      ),
      body: DataView(
        isLoadingOk: isLoadingOk,
        data: [" "],
        onRefresh: () => getFirmDetails(context),
        child: ListView(
          children: <Widget>[
            _firmHead(context),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _firmName(model.firmName ?? " "),
                  _title("业务类别"),
                  _labels(model.legalField),
                  _title("律所理念"),
                  _richText(model.firmValue ?? " "),
                  _title("律所简介"),
                  _richText(model.firmInfo ?? " "),
                ],
              ),
            ),
            new Space(),
//            Container(
//              margin: EdgeInsets.symmetric(vertical: 12),
//              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
//              color: Colors.white,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  _title("详细资料"),
//                  Icon(
//                    Icons.arrow_drop_down_circle,
//                    size: 23,
//                  )
//                ],
//              ),
//            ),
            _firmMessage(),
          ],
        ),
      ),
    );
  }

  Widget _rightBtn(context, bool isRight) {
    return Container(
      height: 44,
      decoration:
          BoxDecoration(color: isRight ? themeMainColor : lightGrayColor),
      width: winWidth(context) / 2 - 26,
      alignment: Alignment.center,
      child: Text(
        isRight ? "加入" : "拒绝",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isRight ? Colors.white : Colors.red),
      ),
    );
  }

  Widget _firmMessage() {
    return Column(
      children: <Widget>[
        FirmListBuild(
            text: '律所人才',
            onTap: () => routePush(new TheLawyerTalentsPage(widget.firmId))),
        FirmListBuild(
            text: '案源共享',
            onTap: () =>
                routePush(new ShareDiabetesMellitusPage(widget.firmId, false))),
        FirmListBuild(
          text: '顾问合同',
          onTap: () =>
              routePush(new ConsultantContractPage(widget.firmId, false)),
        ),
        FirmListBuild(
          text: '任务列表',
          onTap: () => routePush(new TaskListPage(widget.firmId, false)),
        ),
        FirmListBuild(
          text: '咨询清单',
          onTap: () =>
              routePush(new ConsultingTheListingPage(widget.firmId, false)),
        ),
        FirmListBuild(
          text: '图文资讯',
          onTap: () => routePush(new AllConsultPage(false, widget.firmId)),
        ),
        FirmListBuild(
          text: '学习课件',
          onTap: () => routePush(new StudyCourseWare(widget.firmId, false)),
        ),
        FirmListBuild(
          text: '案例分享',
          onTap: () => routePush(new CaseStudies(widget.firmId, false)),
        ),
        new Space(height: 80),
      ],
    );
  }

  Widget _title(String title) {
    return Container(
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: themeMainColor))),
      padding: EdgeInsets.only(left: 2),
      margin: EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _richText(String context) {
    return Text(
      context,
      style: TextStyle(fontSize: 12, color: themeGrayColor),
    );
  }

  Widget _label(String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: lightGrayColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      child: Text(
        "$label",
        style: TextStyle(fontSize: 12, color: themeMainColor),
      ),
    );
  }

  Widget _labels(List list) {
    if (listNoEmpty(list)) {
      return Wrap(
        spacing: 16,
        runSpacing: 8,
        children: list.map((v) {
          NewCategoryModel model = v;

          return _label(model?.name ?? '未知');
        }).toList(),
      );
    } else {
      return Container();
    }
  }

  Widget _firmName(String name) {
    return Text(
      name,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _firmHead(context) {
    return Stack(
      children: <Widget>[
        Image.network(
          model.firmAvatar ?? NETWORK_IMAGE,
          width: winWidth(context),
          height: 148,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 16,
          top: 16,
          child: HomeRankingWidget(name: model.rank.toString() ?? "0"),
        )
      ],
    );
  }
}

class FirmListBuild extends StatelessWidget {
  final String text;
  final Function onTap;

  const FirmListBuild({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.all(0),
          title: Text(text),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 18,
          ),
        ));
  }
}
