import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_model.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_view_model.dart';
import 'package:jh_legal_affairs/page/home/all_consult_page.dart';
import 'package:jh_legal_affairs/page/mine/my_pictures/publish_pictures.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class MyPicturesPage extends StatefulWidget {
  final String id;
  final String oc;

  MyPicturesPage(this.id, this.oc);

  @override
  _MyPicturesPageState createState() => _MyPicturesPageState();
}

class _MyPicturesPageState extends State<MyPicturesPage> {
  bool _openDel = false;

  //图文数组
  List<Records> _sketchList = new List();
  bool isLoadingOk = false;
  int goPage = 1;
  List delList = new List();

  Future getPicturesData([bool isInit = false]) async {
    if (isInit) goPage = 1;

    ///请求图文列表
    await SketchViewModel()
        .sketchMyList(
      context,
      page: goPage,
      limit: 15,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          _sketchList = List.from(rep.data);
        } else {
          _sketchList.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getPicturesData();
    Notice.addListener(JHActions.myPicturesRefresh(), (v) {
      getPicturesData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myPicturesRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.oc}的图文',
        rightDMActions: widget.id == JHData.id()
            ? <Widget>[
                new Visibility(
                  visible: listNoEmpty(_sketchList),
                  child: new GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _openDel = !_openDel;
                      });
                    },
                    child: Image.asset(
                      'assets/images/mine/list_icon@3x.png',
                      width: 22.0,
                    ),
                  ),
                ),
                new SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    routePush(PublishPictures());
                  },
                  child: new Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/share_icon@3x.png'),
                  ),
                ),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: DataView(
              isLoadingOk: isLoadingOk,
              data: _sketchList,
              onRefresh: () => getPicturesData(true),
              onLoad: () {
                goPage++;
                return getPicturesData();
              },
              child: ListView.builder(
                  itemCount: _sketchList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GraphicInfoItem(
                      data: _sketchList[index],
                      openDel: _openDel,
                      delList: delList,
                      itemList: _sketchList,
                    );
                  }),
            ),
          ),
          Visibility(
            visible: _openDel,
            child: Column(
              children: <Widget>[
                RegisterButtonWidget(
                  title: '删除',
                  horizontal: 16,
                  onTap: () => delCase(),
                ),
                SizedBox(height: 14),
                RegisterButtonWidget(
                  title: '取消',
                  horizontal: 16,
                  titleColors: ThemeColors.color999,
                  backgroundColors: ThemeColors.colore4,
                  onTap: () {
                    setState(() {
                      _openDel = false;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
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
      _openDel = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {}).then((v) {
        getPicturesData(true);
      });
    });
  }
//
//  Widget myPicturesItem(Records item) {
//    double MQwidth = MediaQuery.of(context).size.width;
//    return GestureDetector(
//      onTap: () {
//        routePush(MyPicturesDetails(id: item.id));
//      },
//      child: Container(
//        height: 137,
//        width: double.maxFinite,
//        margin: EdgeInsets.only(
//            right: MQwidth * 0.037, left: MQwidth * 0.037, top: 8),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.all(Radius.circular(5)),
//          color: Colors.white,
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Container(
//              width: MQwidth * 0.54,
//              margin: EdgeInsets.all(MQwidth * 0.021),
//              child: Column(
//                children: <Widget>[
//                  //标题
//                  Container(
//                    alignment: Alignment.topLeft,
//                    child: Text(
//                      item?.title ?? "未知",
//                      maxLines: 2,
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 14,
//                          color: Colors.black),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  //内容
//                  Container(
//                    alignment: Alignment.topLeft,
//                    child: Text(
//                      item?.describe ?? "内容简介容简介内容 介内容简介内介内容简介内容简介",
//                      maxLines: 3,
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(
//                        color: Color(0xff999999),
//                        fontSize: 12,
//                      ),
//                    ),
//                  ),
//                  Spacer(),
//                  //点赞数浏览数的行
//                  Container(
//                    height: 13,
//                    child: Row(
//                      children: <Widget>[
//                        IconNumber(
//                            icon: "assets/images/lawyer/share1.png",
//                            number: "0"),
//                        IconNumber(
//                            icon: "assets/images/lawyer/star.png",
//                            number: item?.collections.toString() ?? "0"),
//                        IconNumber(
//                            icon: "assets/images/lawyer/good.png", number: "0"),
//                        IconNumber(
//                            icon: "assets/images/lawyer/read.png",
//                            number: item?.reading.toString() ?? "0"),
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//
//            //${widget.oc}的图文的图片
//            Container(
//              width: MQwidth * 0.322,
//              height: MQwidth * 0.322,
//              margin: EdgeInsets.only(
//                  right: MQwidth * 0.021, top: MQwidth * 0.021, bottom: 8),
//              child: Image.asset(
//                'assets/images/mine/video_photo@3x.png',
//                width: MQwidth * 0.322,
//                height: MQwidth * 0.322,
//                fit: BoxFit.cover,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
}

//点赞转发收藏数量栏
class IconNumber extends StatefulWidget {
  final String icon, number;

  const IconNumber({Key key, @required this.icon, @required this.number})
      : super(key: key);

  @override
  _IconNumberState createState() => _IconNumberState();
}

class _IconNumberState extends State<IconNumber> {
  @override
  Widget build(BuildContext context) {
    double MQwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MQwidth * 0.135,
        child: Row(
          children: <Widget>[
            Image.asset(
              widget.icon,
              width: MQwidth * 0.034,
              height: 13,
              fit: BoxFit.cover,
            ),
            SizedBox(width: MQwidth * 0.01),
            Text(
              widget.number,
              style: TextStyle(color: Color(0xff999999), fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
