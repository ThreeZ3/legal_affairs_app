import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_model.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_pictures/my_pictures_details.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/round_check_box.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

class AllConsultPage extends StatefulWidget {
  final String firmId;
  final bool isMe;

  AllConsultPage(this.isMe, [this.firmId]);

  @override
  _AllConsultPageState createState() => _AllConsultPageState();
}

class _AllConsultPageState extends State<AllConsultPage> {
  List<Records> data = new List();
  bool isLoadingOk = false;
  int _goPage = 1;
  List delList = new List();

  //判断是否删除状态
  bool _delSwitch = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData([bool isInit = false]) {
    if (widget.firmId == null) {
      return getDataAll(isInit);
    } else {
      return getDataFirm(isInit);
    }
  }

  Future getDataFirm([bool isInit = false]) async {
    if (isInit) _goPage = 1;

    await sketchViewModel
        .sketchFirm(
      context,
      limit: 10,
      page: _goPage,
      id: widget.firmId,
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

  Future getDataAll([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return sketchViewModel
        .sketchList(
      context,
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
    return new Scaffold(
      appBar: new NavigationBar(
        title: '法律资讯',
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
              child: new ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Records model = data[index];
//            return new InformationModel(data: model);
                  return GraphicInfoItem(
                    data: model,
                    openDel: _delSwitch,
                    delList: delList,
                    itemList: data,
                  );
                },
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
                        delCase();
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

  void delCase() {
    for (int a = 0; a < delList.length; a++) {
      sketchViewModel.sketchDel(context, id: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _delSwitch = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {}).then((v) {
        getData(true);
      });
    });
  }
}

class IconWidget extends StatelessWidget {
  final String pic;
  final String num;
  final Function onTap;
  bool isChoose;

  IconWidget({Key key, this.pic, this.num, this.onTap, this.isChoose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset("assets/images/lawyer/$pic",
                  width: 13, fit: BoxFit.cover),
              Expanded(
                child: Text(
                  num,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GraphicInfoItem extends StatefulWidget {
  final Records data;
  final bool openDel;
  final List itemList;
  final List delList;

  const GraphicInfoItem(
      {Key key, this.openDel, this.data, this.itemList, this.delList})
      : super(key: key);

  @override
  _GraphicInfoItemState createState() => _GraphicInfoItemState();
}

class _GraphicInfoItemState extends State<GraphicInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: RoundCheckBox(
                  value: widget.data.delCheck,
                  onChanged: (v) {
                    setState(() {
                      widget.data.delCheck = !widget.data.delCheck;
                      if (widget.data.delCheck)
                        widget.delList.add(widget.data.id);
                      if (!widget.data.delCheck)
                        widget.delList.remove(widget.data.id);
                    });
                  },
                ),
              ),
        Expanded(
            child: GraphicInformationItem(
          data: widget?.data ?? new Records(),
        )),
      ],
    );
  }
}

class GraphicInformationItem extends StatelessWidget {
  final Records data;
  final double horizontal;
  final bool isBorder;

  GraphicInformationItem(
      {this.data, this.horizontal = 16, this.isBorder = true, Z});

  @override
  Widget build(BuildContext context) {
    List<String> image = new List();

    if (strNoEmpty(data?.pictures)) {
      image = data.pictures.toString().split(';');
      for (int i = 0; i < image.length; i++) {
        image.remove('');
        image.remove(null);
      }
      if (image.length > 3) image = image.sublist(0, 3);
    }
    return InkWell(
      onTap: () {
        routePush(MyPicturesDetails(
          id: data.id,
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 5),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: isBorder
                ? Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))
                : null),
        child: image.length != 1
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 11,
                      children: List.generate(
                          image.length > 3 ? 3 : image.length, (index) {
                        return CachedNetworkImage(
                          imageUrl: image[index],
                          width: (MediaQuery.of(context).size.width -
                                  33 -
                                  (image.length - 1) * 11) /
                              image.length,
                          height: (MediaQuery.of(context).size.width -
                                  33 -
                                  (image.length - 1) * 11) /
                              image.length /
                              (107 / 90),
                          fit: BoxFit.cover,
                        );
                      })),
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xffE1B96B)),
                              borderRadius: BorderRadius.circular(2)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Text(
                            data?.categoryName ?? '未知',
                            style: TextStyle(
                                color: Color(0xffE1B96B), fontSize: 10),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${data?.lawyerName ?? "未知作者"}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[400]),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(data.createTime / 1000) ?? '0', "yyyy-MM-dd")}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[400]),
                        ),
                        Spacer(),
                      ]..addAll([
                          IconWidget(
                            pic: "read.png",
                            num: "${data.reading}",
                          ),
                          IconWidget(
                            pic: "ic_comment.png",
                            num: "${data.commentsCount}",
                          ),
                          IconWidget(pic: "good.png", num: "${data.like}"),
                          IconWidget(
                            pic: "share1.png",
                            num: "${data.shareCount}",
                          ),
                        ]),
                    ),
                  )
                ],
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           border: Border.all(width: 1,color: Color(0xffE1B96B)),
                          //           borderRadius: BorderRadius.circular(2)
                          //       ),
                          //       padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                          //       child: Text("标签",style: TextStyle(color: Color(0xffE1B96B),fontSize: 10),),
                          //     ),
                          //     SizedBox(width:8),
                          //     Text("作者名",style: TextStyle(fontSize: 10,color: Colors.grey[400]),),
                          //     SizedBox(width:8),

                          //     Text("一小时前",style: TextStyle(fontSize: 10,color: Colors.grey[400]),),]),
                          new Expanded(
                            child: Text(
                              data.describe ?? '暂无内容简介',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff999999)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              IconWidget(
                                pic: "share1.png",
                                num: '${data.shareCount}',
                              ),
                              Spacer(),
                              IconWidget(
                                pic: "read.png",
                                num: '${data.reading}',
                              ),
                              Spacer(),
                              IconWidget(
                                pic: "star.png",
                                num: '${data.collections}',
                              ),
                              Spacer(),
                              IconWidget(
                                pic: "good.png",
                                num: '${data.like}',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  CachedNetworkImage(
                    imageUrl: image[0],
                    width: 107,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  image.length > 1 && image.length < 2
                      ? CachedNetworkImage(
                          imageUrl: image[1],
                          width: 107,
                          height: 90,
                          fit: BoxFit.cover,
                        )
                      : new Container()
                ],
              ),
      ),
    );
  }
}
