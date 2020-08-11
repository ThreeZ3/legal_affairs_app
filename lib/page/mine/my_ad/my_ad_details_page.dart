import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_ad/my_ad_select_type_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/list_tile_card_widget.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-25
///
/// 广告详情

class MyAdDetailsPage extends StatefulWidget {
  final String id;
  final String userId;

  MyAdDetailsPage(this.id, this.userId);

  @override
  _MyAdDetailsPageState createState() => _MyAdDetailsPageState();
}

class _MyAdDetailsPageState extends State<MyAdDetailsPage> {
  bool _initiallyExpanded = true; //默认展开状态
  bool lawyer = true; //是否是律师

  AdDetailsModel adDetails = AdDetailsModel();
  List adIncomesList = List();

  @override
  void initState() {
    super.initState();
    getAdDetail();
    getAdIncomes();
  }

  ///查询广告详情信息
  void getAdDetail() {
    adViewModel.adDetail(context, id: widget.id).then((rep) {
      setState(() {
        adDetails = rep.data;
      });
    }).catchError((e) {
      /*showToast(context, e.message);*/
      print('${e.message}');
    });
  }

  ///根据用户ID查询广告收入列表
  void getAdIncomes() {
    adViewModel
        .adIncomes(context,
            id: widget.userId ?? JHData.id(), page: 1, limit: 10)
        .then((rep) {
      adIncomesList = List.from(rep.data);
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: NavigationBar(title: '广告详情'),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: CachedNetworkImage(
                width: winWidth(context) - 32,
                height: (winWidth(context) - 32) * 438 / 1029,
                imageUrl: adDetails?.contentUrl ??
                    'http://picnew14.photophoto.cn/20200227/falvjiangtang-36334334_1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: <Widget>[
                ListTileCardWidget(
                  leading: '推送时间',
                  trailing: '${adDetails?.day ?? null}天',
                ),
                SizedBox(height: 20.0),
                ListTileCardWidget(
                  leading: '发送时间',
                  trailing: adDetails.startTime != null
                      ? DateTimeForMater.formatTimeStampToString(
                          stringDisposeWithDouble(adDetails.startTime / 1000))
                      : '未知',
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: <Widget>[
                ListTileCardWidget(
                  leading: '推送位置',
                  trailing: adDetails?.position ?? '未知',
                  onTap: () => routePush(MyAdSelectTypePage()),
                ),
                SizedBox(height: 20.0),
                ListTileCardWidget(
                  leading: '推送状态',
                  trailing: adDetails?.status ?? '未知',
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0),

          //律师收入展示
          lawyer
              ? Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text('广告收入', style: _styleOne),
                    trailing: _initiallyExpanded
                        ? Image.asset(
                            'assets/images/mine/icon_true.png',
                            width: 18.0,
                          )
                        : Image.asset(
                            'assets/images/mine/icon_false.png',
                            width: 18.0,
                          ),
                    initiallyExpanded: _initiallyExpanded,
                    children: adIncomesList.map((item) {
                      AdIncomesModel model = item;
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  child: CachedNetworkImage(
                                    imageUrl: model?.avatar ??
                                        'assets/images/mine/boy_header@3x.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      model?.realName ?? '未知名字',
                                      style: _styleTwo,
                                    ),
                                    Text(
                                      '${model?.city ?? '未知'} 市| ${model?.district ?? '未知'}区',
                                      style: _styleThree,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              '+￥${model?.district ?? null}',
                              style: _styleFour,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    /* [0, 1, 2, 3, 4].map((item) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'assets/images/mine/user_avatar@3x.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('王一尔', style: _styleTwo),
                                    Text('北京|东城区', style: _styleThree),
                                  ],
                                ),
                              ],
                            ),
                            Text('+￥200.00', style: _styleFour),
                          ],
                        ),
                      );
                    }).toList(),*/
                  ),
                )
              : null,
        ],
      ),
    );
  }
}

TextStyle _styleOne = TextStyle(
  color: Color(0xff333333),
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);
TextStyle _styleTwo = TextStyle(
  color: Color(0xff333333),
  fontSize: 16.0,
);
TextStyle _styleThree = TextStyle(
  color: Color(0xff999999),
  fontSize: 14.0,
);
TextStyle _styleFour = TextStyle(
  color: Color(0xffEB4141),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);
