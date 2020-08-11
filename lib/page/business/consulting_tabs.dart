import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home_new_consult_model.dart';
import 'package:jh_legal_affairs/api/home_new_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/advisory_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class ConsultingTabs extends StatefulWidget {
  ConsultingTabs({Key key}) : super(key: key);

  @override
  _ConsultingTabsState createState() => _ConsultingTabsState();
}

class _ConsultingTabsState extends State<ConsultingTabs> {
  List<ConsultAllModel> dataConsult = new List();
  bool isLoadingOk = false;
  int _goPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    return HomeNewConsultRequestViewModel()
        .getAllNewConsultData(
      context,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          dataConsult = List.from(rep.data);
        } else {
          dataConsult.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return new DataView(
      isLoadingOk: isLoadingOk,
      data: dataConsult,
      color: Colors.white,
      onRefresh: () => getData(true),
      onLoad: () {
        _goPage++;
        return getData();
      },
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: dataConsult.length,
          itemBuilder: (context, index) {
            ConsultAllModel model = dataConsult[index];
            return new InkWell(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${model?.title ?? '未知标题'}',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 3),
                    EditRichShowText(
                      maxLines: 1,
                      json: model?.content,
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              new Visibility(
                                visible: model?.own ?? false,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.only(right: 10),
                                  color: Color(0xffF0F0F0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '我',
                                    style: TextStyle(
                                      color: Color(0xffE1B96B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: Color(0xffF0F0F0),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '${model.category}',
                                  style: TextStyle(
                                    color: Color(0xffE1B96B),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${model?.province ?? '未知省'} ${model?.city ?? '未知市'} ${model?.district ?? '未知区'}',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              new Expanded(
                                child: Text(
                                  '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000), 'yyyy-MM-dd')}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '￥${formatNum(model?.totalAsk?.toString())}',
                          style: TextStyle(
                            color: Color(0xffFF3333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => routePush(new AdvisoryDetailsPage(model.id)),
            );
          }),
    );
  }

//  @override
//  bool get wantKeepAlive => listNoEmpty(dataConsult);
}
