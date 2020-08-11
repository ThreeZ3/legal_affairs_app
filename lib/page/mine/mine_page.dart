import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_model.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/home/home_qr.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_income.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_my_task_page.dart';
import 'package:jh_legal_affairs/page/mine/my_ad/my_ad_page.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/my_advisory_page.dart';
import 'package:jh_legal_affairs/page/mine/my_case/my_case_page.dart';
import 'package:jh_legal_affairs/page/mine/my_contract/by_contract_page.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_page.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_subscribe_page.dart';
import 'package:jh_legal_affairs/page/mine/my_pictures/my_pictures.dart';
import 'package:jh_legal_affairs/page/other/about_page.dart';
import 'package:jh_legal_affairs/page/wallet/wallet_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/mine_page_widget.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';
import 'package:nav_router/nav_router.dart';
import '../../data/data.dart';
import 'lawyer_idea/lawyer_idea_edit.dart';
import 'lawyer_introduction/lawyer_introduction_edit.dart';
import 'live_video/live_video_page.dart';
import 'my_contract/my_contract_page.dart';
import 'my_lawyer_details/my_lawyer_details.dart';
import 'my_lecture/my_courseware_page.dart';
import 'my_sourcecase/my_sourcecase.dart';
import 'user_reviews/user_reviews_page.dart';

/// 我的（普通用户）与 我的（律师）

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  LawyerInfoModel lawyerInfoModel = new LawyerInfoModel();

