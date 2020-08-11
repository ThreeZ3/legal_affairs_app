import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/create_law_firm.dart';
import 'package:jh_legal_affairs/page/other/search_page.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/widget/other/filter_view.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'lawyer_details_page.dart';

class LawyerPage extends StatefulWidget {
  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage>
    with AutomaticKeepAliveClientMixin {
  List lists = new List();
  bool isLoadingOk = false;
  bool isFilter = false;
  List<CategoryModel> category = new List();
  int _goPage = 1;
  CategoryModel categoryModel;
  RankModel rankModel;
  DistanceModel distanceModel;
  OrderTypeModel orderTypeModel;
  Result resultArr;
  final ScrollController controller = new ScrollController();

  //bannner数组
  List<AdSysModel> bannerList = [];

  getLawyerAd() async {
    await adViewModel.adSys(context, type: 4).then((rep) {
      setState(() => bannerList = List.from(rep.data));
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getLawyerData();
    getCategory();
    getLawyerAd();
  }

  getLawyerData([bool isInit = false]) async {
    if (isInit) _goPage = 1;

    lawyerViewModel
        .lawyerSearch(
      context,
      limit: 15,
      page: _goPage,
      typeId: categoryModel?.id,
      maxRange: distanceModel?.id,
      maxRank: rankModel?.id,
      orderType: orderTypeModel?.id,
      province: resultArr?.provinceName,
      city: resultArr?.cityName,
      district: resultArr?.areaName,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          lists = List.from(rep.data);
        } else {
          lists.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      print('e====> ${e.toString()}');
      if (mounted) setState(() => isLoadingOk = true);
      if (mounted) showToast(context, e.message);
    });
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() {
        category = [new CategoryModel(name: '全部', id: null, isType: true)];
        category.addAll(List.from(rep.data));
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  Widget articleTextScreening(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              children:
                  (category.length > 7 ? category.sublist(0, 6) : category)
                      .map((item) {
                CategoryModel model = item;
                return InkWell(
                  child: Container(
                    height: 40,
                    width: (winWidth(context) - 80) / 6,
                    alignment: Alignment.center,
                    child: Text(
                      model.name,
                      style: TextStyle(
                        color: model.isType
                            ? Color(0xFF373737)
                            : Color(0xFF909090),
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.jumpTo(0);
                    setState(() {
                      model.isType = !model.isType;
                      categoryModel = model;
                      getLawyerData(true);
                      for (CategoryModel inModel in category) {
                        if (model.id != inModel.id) inModel.isType = false;
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => isFilter = true),
            child: new SizedBox(
              width: 60,
              child: Row(
                children: <Widget>[
                  Text('筛选', style: TextStyle(color: Color(0xFF373737))),
                  SizedBox(width: 2),
                  Image.asset(
                    'assets/images/law_firm/select@3x.png',
                    width: 12,
                    height: 13,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: new NavigationBar(
        leading: new InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Space(width: 2),
              Image.asset(PLACEPIC, fit: BoxFit.cover, width: 19),
              Text(
                  '${strNoEmpty(location?.city) ? location.city.substring(0, 2) : '未知'}',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          onTap: () => JHData.isLogin()
              ? showToast(context,
                  '当前位置:${strNoEmpty(location?.province) ? location.province : '未知省'} ${strNoEmpty(location?.city) ? location.city : '未知市'} ${strNoEmpty(location?.city) ? location.district : '未知区'}')
              : routePush(new LoginPage()),
        ),
        titleW: new InkWell(
          child: Container(
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(SEARCHPIC,
                    fit: BoxFit.cover, color: Color(0xFFC6C6C6), width: 15),
                SizedBox(width: 8),
                Text('搜索',
                    style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 15)),
              ],
            ),
          ),
          onTap: () => routePush(new SearchPage(SearchType.lawyer)),
        ),
        rightDMActions: <Widget>[
          Row(
            children: <Widget>[
              new InkWell(
                child: new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(HOMEPIC, fit: BoxFit.cover, width: 21),
                ),
                onTap: () => routePush(!JHData.isLogin()
                    ? new LoginPage()
                    : new CreateLawFirmPage()),
              ),
              new Space(width: mainSpace / 2),
            ],
          ),
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new NestedScrollView(
            controller: controller,
            headerSliverBuilder: (context, bool h) {
              return [
                new SliverToBoxAdapter(child: SlideShow(bannerList: bannerList))
              ];
            },
            body: Column(
              children: <Widget>[
                articleTextScreening(context),
                new Visibility(
                  visible: rankModel?.id != null ||
                      rankModel?.id != null ||
                      orderTypeModel?.id != null ||
                      resultArr?.cityName != null ||
                      categoryModel?.id != null,
                  child: new Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: new Text(
                      '区域：${resultArr?.cityName ?? '全部'}，排序方式：${orderTypeModel?.name ?? '全部'}，类型：${categoryModel?.name ?? '综合'}，排名：${rankModel?.name ?? '全部'}，距离：${distanceModel?.name ?? '全部'}',
                      style: TextStyle(color: Color(0xffBFBFBF), fontSize: 10),
                    ),
                  ),
                ),
                Expanded(
                  child: new DataView(
                    color: Colors.white,
                    isLoadingOk: isLoadingOk,
                    data: lists,
                    onRefresh: () {
                      if (!listNoEmpty(category)) getCategory();
                      return getLawyerData(true);
                    },
                    onLoad: () {
                      _goPage++;
                      return getLawyerData();
                    },
                    child: ListView.builder(
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        LawyerListModel model = lists[index];
                        return LawyerItem(model);
                      },
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new FilterView(
            visible: isFilter,
            data: category,
            onFilter: (
              CategoryModel categoryModel,
              RankModel rankModel,
              DistanceModel distanceModel,
              OrderTypeModel orderTypeModel,
              Result resultArr,
            ) {
              setState(() {
                this.categoryModel = categoryModel;
                this.rankModel = rankModel;
                this.distanceModel = distanceModel;
                this.orderTypeModel = orderTypeModel;
                this.resultArr = resultArr;
              });
              getLawyerData(true);
            },
            onCancel: () {
              setState(() => isFilter = false);
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => listNoEmpty(lists);
}

//轮播图
class SlideShow extends StatelessWidget {
  final List bannerList;

  const SlideShow({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF2F2F2),
      height: 179,
      width: winWidth(context) / 343,
      child: Stack(
        children: <Widget>[
          Container(
            height: 130,
            color: ThemeColors.color333,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Swiper(
              itemCount: listNoEmpty(bannerList)
                  ? bannerList.length
                  : defBanner.length,
              scrollDirection: Axis.horizontal,
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
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 16),
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
                  /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/home/ad_2.jpg"),
                        fit: BoxFit.fill),
                  ),*/
                );
              },
              autoplay: true,
              pagination: customSwiperPagination(),
              outer: true,
              loop: true,
            ),
          ),
        ],
      ),
    );
  }

  //分页指示器
  customSwiperPagination() {
    return SwiperPagination(
      margin: EdgeInsets.only(top: 5),
      builder: DotSwiperPaginationBuilder(
        space: 2,
        size: 6,
        color: Color(0xff797979),
        activeSize: 6,
        activeColor: Color(0xFFC1994E),
      ),
    );
  }
}

//图片总路径：
const String All_PICTURE_ASSETS = "assets/images/lawyer/";
//律师首页
//地图图标
const PLACEPIC = All_PICTURE_ASSETS + "place.png";
//搜索框图标
const SEARCHPIC = All_PICTURE_ASSETS + "searchpic.png";
//home图标
const HOMEPIC = All_PICTURE_ASSETS + "home.png";
//信息图标
const MESSAGEPIC = All_PICTURE_ASSETS + "message.png";
//轮播图
const SLIDEPIC = All_PICTURE_ASSETS + "slidepic.png";
//筛选图标
const SCREENPIC = All_PICTURE_ASSETS + "screenpic.png";

//信息
final String title = "未知律师";

class LawyerItem extends StatelessWidget {
  final LawyerListModel model;
  final Callback callback;

  LawyerItem(this.model, {this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (callback != null) {
          pop();
          callback(model.id);
        } else {
          routePush(new LawyerDetailsPage(
            model.id,
//            int.parse(stringDisposeWithDouble(model?.rank)),
//            model?.legalField ?? [],
          ));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - (17 * 2),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 17.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xfff7f7f7), width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: strNoEmpty(model?.avatar)
                  ? new CachedNetworkImage(
                      imageUrl: model?.avatar,
                      width: 100,
                      height: 100,
                    )
                  : new Image.asset(
                      avatarLawyerMan,
                      width: 100,
                      height: 100,
                    ),
            ),
            SizedBox(width: 10),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model?.realName ?? model?.nickName ?? '未知律师',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          new Row(
                            children: <Widget>[
                              new Text(
                                '执业${workYearStr(model?.workYear)}年',
                                style: TextStyle(
                                  color: Color(0xffB2B2B2),
                                  fontSize: 12,
                                ),
                              ),
                              new Space(),
                              Text(
                                '${model?.city ?? '未知地区'}',
                                style: TextStyle(
                                  color: Color(0xffB2B2B2),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1B96B),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: (Radius.circular(5)),
                              ),
                            ),
                            child: Text(
                              '排名',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: (Radius.circular(5)),
                              ),
                            ),
                            child: Text(
                              '${stringDisposeWithDouble(model?.rank) ?? '0'}',
                              style: TextStyle(color: Color(0xFFE1B96B)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          '${model?.province ?? '未知地区'}${model?.firmName ?? "某某律师事务所"}',
                          style: TextStyle(
                            color: Color(0xffB2B2B2),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Space(width: mainSpace * 2),
                      Text(
                        '${stringDisposeToKm(stringDisposeWithDouble(model?.range, 0))}',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: []
                      ..addAll((model.legalField.length > 3
                              ? model.legalField.sublist(0, 3)
                              : model.legalField)
                          .map((item) {
                        NewCategoryModel model = item;
                        return Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F0F0),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          child: Text(
                            '${model?.name ?? '未知'}${stringDisposeWithDouble(stringDisposeWithDouble(model?.rank)) ?? '0'}',
                            style: TextStyle(
                                color: Color(0xffE5CB98), fontSize: 12.0),
                          ),
                        );
                      }).toList())
                      ..addAll([
                        model.legalField.length > 3
                            ? new Text('...')
                            : new Container(),
                      ]),
                  ),
                ],
              ),
            ),
            new Space(),
//            Container(
//              height: 90,
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    alignment: Alignment.center,
//                    width: 50,
//                    height: 22,
//                    decoration: BoxDecoration(
//                        color: Color(0xFFE1B96B),
//                        borderRadius: BorderRadius.circular(5)),
//                    child: Text(
//                      '排名',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  ),
//                  Container(
//                    alignment: Alignment.center,
//                    width: 50,
//                    height: 22,
//                    decoration: BoxDecoration(
//                        color: Color(0xffF0F0F0),
//                        borderRadius: BorderRadius.circular(5)),
//                    child: Text(
//                      '${rank ?? '0'}',
//                      style: TextStyle(color: Color(0xFFE1B96B)),
//                    ),
//                  ),
//                  new Spacer(),
//                  Text(
//                    '${stringDisposeToKm(stringDisposeWithDouble(model?.range, 0))}',
//                    style: TextStyle(
//                      color: Color(0xff999999),
//                      fontSize: 12,
//                    ),
//                    textAlign: TextAlign.end,
//                    overflow: TextOverflow.ellipsis,
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
