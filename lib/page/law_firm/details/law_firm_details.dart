import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/law_firm/case_studies.dart';
import 'package:jh_legal_affairs/page/law_firm/details/consulting_the_listing_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/share_diabetes_mellitus_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/task_list_page.dart';
import 'package:jh_legal_affairs/page/law_firm/study_courseware.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/complaint_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_accusation_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:nav_router/nav_router.dart';
import 'the_lawyer_talents_page.dart';
import 'consultant_contract_page.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-23
///
/// 律所详情
///
class LawFirmDetailsPage extends StatefulWidget {
  final String id;
  final int rank;

  LawFirmDetailsPage(this.id, this.rank);

  @override
  _LawFirmDetailsPageState createState() => _LawFirmDetailsPageState();
}

class _LawFirmDetailsPageState extends State<LawFirmDetailsPage> {
  List newLabelList = ['民商11', '刑事11', '资本101', '公益11'];
  String textOfficialLetter = "";
  bool isShow = false;
  ViewMyFirmDetailModel allInfo = new ViewMyFirmDetailModel();

  FirmDetailsInfoModel model = new FirmDetailsInfoModel();

  @override
  void initState() {
    super.initState();
    getAllDetailsInfo();
    firmClick();
    Notice.addListener(
        JHActions.lawFirmDetailsPageRefresh(), (v) => getAllDetailsInfo());
  }

  firmClick() => firmViewModel.firmClick(context, widget.id);

