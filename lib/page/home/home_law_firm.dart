import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_law_firm_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/page/home/home_label_widget.dart';
import 'package:jh_legal_affairs/page/home/home_ranking_widget.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_details.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///首页推荐事务所列表
class HomeLawFirm extends StatelessWidget {
  final HomeLawFirmRequestModel data;

  const HomeLawFirm({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: strNoEmpty(data?.firmAvatar)
                  ? CachedNetworkImage(
                      imageUrl: "${data?.firmAvatar}",
                      width: winWidth(context) * 0.25,
                      height: winWidth(context) * 0.26,
                      fit: BoxFit.cover,
                    )
                  : new Image.asset(
                      avatarLawFirm,
                      width: winWidth(context) * 0.25,
                      height: winWidth(context) * 0.26,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              width: winWidth(context) * 0.48,
//              height: winWidth(context) * 0.26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${data?.firmName ?? "firmName"}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data?.city ?? "city"} ${data?.district ?? "district"}",
                    style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Wrap(
                    children: (listNoEmpty(data?.legalField)
                            ? (data.legalField.length < 3
                                ? data?.legalField
                                : data.legalField.sublist(0, 3))
                            : [new NewCategoryModel(name: '未知', rank: '0')])
                        .map((v) {
                      NewCategoryModel model = v;
                      return Container(
                        margin: EdgeInsets.only(right: 8),
                        child: HomeLabelWidget(
                          name: '${model?.name.toString() ?? '未知类别'}',
                          rank:
                              '${stringDisposeWithDouble(model?.rank ?? '0')}',
                        ),
                      );
                    }).toList(),
                  ),
                  new Text(
                      '${listNoEmpty(data?.legalField ?? []) && (data?.legalField?.length ?? 0) > 3 ? '...' : ''}'),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${data?.firmInfo ?? "律所简介"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            HomeRankingWidget(name: '${data?.rank ?? "0"}'),
          ],
        ),
      ),
      onTap: () => routePush(new LawFirmDetailsPage(
          data.id, int.parse(stringDisposeWithDouble(data?.rank)))),
    );
  }
}
