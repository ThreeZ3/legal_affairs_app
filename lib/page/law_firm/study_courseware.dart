import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/common/win_media.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_course_ware_details_lawyer_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/checkCircle_Widget.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

///学习课件

class StudyCourseWare extends StatefulWidget {
  final String id;
  final bool isMe;

  StudyCourseWare(this.id, this.isMe);

  @override
  _StudyCourseWareState createState() => _StudyCourseWareState();
}

class _StudyCourseWareState extends State<StudyCourseWare> {
  List<LectureListModel> courseList;
  List delList = new List();
  int page = 1;
  bool isLoadingOk = false;
  bool _openDel = false;

  @override
  void initState() {
    super.initState();
    courseList = new List();
    getData();
    print('id======>${widget.id}');
  }

  Future getData() async {
    await lectureViewModel
        .lectureFirm(
      context,
      limit: 10,
      page: page,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        isLoadingOk = true;
        listNoEmpty(rep.data)
            ? courseList.addAll(List.from(rep.data))
            : showToast(context, "没有更多的数据了");
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  ///删除课件
  delLecture() {
    for (int a = 0; a < delList.length; a++) {
      lectureViewModel.lectureDel(context, id: delList[a]).then((v) {
        setState(() {
          getData();
          _openDel = false;
          delList = new List();
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
          title: "学习课件",
          rightDMActions: widget.isMe
              ? <Widget>[
                  listNoEmpty(courseList)
                      ? GestureDetector(
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
                        )
                      : Container(),
                  new SizedBox(
                    width: 15,
                  ),
                ]
              : []),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DataView(
              isLoadingOk: isLoadingOk,
              data: courseList,
              onLoad: () {
                page++;
                return getData();
              },
              onRefresh: () {
                courseList.clear();
                page = 1;
                return getData();
              },
              child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: courseList.map((v) {
                    return StudyWidget(
                      openDel: _openDel,
                      delList: delList,
                      data: v,
                    );
                  }).toList()),
            ),
          ),
          Visibility(
            visible: _openDel,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: MagicBt(
                      onTap: () {
                        delLecture();
                        setState(() {});
                      },
                      text: '删除',
                      radius: 5.0,
                      height: 40,
                      color: Color.fromRGBO(225, 185, 107, 1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: MagicBt(
                      onTap: () {
                        setState(() {
                          _openDel = false;
                        });
                      },
                      text: '取消',
                      radius: 5.0,
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
}

class StudyWidget extends StatefulWidget {
  final LectureListModel data;
  final bool openDel;
  final List delList;

//todo 数据未完善
  const StudyWidget({Key key, this.data, this.openDel, this.delList})
      : super(key: key);

  @override
  _StudyWidgetState createState() => _StudyWidgetState();
}

class _StudyWidgetState extends State<StudyWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : CheckCircle(
                value: widget.data.delCheck,
                onTap: () {
                  setState(() {
                    widget.data.delCheck = !widget.data.delCheck;
                    if (widget.data.delCheck)
                      widget.delList.add(widget.data.id);
                    if (!widget.data.delCheck)
                      widget.delList.remove(widget.data.id);
                  });
                },
              ),
        Expanded(
          child: InkWell(
            onTap: () => routePush(LawyerMyCourseWareDetailsPage(
              id: widget.data.id,
              price: widget.data.charges,
            )),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 104,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/home/play.png",
                              width: 33,
                              height: 33,
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: widget.data.cover ?? NETWORK_IMAGE,
                            width: 104,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      new Expanded(
                        child: Container(
                          //height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.data?.title ?? "标题",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: !widget.openDel
                                    ? winWidth(context) - 157
                                    : winWidth(context) - 183,
                                child: Text(
                                  widget.data?.content ??
                                      "学习法律，考律师证的， 杨老师帮你打好基础,律师资格考试取消，律师、法官、检察官和公证员的职业证书的考试...",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xffFF999999), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: strNoEmpty(widget.data?.lawyerAvatar)
                            ? CachedNetworkImage(
                                imageUrl: widget.data?.lawyerAvatar,
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              )
                            : new Image.asset(
                                avatarLawyerMan,
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8, right: 12),
                        child: Text(
                          "${widget.data?.lawyerName ?? '未知昵称'}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFF333333)),
                        ),
                      ),
                      Image.asset(
                        "assets/images/lawyer/dang.png",
                        width: 10,
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          "${widget.data?.subscribeCount ?? '0'}",
                          style: TextStyle(
                            color: Color(0xffFF999999),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(widget.data?.isCharge ?? 0) == 0 || (widget.data?.charges ?? 0) == 0.0 ? '免费' : '¥ ${formatNum(widget.data?.charges)}'}",
                        style:
                            TextStyle(color: Color(0xffFFD9001B), fontSize: 14),
                      )
                    ],
                  ),
                  Space(),
                  HorizontalLine(height: 1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
