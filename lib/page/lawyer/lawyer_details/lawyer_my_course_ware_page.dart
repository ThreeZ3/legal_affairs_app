//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
//import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
//import 'package:jh_legal_affairs/common/ui.dart';
//import 'package:jh_legal_affairs/page/mine/my_lecture/my_course_ware_details_lawyer_page.dart';
//import 'package:jh_legal_affairs/util/tools.dart';
//import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
//import 'package:jh_legal_affairs/widget_common/theme_colors.dart';
//
/////创建者：郑梓臻
///// 开发者：郑梓臻
///// 创建日期：2020-04-20
/////
///// 律师详情-我的课件
//
//class LawyerMyCourseWarePage extends StatefulWidget {
//  final String id;
//
//  const LawyerMyCourseWarePage(this.id);
//
//  @override
//  _LawyerMyCourseWarePageState createState() => _LawyerMyCourseWarePageState();
//}
//
//class _LawyerMyCourseWarePageState extends State<LawyerMyCourseWarePage> {
//  bool _isLoadingOk = false;
//  int _goPage = 1;
//  List _lectureListData = new List();
//
//  @override
//  void initState() {
//    super.initState();
//    getLectureListData();
//    print('lawyerId::::::${widget.id}');
//  }
//
//  /// 按律师获取课件列表
//  Future getLectureListData([bool isInit = false]) {
//    if (isInit) _goPage = 1;
//    return lectureViewModel
//        .lectureLawyerList(context,
//            limit: 10, page: _goPage, lawyerId: widget.id)
//        .then((rep) {
//      setState(() {
//        if (_goPage == 1) {
//          _lectureListData = List.from(rep.data);
//        } else {
//          _lectureListData.addAll(List.from(rep.data));
//        }
//        _isLoadingOk = true;
//      });
//    }).catchError((e) => showToast(context, e.message));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: NavigationBar(
//        title: '我的课件',
//      ),
//      body: new DataView(
//        isLoadingOk: _isLoadingOk,
//        data: _lectureListData,
//        onRefresh: () => getLectureListData(true),
//        onLoad: () {
//          _goPage++;
//          return getLectureListData();
//        },
//        child: ListView(
//          children: _lectureListData
//              .map((item) => LectureListItem(
//                    data: item,
//                  ))
//              .toList(),
//        ),
//      ),
//    );
//  }
//}
//
//class LectureListItem extends StatelessWidget {
//  final LectureListModel data;
//
//  const LectureListItem({Key key, this.data}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      behavior: HitTestBehavior.opaque,
//      onTap: () {
//        routePush(LawyerMyCourseWareDetailsPage(id: data.id));
//      },
//      child: new Container(
//        padding: EdgeInsets.symmetric(horizontal: 10.0),
//        child: new Column(
//          children: <Widget>[
//            new Row(
//              children: <Widget>[
//                new Container(
//                  width: 120,
//                  height: 120,
//                  margin: EdgeInsets.only(right: 10.0),
//                  child: new Stack(
//                    alignment: AlignmentDirectional.center,
//                    children: <Widget>[
//                      new Image.asset(
//                        'assets/images/mine/video_photo@3x.png',
//                        fit: BoxFit.fill,
//                      ),
//                      new Image.asset(
//                          'assets/images/mine/video_play_icon@2x.png'),
//                    ],
//                  ),
//                ),
//                new Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      new Text(
//                        data?.title ?? '暂时为空',
//                        style: TextStyle(
//                          color: ThemeColors.color333,
//                          letterSpacing: 1.0,
//                          fontWeight: FontWeight.w600,
//                          fontSize: 18.0,
//                        ),
//                      ),
//                      new SizedBox(height: 5.0),
//                      new Text(
//                        '暂时为空',
//                        maxLines: 3,
//                        overflow: TextOverflow.ellipsis,
//                        style: TextStyle(
//                          fontSize: 14.0,
//                          letterSpacing: 1.0,
//                          color: ThemeColors.color999,
//                        ),
//                      ),
//                      new SizedBox(
//                        height: 5.0,
//                      ),
//                      new Row(
//                        children: <Widget>[
//                          new Text(
//                            '民事',
//                            style: TextStyle(
//                              fontSize: 14.0,
//                              letterSpacing: 1.0,
//                              color: ThemeColors.color999,
//                            ),
//                          ),
//                          new Space(),
//                          new Text(
//                            data?.createTime ?? '暂时为空',
//                            style: TextStyle(
//                              fontSize: 14.0,
//                              letterSpacing: 1.0,
//                              color: ThemeColors.color999,
//                            ),
//                          ),
//                        ],
//                      ),
//                      new Row(
//                        children: <Widget>[
//                          new Spacer(),
//                          new Text(
//                            '￥ ${data?.charges}' ?? '0.00',
//                            style: TextStyle(
//                                color: ThemeColors.colorRed, fontSize: 14.0),
//                          ),
//                          new Space(),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
