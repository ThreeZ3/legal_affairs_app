import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/law_firm/case_studies.dart';
import 'package:jh_legal_affairs/page/law_firm/details/consultant_contract_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/consulting_the_listing_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/share_diabetes_mellitus_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/task_list_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/the_lawyer_talents_page.dart';
import 'package:jh_legal_affairs/page/law_firm/income_statistics.dart';
import 'package:jh_legal_affairs/page/law_firm/study_courseware.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_authority_management_page.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_setting_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';
import 'my_law_firm_application_list_page.dart';

///我的律所词条列表
class MyLawFirmDetailList extends StatefulWidget {
  final MyFirmModel data;

  const MyLawFirmDetailList({Key key, this.data}) : super(key: key);
  @override
  _MyLawFirmDetailListState createState() => _MyLawFirmDetailListState();
}

class _MyLawFirmDetailListState extends State<MyLawFirmDetailList> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _mineRoutePage.map((item) {
        String _title = item['title'];
        return _title == '详细资料' || _title == '管理权限' || _title == '申请列表'
            ? _title == '申请列表'
                ? Visibility(
                    visible: JHData.firmAdminType() == 0,
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: IconTitleTileWidget(
                          title: _title,
                          editIconUrlTwo:
                              'assets/images/mine/right_arrow_icon.png',
                          fontSize: 14,
                          iconSize: 8,
                        ),
                      ),
                      onTap: () => pageRouter(_title),
                    ),
                  )
                : InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(16),
                      color: Colors.white,
                      child: IconTitleTileWidget(
                        title: _title,
                        editIconUrlTwo:
                            'assets/images/mine/right_arrow_icon.png',
                        fontSize: 14,
                        iconSize: 8,
                      ),
                    ),
                    onTap: () => pageRouter(_title),
                  )
            : Container(
                margin: _title == '案例分享' ? EdgeInsets.only(bottom: 10) : null,
                color: Colors.white,
                child: EntryIcon(
                  text: _title,
                  onTap: () => pageRouter(_title),
                ),
              );
      }).toList(),
    );
  }

  pageRouter(String router) {
    switch (router) {
      case '详细资料':
        routePush(MyLawFirmSettingDetailsPage(id: widget.data.id));
        break;
      case '管理权限':
        routePush(MyLawAuthorityManagementPage());
        break;
      case '申请列表':
        routePush(MyLawFirmApplicationListPage());
        break;
      case '律师人才':
        routePush(TheLawyerTalentsPage(widget.data.id));
        break;
      case '案源共享':
        routePush(ShareDiabetesMellitusPage(widget.data.id, true));
        break;
      case '顾问合同':
        routePush(ConsultantContractPage(widget.data.id, true));
        break;
      case '任务列表':
        routePush(TaskListPage(widget.data.id, true));
        break;
      case '咨询清单':
        routePush(ConsultingTheListingPage(widget.data.id, true));
        break;
      case '图文资讯':
        routePush(AllConsultPage(true, widget.data.id));
        break;
      case '学习课件':
        routePush(StudyCourseWare(widget.data.id, true));
        break;
      case '案例分享':
        routePush(CaseStudies(widget.data.id, true));
        break;
      case '收入统计':
        routePush(IncomeStatistics(
          id: widget.data.id,
          data: widget.data,
        ));
        break;
    }
  }

  List _mineRoutePage = [
    {'title': '详细资料'},
    {'title': '管理权限'},
    {'title': '申请列表'},
    {'title': '律师人才'},
    {'title': '案源共享'},
    {'title': '顾问合同'},
    {'title': '任务列表'},
    {'title': '咨询清单'},
    {'title': '图文资讯'},
    {'title': '学习课件'},
    {'title': '案例分享'},
    {'title': '收入统计'},
  ];
}