//跳转页面入口集合
  List _mineRoutePage = [
    {
      'title': '我的案源',
      'onPressed': () {
        routePush(MySourcecase(JHData.id(), '我'));
      }
    },
    {
      'title': '我的合同',
      'onPressed': () {
        routePush(JHData.userType() == '1;普通用户'
            ? new ByContractPage()
            : MyContractPage(JHData.id(), '我'));
      }
    },
    {
      'title': '我的任务',
      'onPressed': () {
        routePush(LawyerMyTaskPage(JHData.id(), '我'));
      }
    },
    {
      'title': '我的咨询',
      'onPressed': () {
        routePush(MyAdvisoryPage(JHData.id(), '我'));
      }
    },
    {
      'title': '我的图文',
      'onPressed': () {
        routePush(MyPicturesPage(JHData.id(), '我'));
      },
    },
    {
      'title': '我的课件',
      'onPressed': () {
        routePush(MyCourseWarePage(JHData.id(), '我'));
      }
    },
    {
      'title': '我的案例',
      'onPressed': () {
        routePush(MyCasePage(JHData.id(), '我'));
      }
    },
    {
      'title': '我的广告',
      'onPressed': () {
        routePush(MyAdPage(JHData.id(), '我'));
      }
    },
  ];

  @override
  void initState() {
    super.initState();
    if (JHData.userType() == '2;律师') {
      getInfo();
      getLawyerInfo();
    }
    Notice.addListener(JHActions.minePageRefresh(), (v) {
      if (JHData.userType() == '2;律师') {
        getInfo();
        getLawyerInfo();
      }
    });
  }

  Future getLawyerInfo() {
    return loginViewModel.lawyerCurInfo(context).then((rep) {
      setState(() {
        lawyerInfoModel = rep.data;
      });
    }).catchError((e) {
      print('${e.message}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.minePageRefresh());
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        leading: AppBarButton(
          buttonUrl: 'assets/images/mine/qrcode_icon@3x.png',
          onPressed: () => routePush(HomeQrPage()),
        ),
        rightDMActions: <Widget>[
          new InkWell(
            child: new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                'assets/images/mine/waller_icon.png',
                width: 22,
              ),
            ),
            onTap: () => routePush(new WalletPage()),
          ),
        ],
      ),
      body: new DataView(
        isLoadingOk: true,
        data: [0],
        onRefresh: JHData.userType() == "2;律师"
            ? () {
                getInfo();
                return getLawyerInfo();
              }
            : null,
        child: ListView(
          children: <Widget>[
            new UserHeader(
              JHData.userType() == "2;律师",
              seniority: workYearStr(lawyerInfoModel?.workYear),
              category: lawyerInfoModel?.legalField ?? [],
              rank: lawyerInfoModel?.rank ?? '0',
              realName: lawyerInfoModel?.realName,
            ),
            new Visibility(
              visible: JHData.userType() == "2;律师",
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: ThemeColors.colorDivider, width: 8.0),
                      ),
                    ),
                    child: EditInformation(
                      title: '律师理念',
                      onTapEdit: () {
                        routePush(LawyerIdeaEdit(
                          defaultText: lawyerInfoModel?.lawyerValue ?? '',
                        ));
                      },
                      infoWidget:
                          new CacheWidget(JHActions.lawyerValue(), (String v) {
                        return new Text(
                          lawyerInfoModel?.lawyerValue ?? '还没有设置嗷',
//                        JHData.lawyerValue(),
//                        !strNoEmpty(JHData.lawyerValue()) ? v : JHData.lawyerValue(),
                          style: TextStyle(color: ThemeColors.color999),
                        );
                      }),
                    ),
                  ),
                  Container(
                    child: EditInformation(
                      title: '律师简介',
                      onTapEdit: () {
                        routePush(LawyerIntroductionEdit(
                          defaultText: lawyerInfoModel?.lawyerInfo ?? '',
                        ));
                      },
                      infoWidget:
                          new CacheWidget(JHActions.lawyerInfo(), (String v) {
                        return new Text(
                          lawyerInfoModel?.lawyerInfo ?? '还没有设置嗷',
//                        JHData.lawyerInfo(),
//                        !strNoEmpty(JHData.lawyerInfo()) ? v : JHData.lawyerInfo() ,
                          style: TextStyle(color: ThemeColors.color999),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            new Visibility(
              visible: JHData.isFirmUser(),
              child: new MineListItem(
                title: '我的律所',
                isVerLine: true,
                isUpDivider: true,
                onPressed: () => routePush(MyLawFirmPage()),
              ),
            ),
            new Visibility(
              visible: JHData.userType() == "2;律师",
              child: new MineListItem(
                title: '详细资料',
                isVerLine: true,
                isUpDivider: true,
                onPressed: () => routePush(MyLawyerDetailList(JHData.id())),
              ),
            ),
            new MineListItem(
              title: '视频直播',
              isUpDivider: true,
              onPressed: () => routePush(LiveVideoPage(JHData.id())),
            ),
            new MinePageDivider(),
            new Column(
              children: _mineRoutePage.map((item) {
                String _title = item['title'];
                VoidCallback _onPressed = item['onPressed'];
                if (JHData.userType() == '1;普通用户' && item['title'] == '我的课件') {
                  return new Container();
                }
                return MineListItem(
                  title: _title,
                  onPressed: _onPressed,
                );
              }).toList(),
            ),
            new Visibility(
              visible: JHData.userType() == "2;律师",
              child: Column(
                children: <Widget>[
                  new MineListItem(
                    title: '收入统计',
                    onPressed: () => routePush(new LawyerIncome()),
                    isUpDivider: true,
                  ),
                  new MineListItem(
                    title: '用户评论',
                    onPressed: () => routePush(UserReviewsPage()),
                    isUpDivider: true,
                  ),
                ],
              ),
            ),
            new MineListItem(
              title: '我的订阅',
              onPressed: () => routePush(new MySubscribePage(JHData.id())),
            ),
            new MineListItem(
              title: '关于我们',
              onPressed: () => routePush(new AboutPage()),
              isUpDivider: true,
            ),
            new MineListItem(
              title: '退出登录',
              onPressed: () => authToken(),
              isUpDivider: true,
            ),
          ],
        ),
      ),
    );
  }

  authToken() {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定退出当前登录？',
      okFunction: () {
//        loginViewModel.oauthToken(context).then((rep) {
//        }).catchError((e) {
//          showToast(context, e.message);
//        });
        JHData.clean();
      },
      cancelFunction: () {},
    );
  }

  void getInfo() {
    loginViewModel.getInfo(context, isUpdateStatus: true).catchError((e) {});
  }

//  @override
//  bool get wantKeepAlive => lawyerInfoModel != null;
}
