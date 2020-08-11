import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/home/home_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class HomeEmptyPage extends StatefulWidget {
  final ScrollController controller;

  HomeEmptyPage(this.controller);

  @override
  _HomeEmptyPageState createState() => _HomeEmptyPageState();
}

class _HomeEmptyPageState extends State<HomeEmptyPage> {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: winHeight(context),
      child: new ListView(
        controller: widget.controller,
        children: <Widget>[
          BannerPic(bannerList: null),
          Container(
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
                new NoDataView(label: '一起来共建数据吧'),
              ],
            ),
          ),
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
                new NoDataView(label: '快来发布你的课件吧'),
              ],
            ),
          ),
          new SizedBox(height: topBarHeight(context)),
        ],
      ),
    );
  }
}