  getAllDetailsInfo() {
    firmViewModel
        .viewFirmDetails(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        allInfo = rep.data;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
    firmViewModel
        .viewFirmInfo(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        model = rep.data;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.lawFirmDetailsPageRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: new NavigationBar(title: '律所详情'),
      body: strNoEmpty(model?.firmName)
          ? ListView(
              children: <Widget>[
                HorizontalLinee(), //间隔条
                Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: new InkWell(
                        child: new Hero(
                          tag: 'avatar${model?.firmAvatar}${model?.id}',
                          child: strNoEmpty(model?.firmAvatar)
                              ? CachedNetworkImage(
                                  imageUrl: model?.firmAvatar,
                                  fit: BoxFit.cover,
                                  height: 148)
                              : Image.asset(avatarLawFirm,
                                  fit: BoxFit.cover, height: 148),
                        ),
                        onTap: () => strNoEmpty(model?.firmAvatar)
                            ? routePush(
                                new HeroAnimationRouteB(
                                    model?.firmAvatar, model?.id),
                                RouterType.fade)
                            : () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 16, top: 16),
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      child:
                          IconBox(text: '排名', number: '${widget.rank ?? '未知'}'),
                    ),
                  ],
                ), //律所logo
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        routePush(!JHData.isLogin()
                            ? new LoginPage()
                            : new ComplaintPage(id: widget.id, type: 2));
                      },
                      child: Container(
                          height: 70,
                          width: winWidth(context) / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Space(height: 12),
                              Image.asset(
                                "assets/images/lawyer/tell.png",
                                height: 22,
                              ),
                              Space(height: 4),
                              Text(
                                '投诉(${model?.complaintCount ?? "0"})',
                                style: TextStyle(color: THEME_COLOR),
                              ),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () => routePush(!JHData.isLogin()
                          ? new LoginPage()
                          : new AccusationPage(id: widget.id, type: 2)),
                      child: Container(
                          height: 70,
                          width: winWidth(context) / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Space(height: 12),
                              Image.asset(
                                "assets/images/lawyer/report.png",
                                height: 22,
                              ),
                              Space(height: 4),
                              Text(
                                '举报(${model?.accusationCount ?? "0"})',
                                style: TextStyle(color: THEME_COLOR),
                              ),
                            ],
                          )),
                    ),
                  ],
                ), //举报与投诉
                HorizontalLinee(), //间隔条
                Container(
                  color: Color(0xffFFFFFE),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${model?.firmName ?? '未知'}',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ), //律所名
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
//                    Navigator.of(context)
//                        .push(
//                      MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              LawFirmCategoryPage()),
//                    )
//                        .then((value) {
//                      if (!listNoEmpty(value)) return;
//                      setState(() {
//                        newLabelList = value;
//                        print(newLabelList);
//                      });
//                    });
                        },
                        child: Column(
                          children: <Widget>[
//                            Entry(text: '业务类别'),
//                            SizedBox(height: 9),
                            model.legalField.isEmpty
                                ? Container()
                                : Container(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: List.generate(
                                          model.legalField.length, (index) {
                                        NewCategoryModel inModel =
                                            model.legalField[index];
                                        return LabelBox(
                                          text: inModel?.name ?? '未知',
                                        );
                                      }),
                                    ),
                                  ),
                          ],
                        ),
                      ), //业务类别
                      SizedBox(height: 16),
                      //律所理念
                      InkWell(
                        onTap: () {
//                    Navigator.of(context).push(
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return LawFirmConceptSettingPage();
//                      }),
//                    ).then((value) {
//                    });
                        },
                        child: Column(
                          children: <Widget>[
                            Entry(text: '律所理念'),
                            SizedBox(height: 9),
                            TextModule(
                              text: '${model?.firmValue ?? '未知'}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      //律所简介
                      InkWell(
                        onTap: () {
//                    Navigator.of(context).push(
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return LawFirmIntroducePage();
//                      }),
//                    ).then((value) {
//                    });
                        },
                        child: Column(
                          children: <Widget>[
                            Entry(text: '律所简介'),
                            SizedBox(height: 9),
                            TextModule(
                              text: '${model?.firmInfo ?? '未知'}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                HorizontalLine(), //间隔条
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 13),
                  child: Entry(
                    text: '详细资料',
                    icon: isShow == true
                        ? IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Image.asset(ARROWUPPIC),
                            onPressed: () {
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                          )
                        : IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Image.asset(ARROWDOWNPIC),
                            onPressed: () {
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                          ),
                  ),
                ),
                isShow == true
                    ? Container(
                        padding: EdgeInsets.only(left: 13),
                        child: Column(
                          children: <Widget>[
                            IconTitleTileWidget(
                              title: '律所地址',
                              editIconUrlTwo: null,
                            ),
                            SizedBox(height: 8),
                            TextModule(text: '${model?.address ?? '未知'}'),
                            SizedBox(height: 16),
                            lawFirmWidget(
                              title: '律所电话',
                              list: allInfo?.mobile ?? [],
                              type: '电话',
                            ), //律所电话
                            SizedBox(height: 16),
                            lawFirmWidget(
                              title: '律所微信',
                              list: allInfo?.wechat ?? [],
                              type: '微信',
                            ), //律所微信
                            SizedBox(height: 16),
                            lawFirmWidget(
                              title: '律所邮箱',
                              list: allInfo?.email ?? [],
                              type: '邮箱',
                              widgetWidth:
                                  (MediaQuery.of(context).size.width - 46) / 2,
                            ), //律所邮箱
                            SizedBox(height: 16),
                            webPublicWidget(), //网址、公众号
                            SizedBox(height: 24),
                            lawyerFirmPic(), //律所照片
                            SizedBox(height: 24),
                            socialHonor(), //社会荣誉
                            SizedBox(height: 24),
                            credentials(), //资质证明
                            SizedBox(height: 24),
                            officialLetter(), //律所公函
                          ],
                        ),
                      )
                    : Container(),
                HorizontalLine(),
                EntryIcon(
                    text: '律所人才',
                    onTap: () =>
                        routePush(new TheLawyerTalentsPage(widget.id))),
                EntryIcon(
                    text: '案源共享',
                    onTap: () => routePush(
                        new ShareDiabetesMellitusPage(widget.id, false))),
                EntryIcon(
                  text: '顾问合同',
                  onTap: () =>
                      routePush(new ConsultantContractPage(widget.id, false)),
                ),
                EntryIcon(
                  text: '任务列表',
                  onTap: () => routePush(new TaskListPage(widget.id, false)),
                ),
                EntryIcon(
                  text: '咨询清单',
                  onTap: () =>
                      routePush(new ConsultingTheListingPage(widget.id, false)),
                ),
                EntryIcon(
                  text: '图文资讯',
                  onTap: () => routePush(new AllConsultPage(false, widget.id)),
                ),
                EntryIcon(
                  text: '学习课件',
                  onTap: () => routePush(new StudyCourseWare(widget.id, false)),
                ),
                EntryIcon(
                  text: '案例分享',
                  onTap: () => routePush(new CaseStudies(widget.id, false)),
                ),
              ],
            )
          : new LoadingView(),
    );
  }

  Widget lawFirmWidget(
      {String title,
      List list = const [],
      String type,
      double widgetWidth,
      Widget routerPage}) {
    double width = (MediaQuery.of(context).size.width - 60) / 3;
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '$title',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          child: list.length > 0
              ? Wrap(
                  spacing: 14,
                  runSpacing: 4,
                  children: list.map((index) {
                    return new InkWell(
                      child: Container(
                        width: widgetWidth != null ? widgetWidth : width,
                        child: Text(
                          '${index?.title ?? '暂无数据'} ${index?.value ?? ''}',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                      onTap: () => launchTel(context, index?.value),
                    );
                  }).toList())
              : GreyText(text: '暂无数据'),
        )
      ],
    );
  }

  //律所网址、律所公众号
  Widget webPublicWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律所网址',
                editIconUrlTwo: null,
              ),
              SizedBox(height: 8),
              GreyText(
                text:
                    '${listNoEmpty(allInfo?.website ?? []) ? allInfo?.website[0].value ?? '暂无数据' : '暂无数据'}',
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律所公众号',
                editIconUrlTwo: null,
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(allInfo?.officialAccounts ?? []) ? allInfo?.officialAccounts[0].value ?? '暂无数据' : '暂无数据'}')
            ],
          ),
        ),
      ],
    );
  }

  //律所照片
  Widget lawyerFirmPic() {
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '律所照片',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(List.from(allInfo?.photo ?? []))
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: List.from(allInfo?.photo ?? []).map((index) {
                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            new Hero(
                              tag: 'avatar${index.value}${index.id}',
                              child: CachedNetworkImage(
                                imageUrl: '${index.value}',
                                fit: BoxFit.fill,
                                width: 180,
                              ),
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${index.title ?? '未知标题'}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () => routePush(
                          new HeroAnimationRouteB(index.value, index.id),
                          RouterType.fade),
                    );
                  }).toList(),
                )
              : new Text('暂无照片'),
        ),
      ],
    );
  }

  //社会荣誉
  Widget socialHonor() {
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '社会荣誉',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(List.from(allInfo?.spocialhonor ?? []))
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: List.from(allInfo?.spocialhonor ?? []).map((index) {
                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            new Hero(
                              tag: 'avatar${index.value}${index.id}',
                              child: CachedNetworkImage(
                                imageUrl: '${index.value}',
                                fit: BoxFit.fill,
                                width: 180,
                              ),
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${index.title}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () => routePush(
                          new HeroAnimationRouteB(index.value, index.id),
                          RouterType.fade),
                    );
                  }).toList(),
                )
              : new Text('暂无数据'),
        ),
      ],
    );
  }

  //资质证明
  Widget credentials() {
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '资质证明',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(List.from(allInfo?.qualification ?? []))
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children:
                      List.from(allInfo?.qualification ?? []).map((index) {
                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            new Hero(
                              tag: 'avatar${index.value}${index.id}',
                              child: CachedNetworkImage(
                                imageUrl: '${index.value}',
                                fit: BoxFit.fill,
                                width: 180,
                              ),
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${index.title}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () => routePush(
                          new HeroAnimationRouteB(index.value, index.id),
                          RouterType.fade),
                    );
                  }).toList(),
                )
              : new Text('暂无数据'),
        ),
      ],
    );
  }

  //律所公函
  Widget officialLetter() {
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '律所公函',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        listNoEmpty(List.from(allInfo?.missive ?? []))
            ? new InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(right: 16, bottom: 12),
                  child: new Hero(
                    tag:
                        'avatar${allInfo.missive[0].value}${allInfo.missive[0].id}',
                    child: CachedNetworkImage(
                        imageUrl: allInfo.missive[0].value, fit: BoxFit.cover),
                  ),
                ),
                onTap: () => routePush(
                    new HeroAnimationRouteB(
                        allInfo.missive[0].value, allInfo.missive[0].id),
                    RouterType.fade),
              )
            : new Text('暂无数据'),
      ],
    );
  }
}
