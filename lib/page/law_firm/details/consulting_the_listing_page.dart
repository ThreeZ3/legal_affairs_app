import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/business/consult_model.dart';
import 'package:jh_legal_affairs/api/business/consult_view_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/advisory_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 律所详情-咨询清单
///
class ConsultingTheListingPage extends StatefulWidget {
  final String id;
  final bool isMe;

  ConsultingTheListingPage(this.id, this.isMe);

  @override
  _ConsultingTheListingPageState createState() =>
      _ConsultingTheListingPageState();
}

class _ConsultingTheListingPageState extends State<ConsultingTheListingPage> {
  List<ConsultViewListModel> data = new List();
  bool isLoadingOk = false;
  int _goPage = 1;
  bool _delSwitch = false;
  List _delList = new List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return consultViewModel
        .consultFirm(
      context,
      id: widget.id,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: new NavigationBar(
        title: '咨询清单',
        rightDMActions: widget.isMe
            //判断是否是自己，显示按钮
            ? <Widget>[
                listNoEmpty(data)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _delSwitch = !_delSwitch;
                          });
                        },
                        child: new Container(
                          padding: EdgeInsets.all(13.0),
                          child: Image.asset(
                              'assets/images/mine/list_icon@3x.png'),
                        ),
                      )
                    : new Container(),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new DataView(
              isLoadingOk: isLoadingOk,
              data: data,
              onRefresh: () => getData(true),
              onLoad: () {
                _goPage++;
                return getData();
              },
              child: ListView(
                padding: EdgeInsets.only(top: 4, left: 16, right: 16),
                children: data.map((v) {
                  return ConsultBuild(
                    data: v,
                    openDel: _delSwitch,
                    delList: _delList,
                  );
                }).toList(),
              ),
            ),
          ),
          new Visibility(
            visible: _delSwitch,
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: MagicBt(
                      onTap: () {
                        delFunction();
                      },
                      text: '删除',
                      radius: 10.0,
                      height: 40,
                      color: Color.fromRGBO(225, 185, 107, 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: MagicBt(
                      onTap: () {
                        setState(() {
                          _delSwitch = false;
                        });
                      },
                      text: '取消',
                      radius: 10.0,
                      height: 40,
                      color: ThemeColors.color999,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void delFunction() {
    for (int a = 0; a < _delList.length; a++) {
      consultViewModel.deletesConsult(context, _delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _delSwitch = false;
      _delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {}).then((v) {
        getData(true);
      });
    });
  }
}

class ConsultBuild extends StatefulWidget {
  final ConsultViewListModel data;
  final bool openDel;
  final List itemList;
  final List delList;

  const ConsultBuild(
      {Key key, this.data, this.openDel, this.itemList, this.delList})
      : super(key: key);

  @override
  _ConsultBuildState createState() => _ConsultBuildState();
}

class _ConsultBuildState extends State<ConsultBuild> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Checkbox(
                value: widget.data.isDel,
                onChanged: (v) {
                  setState(() {
                    widget.data.isDel = !widget.data.isDel;
                    if (widget.data.isDel) widget.delList.add(widget.data.id);
                    if (!widget.data.isDel)
                      widget.delList.remove(widget.data.id);
                  });
                },
                activeColor: Color(0xffFFE1B96B)),
        Expanded(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () => routePush(new AdvisoryDetailsPage(widget.data.id)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: <Widget>[
                          Image.asset("assets/images/law_firm/book.png"),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${widget.data?.title ?? "title"}",
                                style: TextStyle(
                                  color: Color(0xff24262e),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Space(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 25 / 2,
                                    backgroundImage: AssetImage(
                                        "assets/images/law_firm/head_portrait.png"),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "承接者昵称",
                                    style: TextStyle(
                                      color: Color(0xffaaaaaa),
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              Space(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: 31,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Text(
                                      widget.data?.category ?? "",
                                      style: TextStyle(
                                        color: Color(0xffEBB769),
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    widget.data?.createTime ?? "",
                                    style: TextStyle(
                                      color: Color(0xffaaaaaa),
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 77,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '${strNoEmpty(widget.data.status) ? widget.data.status.split(";")[1] : ""}',
                                style: 1 <= 2
                                    ? TextStyle(
                                        color: Color(0xffebb769),
                                        fontSize: 12,
                                      )
                                    : TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 12,
                                      ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Space(),
                            Container(
                              child: Text(
                                '￥${formatNum(widget.data.totalAsk)}',
                                style: TextStyle(
                                    color: Color(0xffff3333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xffF0F0F0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
