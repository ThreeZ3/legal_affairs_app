import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_course_ware_details_lawyer_page.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/publish_courseware_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';

/// ${widget.oc}的课件

class MyCourseWarePage extends StatefulWidget {
  final String id;
  final String oc;

  MyCourseWarePage(this.id, this.oc);

  @override
  _MyCourseWarePageState createState() => _MyCourseWarePageState();
}

class _MyCourseWarePageState extends State<MyCourseWarePage> {
  bool _isLoadingOk = false;
  int _goPage = 1;
  List _lectureListData = new List();
  bool _openDel = false;
  List delList = new List();

  @override
  void initState() {
    super.initState();
    getLectureListData();
    Notice.addListener(
        JHActions.lectureRefresh(), (v) => getLectureListData(true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.oc}的课件',
        rightDMActions: widget.id == JHData.id()
            ? <Widget>[
                new Visibility(
                  visible: listNoEmpty(_lectureListData),
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
                new Space(
                  width: mainSpace * 2,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    routePush(PublishCourseWarePage());
                  },
                  child: Image.asset(
                    'assets/images/mine/share_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                new Space(
                  width: mainSpace * 1.5,
                ),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: new DataView(
              isLoadingOk: _isLoadingOk,
              data: _lectureListData,
              onRefresh: () => getLectureListData(true),
              onLoad: () {
                _goPage++;
                return getLectureListData();
              },
              child: ListView(
                padding: EdgeInsets.only(top: 12),
                children: _lectureListData
                    .map((item) => LectureListItem(
                          data: item,
                          isUserId: widget.id,
                          openDel: _openDel,
                          delList: delList,
                        ))
                    .toList(),
              ),
            ),
          ),
          Visibility(
            visible: _openDel,
            child: Column(
              children: <Widget>[
                RegisterButtonWidget(
                  title: '删除',
                  horizontal: 16,
                  onTap: () => delLecture(),
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

  ///删除课件
  delLecture() {
    for (int a = 0; a < delList.length; a++) {
      lectureViewModel.lectureDel(context, id: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _openDel = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        getLectureListData(true);
      });
    });
  }

  /// 获取课件列表
  Future getLectureListData([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return lectureViewModel
        .lectureLawyerList(
      context,
      limit: 10,
      page: _goPage,
      lawyerId: widget.id,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          _lectureListData = List.from(rep.data);
        } else {
          _lectureListData.addAll(List.from(rep.data));
        }
        _isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => _isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.lectureRefresh());
  }
}

class LectureListItem extends StatefulWidget {
  final LectureListModel data;
  final String isUserId;
  final bool openDel;
  final List delList;
  final bool isBy;

  const LectureListItem({
    Key key,
    this.data,
    this.isUserId,
    this.openDel,
    this.delList,
    this.isBy = false,
  }) : super(key: key);

  @override
  _LectureListItemState createState() => _LectureListItemState();
}

class _LectureListItemState extends State<LectureListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 16),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.data.delCheck = !widget.data.delCheck;
                        if (widget.data.delCheck)
                          widget.delList.add(widget.data.id);
                        if (!widget.data.delCheck)
                          widget.delList.remove(widget.data.id);
                      });
                    },
                    child: widget.data.delCheck
                        ? Icon(
                            Icons.check_circle,
                            size: 22,
                            color: Color(0xffE1B96B),
                          )
                        : Icon(
                            Icons.panorama_fish_eye,
                            size: 22,
                            color: Colors.grey,
                          )),
              ),
        new Expanded(
            child: myLectureItem(
          item: widget.data,
          isUserId: widget.isUserId,
          isBy: widget.isBy,
        )),
      ],
    );
  }
}

//课件item
Widget myLectureItem({item, isUserId, isBy}) {
  LectureListModel model = item;
  return new GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      routePush(LawyerMyCourseWareDetailsPage(
        id: model.id,
        isUserId: isUserId,
        price: model.charges,
      ));
    },
    child: new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16.0, right: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 120,
                height: 100,
                margin: EdgeInsets.only(right: 10.0),
                child: new Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    new CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 120,
                        height: 100,
                        imageUrl: '${model?.cover ?? NETWORK_IMAGE}'),
                    new Container(
                      height: 35,
                      width: 35,
                      child: new Image.asset(
                        'assets/images/mine/video_play_icon@2x.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text(
                      model?.title ?? '暂时为空',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ThemeColors.color333,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    new SizedBox(height: 5.0),
                    new SizedBox(
                      height: 5.0,
                    ),
                    new Row(
                      children: <Widget>[
                        new Text(
                          model?.categoryName ?? '类别',
                          style: TextStyle(
                            fontSize: 14.0,
                            letterSpacing: 1.0,
                            color: ThemeColors.color999,
                          ),
                        ),
                        new Space(),
                        new Expanded(
                          child: new Text(
                            model?.createTime ?? ' ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              letterSpacing: 1.0,
                              color: Color(0xffCDCDCD),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Visibility(
                          visible: !isBy,
                          child: new Text(
                            '${(model?.isCharge ?? 0) == 0 || (model?.charges ?? 0) == 0.0 ? '免费' : '￥${formatNum(model?.charges)}'}',
                            style: TextStyle(
                                color: ThemeColors.colorRed, fontSize: 18.0),
                          ),
                        ),
                        new Space(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Space(
            height: mainSpace * 2,
          ),
        ],
      ),
    ),
  );
}
