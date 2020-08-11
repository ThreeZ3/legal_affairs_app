import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/api/home/home_consults_model.dart';
import 'package:jh_legal_affairs/api/home/home_consults_view_model.dart';
import 'package:jh_legal_affairs/api/home/home_law_firm_model.dart';
import 'package:jh_legal_affairs/api/home/home_law_firm_view_model.dart';
import 'package:jh_legal_affairs/api/home/home_new_mission_model.dart';
import 'package:jh_legal_affairs/api/home/home_new_mission_view_model.dart';
import 'package:jh_legal_affairs/api/home/homepage_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/api/video/video_view_model.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/home/all_video_page.dart';
import 'package:jh_legal_affairs/page/home/home_empty_page.dart';
import 'package:jh_legal_affairs/page/home/home_label_widget.dart';
import 'package:jh_legal_affairs/page/home/home_law_firm.dart';
import 'package:jh_legal_affairs/page/home/home_lawyer_list.dart';
import 'package:jh_legal_affairs/api/home/home_new_view_model.dart';
import 'package:jh_legal_affairs/api/home/homepage_view_model.dart';
import 'package:jh_legal_affairs/page/home/home_qr.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_task_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/advisory_details_page.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_course_ware_details_lawyer_page.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  ScrollController controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  //bannner数组
  List<AdSysModel> bannerList = [];

  //课件数组
  List<dynamic> courseWareList = [];

//律师列表数组
  List lawyersList = new List();

  //最新资讯数组
  List<dynamic> consultList;

//资讯数组
  List<dynamic> informationList;

