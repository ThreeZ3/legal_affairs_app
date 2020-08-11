import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///订阅情况
///
class SubscriptionSituation extends StatefulWidget {
  final String id;

  SubscriptionSituation({Key key, this.id}) : super(key: key);

  @override
  _SubscriptionSituationState createState() => _SubscriptionSituationState();
}

class _SubscriptionSituationState extends State<SubscriptionSituation> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoadingOk = false;
  List subScriptionList = [];
  int page = 1;

  Future getData() async {
    await lectureViewModel
        .lectureSubscriptionList(context, id: widget.id, page: page, limit: 10)
        .then((v) {
      setState(() {
        subScriptionList.addAll(v.data);
        if (!listNoEmpty(v.data)) {
          showToast(context, "没有更多的数据了");
        }
        isLoadingOk = true;
      });
    }).catchError((e) => showToast(context, e.message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: "订阅情况",
      ),
      body:  DataView(
              isLoadingOk: isLoadingOk,
              data: subScriptionList,
              onRefresh: () {
                page = 1;
                return getData();
              },
              onLoad: () {
                page++;
                return getData();
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "已收入",
                          style: TextStyle(
                            color: Color(0xffFF333333),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "￥ 1，000.00",
                          style: TextStyle(
                              color: Color(0xffFFD9001B), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "收入明细",
                          style: TextStyle(
                            color: Color(0xffFF333333),
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                  Column(
                    children: subScriptionList.map((v) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        height: 64,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                "assets/images/lawyer/graphic.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  v.nickName ?? "匿名",
                                  style: TextStyle(
                                    color: Color(0xffFF333333),
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  v.createTime ?? " ",
                                  style: TextStyle(
                                      color: Color(0xffFF999999), fontSize: 10),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "￥ ${v.charges ?? "100.00"}",
                              style: TextStyle(
                                  color: Color(0xffFFD9001B), fontSize: 14),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
    );
  }
}
