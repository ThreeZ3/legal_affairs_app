import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/page/home/home_label_widget.dart';
import 'package:jh_legal_affairs/page/home/home_ranking_widget.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///首页律师推荐列表

class HomeLawyerList extends StatefulWidget {
  final LawyerListModel data;

  HomeLawyerList({Key key, this.data}) : super(key: key);

  @override
  _HomeLawyerListState createState() => _HomeLawyerListState();
}

class _HomeLawyerListState extends State<HomeLawyerList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQueryData.fromWindow(window).size.width;
    return new InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 13, bottom: 8, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: strNoEmpty(widget.data?.avatar)
                  ? CachedNetworkImage(
                      imageUrl: widget.data.avatar,
                      width: winWidth(context) * 0.18,
                      height: winWidth(context) * 0.18 + 3,
                    )
                  : new Image.asset(
                      avatarLawyerMan,
                      width: winWidth(context) * 0.18,
                      height: winWidth(context) * 0.18 + 3,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 9),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.55 - 9,
                    child: Text(
                      widget.data?.realName ?? '未知昵称',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      "执业${workYearStr(widget.data.workYear)}年",
                      widget.data?.province ?? "",
                      widget.data?.city ?? "",
                    ].map((v) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          "$v",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff999999)),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: (listNoEmpty(widget.data?.legalField)
                              ? (widget.data.legalField.length < 3
                                  ? widget.data?.legalField
                                  : widget.data.legalField.sublist(0, 3))
                              : ['未知'])
                          .map((v) {
                        NewCategoryModel model = v;
                        return WidgetSpan(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: HomeLabelWidget(
                              name: model?.name ?? '未知类别',
                              rank: stringDisposeWithDouble(model?.rank),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  new Text(
                      '${listNoEmpty(widget.data?.legalField ?? []) && (widget.data?.legalField?.length ?? 0) > 3 ? '...' : ''}'),
                ],
              ),
            ),
            HomeRankingWidget(name: stringDisposeWithDouble(widget.data?.rank)),
          ],
        ),
      ),
      onTap: () => routePush(
        new LawyerDetailsPage(
          widget.data.id,
//          int.parse(stringDisposeWithDouble(widget.data?.rank)),
//          widget.data?.legalField ?? [],
        ),
      ),
    );
  }
}