//事务所数组
  List<HomeLawFirmRequestModel> lawyerFirmList = [];

  //最新视频数组
  List<dynamic> newVideoList = [];

  //最新任务
  List<dynamic> missionList;
  bool isLoadingOk = false;
  int page = 1;

  Future getHomeData() async {
    ///首页广告
    await adViewModel.adSys(context, type: 1).then((rep) {
      setState(() => bannerList = List.from(rep.data));
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求最新任务
    await HomeNewMissionViewModel()
        .getNewMissionData(context)
        .then((ResponseModel rep) {
      setState(() => missionList = rep.data);
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求资讯
    await HomeInformationViewModel()
        .getInformationData(context)
        .then((ResponseModel rep) {
      setState(() => informationList = rep.data);
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求最新视频
    await videoViewModel.getHomeVideoList(context).then((v) {
      setState(() => newVideoList = v.data);
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求事务所
    await HomeLawFirmViewModel()
        .getLawFirmData(context)
        .then((ResponseModel rep) {
      setState(() {
        HomeFirmsModel homeFirmsModel = rep.data;
        lawyerFirmList = homeFirmsModel.data;
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求律师列表
    await lawyerViewModel.lawyerList(context).then((rep) {
      setState(() => lawyersList = rep.data);
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求最新资讯
    await HomeNewConsultRequestViewModel()
        .getNewConsultData(context)
        .then((ResponseModel rep) {
      setState(() => consultList = rep.data);
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });

    ///请求课件
    await getHomeCourseWareData();

    ///请求是否有邀请
    await HomeNewMissionViewModel()
        .firmInvite(
      context,
    )
        .catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  ///请求课件
  Future getHomeCourseWareData() async {
    await HomeCourseWareRequestViewModel()
        .getCourseWareData(context, page: page, limit: 10)
        .then((ResponseModel rep) {
      setState(() {
        if (page == 1) {
          courseWareList = List.from(rep.data);
        } else {
          courseWareList.addAll(List.from(rep.data));
        }
      });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getHomeData();
    Notice.addListener(JHActions.homeRefresh(), (v) {
      getHomeData();
    });
    //监听滚动事件
    controller.addListener(() {
      if (controller.offset < MediaQuery.of(context).size.height &&
          showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (controller.offset >= MediaQuery.of(context).size.height &&
          showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: NavigationBar(
        title: "首页",
        leading: Container(
          padding: EdgeInsets.all(4.0),
          child: new IconButton(
              icon: new Image.asset('assets/images/mine/qrcode_icon@3x.png'),
              onPressed: () =>
                  routePush(JHData.isLogin() ? HomeQrPage() : LoginPage())),
        ),
        rightDMActions: <Widget>[
          new Container(
            padding: EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Image.asset('assets/images/mine/message_icon@3x.png'),
              onPressed: () => routerIm(context),
            ),
          ),
        ],
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              backgroundColor: themeColor,
              elevation: 0,
              tooltip: '返回顶部',
              child: new Icon(CupertinoIcons.up_arrow),
              onPressed: () {
                controller.animateTo(
                  0,
                  duration: new Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
            ),
      body: DataView(
        data: lawyerFirmList,
        isLoadingOk: isLoadingOk,
        onRefresh: () {
          page = 1;
          return getHomeData();
        },
        onLoad: () {
          page++;
          return getHomeCourseWareData();
        },
        noDataView: HomeEmptyPage(controller),
        child: ListView(
          controller: controller,
          children: <Widget>[
            BannerPic(
              bannerList: bannerList,
            ),

            ///最新任务
            listNoEmpty(missionList)
                ? HomeMissionBuild(
                    data: missionList[0],
                  )
                : Container(),
            SizedBox(height: 7),
            //最新资讯
            listNoEmpty(informationList)
                ? NewsBuild(data: informationList[0])
                : Container(),
            SizedBox(height: 7),
            //最新视频
            new InkWell(
              child: new Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                child: BuildHeadWidget(title: "最新视频"),
              ),
              onTap: () => routePush(new AllVideoPage()),
            ),
            listNoEmpty(newVideoList)
                ? LiveBroadcastBuild(list: newVideoList)
                : Container(),
            //首页推荐事务所列表-
            Container(
              color: Colors.white,
              child: Column(
                children: List.generate(lawyerFirmList.length, (index) {
                  return HomeLawFirm(
                    data: lawyerFirmList[index],
                  );
                }),
              ),
            ),
            SizedBox(height: 7),
            //首页律师推荐列表
            Container(
              color: Colors.white,
              child: Column(
                children: List.generate(lawyersList.length, (index) {
                  return HomeLawyerList(
                    data: lawyersList[index],
                  );
                }),
              ),
            ),
            SizedBox(height: 7),

            //资讯
            !listNoEmpty(consultList)
                ? Container()
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    child: Column(
                      children: <Widget>[
                        new InkWell(
                          child: BuildHeadWidget(title: "法律资讯"),
                          onTap: () => routePush(new AllConsultPage(false)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(consultList.length, (index) {
                            return GraphicInformationItem(
                              data: consultList[index],
                              horizontal: 0,
                              isBorder: index != consultList.length - 1,
                            );
                          }),
                        )
                      ],
                    ),
                  ),
            SizedBox(height: 7),
            //课件
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 7,
              ),
              child: Column(
                children: <Widget>[
                  BuildHeadWidget(
                    title: "普法课堂",
                    showRightBtn: false,
                  ),
                  new Space(),
                  !listNoEmpty(courseWareList)
                      ? Container()
                      : Column(
                          children: courseWareList.map((v) {
                            return CourseWareListBuild(data: v);
                          }).toList(),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => listNoEmpty(lawyerFirmList);
}

//轮播图
class BannerPic extends StatelessWidget {
  final List bannerList;

  const BannerPic({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _banHeight = (winWidth(context) - 32) * 0.52;

    return Container(
      height: _banHeight + 30,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            height: 114,
            color: ThemeColors.color333,
          ),
          Container(
            height: _banHeight + 18,
            width: winWidth(context),
            margin: EdgeInsets.only(top: 16),
            child: Swiper(
              itemCount: listNoEmpty(bannerList)
                  ? bannerList.length
                  : defBanner.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 18),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: ThemeColors.color333,
                        blurRadius: 20,
                        offset: Offset(0, -30),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: listNoEmpty(bannerList)
                        ? CachedNetworkImage(
                            imageUrl: bannerList[index].contentUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            defBanner[index].contentUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
              onTap: (index) {
                if (listNoEmpty(bannerList)) {
                  launchURL(context, bannerList[index].urls);
                } else {
                  routePush(
                    new VideoPlayPage(
                      defBanner[index].urls,
                      null,
                      null,
                    ),
                  );
                }
              },
              pagination: SwiperPagination(
                margin: EdgeInsets.only(top: 10),
                builder: DotSwiperPaginationBuilder(
                  space: 2,
                  size: 6,
                  color: Color(0xff797979),
                  activeSize: 6,
                  activeColor: Color(0xFFC1994E),
                ),
              ),
              autoplayDisableOnInteraction: true,
            ),
          )
        ],
      ),
    );
  }
}

///认领   任务
class HomeMissionBuild extends StatelessWidget {
  final HomeMissionModel data;

  const HomeMissionBuild({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 14, bottom: 10, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: winWidth(context) - 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data?.title ?? "标题",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "地点：${data?.province ?? "未知省"} ${data?.city ?? "未知市"} ${data?.district ?? "未知区"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff999999),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "时限：${data.limit.toString()}天",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "￥${formatNum(data?.ask)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17),
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                      color: Color(0xffE1B96B),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "认领",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () => routePush(new LawyerTaskDetailsPage(data?.id ?? '0')),
    );
  }
}

///最新资讯组件
class NewsBuild extends StatelessWidget {
  final HomeInformationRecords data;

  NewsBuild({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 14, bottom: 10, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: strNoEmpty(data?.issuerAvatar)
                            ? CachedNetworkImage(
                                imageUrl: data?.issuerAvatar,
                                width: 37,
                                height: 37,
                                fit: BoxFit.cover,
                              )
                            : new Image.asset(
                                avatarLawyerMan,
                                width: 37,
                                height: 37,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    data?.title ?? '未知标题',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "￥${formatNum(data?.totalAsk)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: <Widget>[
                                HomeLabelWidget(
                                  name: data?.categoryName ?? '未知',
                                  rank: '',
                                ),
                                Text(
                                  '${data?.province ?? '未知省'} ${data?.city ?? '未知市'} ${data?.district ?? '未知区'}',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff999999)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: EditRichShowText(json: data?.content),
                      ),
                      new Space(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        decoration: BoxDecoration(
                            color: Color(0xffE1B96B),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "抢答",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => routePush(new AdvisoryDetailsPage(data.id)),
    );
  }
}

//课件组件
class CourseWareListBuild extends StatelessWidget {
  final HomeLecturesModel data;

  CourseWareListBuild({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: data?.cover ??
                  data?.lawyerAvatar ??
                  "http://www.flutterj.com/content/templates/emlog_dux/images/random/1.jpg",
              width: winWidth(context),
              height: 194,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            data?.title ?? "暂无标题",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            data?.content ?? "暂无介绍",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xff999999),
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${(double.parse(stringDisposeWithDouble(data.charges)) == 0.0) || (data?.isCharge ?? 1) == 0 ? "免费" : "￥" + formatNum(data.charges)}",
//                "￥${double.parse(data?.charges?.toString() ?? '0.0').toStringAsFixed(4)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              InkWell(
//                onTap: () => routePush(LawyerMyCourseWareDetailsPage(
//                  id: data.id,
//                )),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 1),
                  decoration: BoxDecoration(
                    color: Color(0xffE1B96B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "立即学习",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          )
        ],
      ),
      onTap: () => routePush(new LawyerMyCourseWareDetailsPage(
        id: data.id,
        price: data.charges,
      )),
    );
  }
}

///标签
class LabelWidget extends StatelessWidget {
  final String name;

  const LabelWidget({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
            color: Color(0xffF0F0F0), borderRadius: BorderRadius.circular(5)),
        child: Text(
          "$name",
          style: TextStyle(
            color: Color(0xffE1B96B),
            fontSize: 12,
          ),
        ));
  }
}

//直播组件
class LiveBroadcastBuild extends StatelessWidget {
  final List list;

  const LiveBroadcastBuild({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double picWidth = (winWidth(context) - 52) / 3;
    return Container(
      width: winWidth(context),
      height: 145,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => routePush(
                new VideoPlayPage(list[index].dataUrl, list[index], list)),
            child: Container(
              margin: EdgeInsets.only(right: 12),
              width: picWidth,
              height: 121,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 121,
                    width: picWidth,
                    child: CachedNetworkImage(
                      imageUrl: list[index]?.cover ?? userDefaultAvatarOld,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 121,
                    width: picWidth,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/home/play.png",
                      width: 33,
                      height: 33,
                    ),
                  ),
//                  Positioned(
//                    right: 0,
//                    child: Container(
//                      decoration: BoxDecoration(
//                          image: DecorationImage(
//                              image: AssetImage(
//                                  "assets/images/home/rectangle.png"))),
//                      alignment: Alignment.center,
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 13, vertical: 3),
//                      child: Text(
//                        "直播",
//                        style: TextStyle(color: Colors.white, fontSize: 12),
//                      ),
//                    ),
//                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildHeadWidget extends StatelessWidget {
  final String title;
  final bool showRightBtn;

  const BuildHeadWidget({Key key, this.title, this.showRightBtn = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 3),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border:
                Border(left: BorderSide(color: Color(0xffFFE1B96B), width: 2)),
          ),
          child: Text(
            "$title",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        showRightBtn
            ? Icon(
                Icons.keyboard_arrow_right,
                size: 20,
              )
            : SizedBox()
      ],
    );
  }
}
