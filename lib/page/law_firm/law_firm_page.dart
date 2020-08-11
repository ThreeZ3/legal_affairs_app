import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/model/firm_list_model.dart';
import 'package:jh_legal_affairs/model/firm_list_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/create_law_firm.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_page.dart';
import 'package:jh_legal_affairs/page/other/search_page.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import '../../common/win_media.dart';
import '../../widget/other/filter_view.dart';
import 'details/law_firm_details.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-23
///
/// 律所首页

class LawFirmPage extends StatefulWidget {
  @override
  _LawFirmPageState createState() => _LawFirmPageState();
}

class _LawFirmPageState extends State<LawFirmPage>
    with AutomaticKeepAliveClientMixin {
  List data = new List();
  bool isLoadingOk = false;
  List<CategoryModel> category = new List();
  int _goPage = 1;
  CategoryModel categoryModel;
  RankModel rankModel;
  DistanceModel distanceModel;
  OrderTypeModel orderTypeModel;
  Result resultArr;
  bool isFilter = false;

  //bannner数组
  List<AdSysModel> bannerList = [];

  final ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
    getCategory();
    getFirmAd();
  }

  getFirmAd() async {
    await adViewModel.adSys(context, type: 2).then((rep) {
      setState(() => bannerList = List.from(rep.data));
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
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

  getData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    firmListViewModel
        .firmList(
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
        .then((ResponseModel rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
          onTap: () => routePush(new SearchPage(SearchType.firm)),
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
          NestedScrollView(
            controller: controller,
            headerSliverBuilder: (s, b) {
              return [
                new SliverToBoxAdapter(
                  //轮播图
                  child: SlideShow(bannerList: bannerList),
                )
              ];
            },
            body: new Column(
              children: <Widget>[
                articleTextScreening(context),
                new Visibility(
                  visible: rankModel?.id != null ||
                      rankModel?.id != null ||
                      orderTypeModel?.id != null ||
                      resultArr?.cityName != null ||
                      categoryModel?.id != null,
                  child: new Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: winWidth(context),
                    alignment: Alignment.center,
                    color: Color(0xffF5F5F5),
                    child: new Text(
                      '区域：${resultArr?.cityName ?? '全部'}，排序方式：${orderTypeModel?.name ?? '全部'}，类型：${categoryModel?.name ?? '综合'}，排名：${rankModel?.name ?? '全部'}，距离：${distanceModel?.name ?? '全部'}',
                      style: TextStyle(color: Color(0xffBFBFBF), fontSize: 10),
                    ),
                  ),
                ),
                new Expanded(
                  child: new DataView(
                    isLoadingOk: isLoadingOk,
                    data: data,
                    onRefresh: () {
                      if (!listNoEmpty(category)) getCategory();
                      return getData(true);
                    },
                    onLoad: () {
                      _goPage++;
                      return getData();
                    },
                    child: Column(
                      children: List.generate(data.length, (index) {
                        FirmListModel model = data[index];
                        return LawFirmItem(model);
                      }),
                    ),
                  ), //律所
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
              getData(true);
            },
            onCancel: () {
              setState(() => isFilter = false);
            },
          ),
        ],
      ),
    );
  }

  Widget articleTextScreening(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
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
                      getData(true);
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
        ],
      ),
    );
  }

  //  //分页指示器
  customSwiperPagination() {
    return SwiperPagination(
      margin: EdgeInsets.symmetric(vertical: 4),
      builder: DotSwiperPaginationBuilder(
        space: 2,
        size: 6,
        color: Color(0xff666666),
        activeSize: 6,
        activeColor: Color(0xFFC0984E),
      ),
    );
  }

  @override
  bool get wantKeepAlive => listNoEmpty(data);
}

class LawFirmItem extends StatelessWidget {
  final FirmListModel model;

  LawFirmItem(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        routePush(new LawFirmDetailsPage(
            model?.id ?? '0', int.parse(stringDisposeWithDouble(model?.rank))));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
                child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: strNoEmpty(model?.firmAvatar)
                      ? CachedNetworkImage(
                          imageUrl: model?.firmAvatar,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : new Image.asset(
                          avatarLawFirm,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: 8),
                new Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  model?.firmName ?? '未知标题',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                new Space(height: 5.0),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      model?.lawyers.toString() ?? '350',
                                      style: TextStyle(
                                        color: Color(0xffE1B96B),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '名律师',
                                      style: TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          new Space(),
                          IconBox(
                            text: '排名',
                            number:
                                '${stringDisposeWithDouble(model.rank) ?? '0'}',
                          ),
                        ],
                      ),
                      new Space(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                model?.district ?? '未知区',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 10,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                color: Color(0xff999999),
                              ),
                              Text(
                                model?.town ?? '未知镇',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${stringDisposeToKm(stringDisposeWithDouble(model?.range, 0))}',
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      new Space(height: 10.0),
                      Wrap(
                        spacing: 8,
                        runSpacing: 5,
                        children: []
                          ..addAll((model.legalField.length > 3
                                  ? model.legalField.sublist(0, 3)
                                  : model.legalField)
                              .map((item) {
                            NewCategoryModel model = item;
                            return LabelBox(
                              height: 18,
                              text:
                                  '${model?.name ?? '未知类别'} ${stringDisposeWithDouble(model?.rank ?? '0')}',
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
              ],
            )),
          ],
        ),
      ),
    );
  }
}

//标题栏
class CustomerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _leadingIconCustom(), //前侧图标
          SizedBox(width: 16),
          _searchBox(), //搜索框
          SizedBox(width: 16),
          _actionIconCustom(), //后侧图标
        ],
      ),
    );
  }

  //前侧图标
  Widget _leadingIconCustom() {
    return InkWell(
      onTap: () {
        print('已点击珠海图标');
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Image.asset(
              PLACEPIC,
              fit: BoxFit.cover,
              width: 19.61,
            ),
            SizedBox(width: 4),
            Text(
              '珠海',
              style: TextStyle(
                color: Color(0xffE1B96B),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //搜索框
  Widget _searchBox() {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          print('已点击搜索框');
        },
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFE),
            borderRadius: BorderRadius.circular(39),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                SEARCHPIC,
                fit: BoxFit.cover,
                color: Color(0xFF999999),
                width: 13.85,
              ),
              SizedBox(width: 8),
              Text(
                '搜索',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //后侧图标
  Widget _actionIconCustom() {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            print('已点击+');
          },
          child: Image.asset(
            HOMEPIC,
            fit: BoxFit.cover,
            width: 24,
            height: 22,
          ),
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: () {
            print('已点击信息');
          },
          child: Image.asset(
            MESSAGEPIC,
            fit: BoxFit.cover,
            width: 23.31,
            height: 23.31,
          ),
        ),
      ],
    );
  }
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
                  routePush(new VideoPlayPage(
                    defBanner[index].urls,
                    null,
                    null,
                  ));
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
                      fit: BoxFit.cover,
                    ),
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
