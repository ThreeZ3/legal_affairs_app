import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/page/home/home_qr.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';
import 'package:jh_legal_affairs/page/business/diabetes_mellitus_tabs.dart';
import 'package:jh_legal_affairs/page/business/task_tabs.dart';
import 'package:jh_legal_affairs/page/business/consulting_tabs.dart';

class BusinessPage extends StatefulWidget {
  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage>
    with TickerProviderStateMixin {
  TabController tabController;

  //bannner数组
  List<AdSysModel> bannerList = [];

  getBusinessAd() async {
    await adViewModel.adSys(context, type: 3).then((rep) {
      setState(() => bannerList = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 3, vsync: this);
    getBusinessAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.color333,
        title: Text(
          '业务',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.dark,
        leading: new Container(
          padding: EdgeInsets.all(5.0),
          child: new IconButton(
              icon: new Image.asset(
                'assets/images/mine/qrcode_icon@3x.png',
                width: 23.31,
              ),
              onPressed: () =>
                  routePush(JHData.isLogin() ? HomeQrPage() : LoginPage())),
        ),
        actions: <Widget>[],
      ),
      body: new NestedScrollView(
        headerSliverBuilder: (c, b) {
          return [
            new SliverToBoxAdapter(
              child: Container(
                height: 179,
                width: winWidth(context) / 343,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 114,
                      color: ThemeColors.color333,
                    ),
                    Swiper(
                      itemCount: listNoEmpty(bannerList)
                          ? bannerList.length
                          : defBanner.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return new Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
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
                          /*ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'assets/images/home/ad_2.jpg',
                              height: 179,
                              width: 179 / 343,
                              fit: BoxFit.fill,
                            ),
                          ),*/
                        );
                      },
                      onTap: (index) {
                        if (listNoEmpty(bannerList)) {
                          launchURL(context, bannerList[index].urls);
                        } else {
                          routePush(new VideoPlayPage(
                            defBanner[index].urls,
                            null,
                            null,
                          ));
                        }
                      },
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: SwiperPagination.dots),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: new SizedBox(
          width: winWidth(context),
          height: winHeight(context),
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: this.tabController,
                  indicatorWeight: 3,
                  indicatorColor: Color(0xffE1B96B),
                  indicatorPadding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  labelColor: Color(0xff333333),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Color(0xff333333),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: <Widget>[
                    Tab(text: '案源'),
                    Tab(text: '任务'),
                    Tab(text: '咨询'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: this.tabController,
                  children: <Widget>[
                    DiabetesMellitusTabs(),
                    TaskTabs(),
                    ConsultingTabs(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
