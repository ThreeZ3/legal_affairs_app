import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_courseware_subscription_page.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:share/share.dart';

/// （律师详情）我的课件-课件详情---------（待优化）

class LawyerMyCourseWareDetailsPage extends StatefulWidget {
  final String id;
  final String isUserId;
  final double price;

  const LawyerMyCourseWareDetailsPage(
      {Key key, this.id, this.isUserId, this.price})
      : super(key: key);

  @override
  _LawyerMyCourseWareDetailsPageState createState() =>
      _LawyerMyCourseWareDetailsPageState();
}

class _LawyerMyCourseWareDetailsPageState
    extends State<LawyerMyCourseWareDetailsPage> {
  List _lectureCommentList = new List();
  LectureDetailsModel _model;
  List otherList = [];

  void getLectureDetails() {
    ///获取课件详情-律师部分
    lectureViewModel.lectureDetails(context, id: widget.id).then((rep) {
      setState(() {
        _model = rep.data;
      });
    }).catchError((e) {
      print("${e.toString()}");
      return showToast(context, e.message);
    });
  }

  ///获取其他课件列表
  Future getOtherList() async {
    await lectureViewModel.lectureOtherList(context).then((v) {
      setState(() {
        otherList = v.data;
      });
    }).catchError((e) => showToast(context, e.message));
  }

  ///请求课件评论列表
  ///分页获取（课件评论，律师评论,图文评论，案例评论）
  void getCommentList() {
    caseViewModel
        .caseCommentList(context, id: widget.id, page: 1, limit: 10)
        .then((rep) {
      setState(() {
        _lectureCommentList = rep.data;
      });
    }).catchError((e) => showToast(context, e.message));
  }

  ///删除评论
  postCommentDel(id) {
    caseViewModel.commentDel(context, id).then((rep) {
      showToast(context, '删除成功');
      getCommentList();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///课件订阅
  Future lectureSubFree() async {
    lectureViewModel
        .lectureSub(
      context,
      id: widget.id,
      isCharge: (_model?.isCharge ?? 0) == 1,
      price: widget.price.toString(),
    )
        .catchError((e) {
      if (e?.message != null) {
        showToast(context, e.message);
      }
    });
  }

  ///写评论弹窗
  _openBottomSheet(String id) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CaseCommentWrite(
              caseId: id,
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getLectureDetails();
    getOtherList();
    getCommentList();
    Notice.addListener(JHActions.payRefresh(), (v) => getLectureDetails());
    Notice.addListener(JHActions.commentRefresh(), (v) => getCommentList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '课件详情',
        rightDMActions: <Widget>[
          new InkWell(
            onTap: () {
              Share.share('test123');
            },
            child: Image.asset(
              'assets/images/mine/share_icon.png',
              width: 20,
            ),
          ),
          new SizedBox(width: 15)
        ],
      ),
      body: MainInputBody(
        child: !strNoEmpty(_model?.cover)
            ? new LoadingView()
            : ListView(
                children: <Widget>[
                  //课件详情
                  new Column(
                    children: <Widget>[
                      new InkWell(
                        child: new Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 200,
                              child: new CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '${_model?.cover ?? NETWORK_IMAGE}'),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              child: new Image.asset(
                                'assets/images/mine/video_play_icon@2x.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (!JHData.isLogin()) {
                            routePush(new LoginPage());
                          } else if (!_model.subscribeStatus &&
                              _model.isCharge == 1) {
                            lectureSubFree();
                          } else if (!_model.subscribeStatus) {
                            showToast(context, '请先订阅');
                          } else {
                            String _content = _model?.content ?? '';
                            bool isContent = _content.startsWith('https://') &&
                                _content.endsWith('.mp4');
                            routePush(new VideoPlayPage(
                              isContent ? _model.content : _model.videoUrl,
                              null,
                              null,
                            ));
                          }
                        },
                      ),
                      Space(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              _model?.title ?? '未知',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Space(),
                            new Row(
                              children: <Widget>[
                                new Container(
                                  width: 25,
                                  height: 25,
                                  child: new Container(
                                      width: 24,
                                      height: 24,
                                      margin: EdgeInsets.only(right: 5.0),
                                      child: new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            'assets/images/mine/user_avatar@3x.png'),
                                      )),
                                ),
                                Space(),
                                new Expanded(
                                    child: Text(
                                  '${_model?.realName ?? '未知'}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: ThemeColors.color999),
                                )),
                                Text(
                                  '${_model?.categoryName ?? '类别'}',
                                  style: TextStyle(color: ThemeColors.color999),
                                ),
                                Spacer(),
                                Text(
                                  '${_model?.createTime ?? '未知'}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: ThemeColors.color999),
                                ),
                              ],
                            ),
                            Space(),
                            new Text(
                              /*'${_model?.content ?? '未知'}',*/
                              '${_model?.content ?? '暂无介绍'}',
                              style: _model.content != null
                                  ? TextStyle(color: ThemeColors.color444)
                                  : TextStyle(color: ThemeColors.color999),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      widget.isUserId != null
                          ? widget.isUserId != JHData.id()

                              ///非发布者
                              ? new SubscriptionButton(
                                  id: widget.id,
                                  isCharge: (_model?.isCharge ?? 0) == 1,
                                  price: widget.price,
                                  model: _model,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 5.0,
                                          color: ThemeColors.colorDivider),
                                      top: BorderSide(
                                          width: 5.0,
                                          color: ThemeColors.colorDivider),
                                    ),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      onTap: () {
                                        routePush(MyCourseWareSubscriptionPage(
                                          id: widget.id,
                                        ));
                                      },
                                      leading: Text(
                                        '订阅情况',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                )
                          : new SubscriptionButton(
                              id: widget.id,
                              isCharge: (_model?.isCharge ?? 0) == 1,
                              price: widget.price,
                              model: _model,
                            ),
                      SizedBox(height: 20),
                      //支持反对
                      IsLikeBar(id: widget.id),
                    ],
                  ),
                  new SizedBox(height: 30),
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "其他课件",
                      style: TextStyle(
                          color: Color(0xffFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: otherList.map((v) {
                      return OtherWidget(
                        data: v,
                      );
                    }).toList(),
                  ),
                  new Space(),
                  //评论
                  new Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text(
                              '评论',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            new Space(),
                            new Text(
                              '${_lectureCommentList.length.toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            new Spacer(),
                            new InkWell(
                              onTap: () {
                                !JHData.isLogin()
                                    ? routePush(new LoginPage())
                                    : _openBottomSheet(widget.id);
                              },
                              child: Row(
                                children: <Widget>[
                                  new Text(
                                    '评论',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 5.0,
                                  ),
                                  new Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: ThemeColors.color999,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Space(),
                        listNoEmpty(_lectureCommentList)
                            ? new Column(
                                children: _lectureCommentList.map((item) {
                                return CaseCommentItem(
                                  data: item,
                                  del: () => postCommentDel(item.id),
                                );
                              }).toList())
                            : new NoDataView(
                                label: '暂无数据',
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.payRefresh());
    Notice.removeListenerByEvent(JHActions.commentRefresh());
  }
}

///支持反对Bar
class IsLikeBar extends StatefulWidget {
  final String id;

  IsLikeBar({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _IsLikeBarState createState() => _IsLikeBarState();
}

class _IsLikeBarState extends State<IsLikeBar> {
  LectureDetailsModel data = new LectureDetailsModel();
  bool isClick = false;

  int likeStatus;
  int likeCount;
  int disLikeCount;

  @override
  void initState() {
    super.initState();
    getLectureDetails();
  }

  void getLectureDetails() {
    ///获取课件详情-律师部分
    lectureViewModel.lectureDetails(context, id: widget.id).then((rep) {
      setState(() {
        data = rep.data;
        likeStatus = data.likeStatus;
        likeCount = data.likeCount;
        likeCount = data.dislikeCount;
      });
    }).catchError((e) {
      print("${e.toString()}");
      return showToast(context, e.message);
    });
  }

  ///课件评论（点赞/反对） 1支持  2反对
  Future caseOpinion(int status) async {
    if (isClick) {
      return null;
    } else {
      isClick = true;
    }
    return lectureViewModel
        .lectureAttitude(
      context,
      id: widget.id,
      status: status,
    )
        .then((rep) {
      setState(() {
        likeHandle(likeStatus, status, data);
        likeStatus = rep.data['data'];
        isClick = false;
      });
    }).catchError((e) {
      isClick = false;
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    List _isLikeBar = [
      {
        'title': '支持',
        'isLike': likeStatus == 1,
        'status': 1,
      },
      {
        'title': '反对',
        'isLike': likeStatus == 2,
        'status': 2,
      },
    ];

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _isLikeBar.map((item) {
          return InkWell(
            onTap: () {
              !JHData.isLogin()
                  ? routePush(new LoginPage())
                  : caseOpinion(item['status']);
            },
            child: new Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: item['isLike'] ? ThemeColors.colorOrange : null,
                  border: item['isLike']
                      ? null
                      : Border.all(color: ThemeColors.color999),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    item['title'],
                    style: TextStyle(
                        color: item['isLike']
                            ? Colors.white
                            : ThemeColors.color999),
                  ),
                  new SizedBox(
                    height: 2.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        item['title'] != '支持'
                            ? Icons.thumb_down
                            : Icons.thumb_up,
                        size: 14,
                        color: item['isLike']
                            ? Colors.white
                            : ThemeColors.color999,
                      ),
                      new SizedBox(
                        width: 3,
                      ),
                      Text(
                        item['title'] == '支持'
                            ? data?.likeCount.toString() ?? '未知'
                            : data?.dislikeCount.toString() ?? '未知',
                        style: TextStyle(
                            color: item['isLike']
                                ? Colors.white
                                : ThemeColors.color999),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList());
  }
}

///用户评论
class CaseCommentItem extends StatefulWidget {
  final CaseCommentListModel data;
  final GestureTapCallback del;

  const CaseCommentItem({Key key, this.data, this.del}) : super(key: key);

  @override
  _CaseCommentItemState createState() => _CaseCommentItemState();
}

class _CaseCommentItemState extends State<CaseCommentItem> {
  handle() {
    if (widget.data.isThumbsUp) {
      agreementCommentsCancel();
    } else {
      agreementComments();
    }
  }

  /// 评论点赞
  Future agreementComments() async {
    return lectureViewModel
        .agreeLectureComments(
      context,
      typeId: widget.data.id,
    )
        .catchError((e) {
      return showToast(context, e.message);
    });
  }

  /// 取消评论点赞
  Future agreementCommentsCancel() async {
    return caseViewModel
        .cancelCommentAgree(
      context,
      typeId: widget.data.id,
    )
        .catchError((e) {
      return showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Space(height: mainSpace / 2),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              child: new CircleAvatar(
                radius: 50 / 2,
                backgroundImage: CachedNetworkImageProvider(
                    widget.data.avatar ?? NETWORK_IMAGE),
              ),
            ),
            new Space(),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    '${widget.data.nickName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  new Space(height: mainSpace / 3),
                  new Text('${widget.data.content}'),
                  new Space(height: mainSpace / 3),
                  new Text(
                    '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(widget.data.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => handle(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        widget.data.isThumbsUp
                            ? "assets/images/lawyer/ynice.png"
                            : "assets/images/lawyer/wnice.png",
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                      new Text(
                        widget.data?.likeCount.toString() ?? '0',
                        style: TextStyle(
                          color: widget.data.isThumbsUp
                              ? ThemeColors.colorOrange
                              : ThemeColors.colorOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                widget.data.userId == JHData.id()
                    ? GestureDetector(
                        onTap: widget.del,
                        child: Text(
                          '删除',
                          style: TextStyle(
                              color: ThemeColors.color999, fontSize: 12),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

///写评论
class CaseCommentWrite extends StatefulWidget {
  final String caseId;

  const CaseCommentWrite({Key key, this.caseId}) : super(key: key);

  @override
  _CaseCommentWriteState createState() => _CaseCommentWriteState();
}

class _CaseCommentWriteState extends State<CaseCommentWrite> {
  TextEditingController _textC = new TextEditingController();

  ///新增课件评论
  void addCaseComment() {
    caseViewModel
        .caseComment(
          context,
          targetId: widget.caseId,
          content: _textC.text,
          type: 0, //0为课件评论
        )
        .catchError((e) => showToast(context, e.message));
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new CupertinoButton(
                  child: new Text(
                    '取消',
                    style: TextStyle(color: ThemeColors.color999),
                  ),
                  onPressed: () {
                    pop();
                  }),
              new Text(
                '写评论',
                style: TextStyle(fontSize: 18.0),
              ),
              new CupertinoButton(
                child: new Text(
                  '确认',
                  style: TextStyle(color: ThemeColors.colorOrange),
                ),
                onPressed: addCaseComment,
              ),
            ],
          ),
          new Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(color: ThemeColors.color999),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  width: MediaQuery.of(context).size.width / 1.3,
                  padding: EdgeInsets.only(left: 15.0),
                  child: new TextField(
                    controller: _textC,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        height: 1,
                      ),
                      border: InputBorder.none,
                      hintText: '请输入评论...',
                    ),
                  ),
                ),
                new Space(),
                new IconButton(
                    icon: Icon(
                      Icons.sentiment_very_satisfied,
                      size: 32,
                      color: ThemeColors.color999,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///非发布者订阅Bar
class SubscriptionButton extends StatefulWidget {
  final String id;
  final double price;
  final bool isCharge;
  final LectureDetailsModel model;

  const SubscriptionButton({
    Key key,
    this.id,
    this.isCharge,
    this.price,
    this.model,
  }) : super(key: key);

  @override
  _SubscriptionButtonState createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  @override
  void initState() {
    super.initState();
    Notice.addListener(JHActions.isSubscription(), (v) {
      setState(() {
        widget.model?.subscribeStatus = true;
      });
    });
    Notice.addListener(JHActions.noSubscription(), (v) {
      setState(() {
        widget.model?.subscribeStatus = false;
      });
    });
  }

  ///课件订阅
  Future lectureSubFree() async {
    lectureViewModel
        .lectureSub(
      context,
      id: widget.id,
      isCharge: widget.isCharge,
      price: widget.price.toString(),
    )
        .catchError((e) {
      if (e?.message != null) {
        showToast(context, e.message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.noSubscription());
    Notice.removeListenerByEvent(JHActions.isSubscription());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: new FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        color: (widget.model?.subscribeStatus ?? false)
            ? !(widget.model?.subscribeStatus ?? false)
                ? ThemeColors.colorOrange
                : ThemeColors.color999
            : ThemeColors.colorOrange,
        onPressed: widget.model?.subscribeStatus ?? false
            ? () {
                !JHData.isLogin()
                    ? routePush(new LoginPage())
                    : showToast(context, '请勿重复订阅');
              }
            : () {
                !JHData.isLogin()
                    ? routePush(new LoginPage())
                    : lectureSubFree();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (widget.model?.subscribeStatus ?? false)
                ? !(widget.model?.subscribeStatus ?? false)
                    ? Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      )
                    : Container()
                : Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
            Text(
              (widget.model?.subscribeStatus ?? false)
                  ? !(widget.model?.subscribeStatus ?? false) ? '立即订阅' : '已订阅'
                  : '立即订阅',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//其他课件组件
class OtherWidget extends StatelessWidget {
  final LecturesOtherModel data;

  const OtherWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => routePush(LawyerMyCourseWareDetailsPage(
        id: data.id,
        price: data.charges,
      )),
      child: Container(
        padding: EdgeInsets.only(bottom: 12, left: 14, right: 14),
        child: Row(
          children: <Widget>[
            Image.network(
              data?.cover ?? NETWORK_IMAGE,
              width: 104,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    data.content ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xffFF999999), fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: <Widget>[
                Text(
                  "￥ ${formatNum(data.charges) ?? '0.00'}",
//                  "￥ ${double.parse(data?.charges.toString() ?? '0.0').toStringAsFixed(4)}",
                  style: TextStyle(color: Color(0xffFFD9001B), fontSize: 14),
                ),
                Space(),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 2, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Color(0xffFFE1B96B),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    "详情",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
