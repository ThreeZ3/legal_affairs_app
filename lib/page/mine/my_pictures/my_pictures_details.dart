import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_model.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_view_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';

class MyPicturesDetails extends StatefulWidget {
  final String id;

  const MyPicturesDetails({Key key, this.id}) : super(key: key);

  @override
  _MyPicturesDetailsState createState() => _MyPicturesDetailsState();
}

class _MyPicturesDetailsState extends State<MyPicturesDetails> {
  GlobalKey depositRepaintKey = GlobalKey();
  SketchDetailsModel data = new SketchDetailsModel();
  bool _start = false;
  List talkList = [];
  VideoPlayerController cHead;
  VideoPlayerController cFoot;
  VideoPlayerController defC;

  //获取详情
  _getSketchDetail() {
    sketchViewModel
        .sketchDetail(
      context,
      id: widget.id,
    )
        .then((rep) {
      data = rep.data;
      _start = true;
      if (strNoEmpty(data.headUrl)) {
        cHead = VideoPlayerController.network(data != null
            ? data.headUrl
            : 'https://www.w3school.com.cn/example/html5/mov_bbb.mp4')
          ..initialize().then((_) {
            setState(() {});
//          _videoPlayerController.play();
          });
      }
      if (strNoEmpty(data?.footUrl)) {
        cFoot = VideoPlayerController.network(data != null
            ? data?.footUrl
            : 'https://www.w3school.com.cn/example/html5/mov_bbb.mp4')
          ..initialize().then((_) {
            setState(() {});
//          _videoPlayerController.play();
          });
      }
      setState(() {});
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  handle(id, bool isThumbsUp) {
    if (isThumbsUp) {
      agreementCommentsCancel(id);
    } else {
      postZan(id);
    }
  }

  ///给评论点赞
  void postZan(String id) {
    caseViewModel
        .agreementComments(context, typeId: id)
        .catchError((e) => showToast(context, e.message));
  }

  ///删除评论
  postCommentDel(id) {
    caseViewModel.commentDel(context, id).then((rep) {
      showToast(context, '删除成功');
      getTalkList();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  /// 取消评论点赞
  Future agreementCommentsCancel(String id) async {
    return caseViewModel
        .cancelCommentAgree(
      context,
      typeId: id,
    )
        .catchError((e) {
      return showToast(context, e.message);
    });
  }

  setRed() => sketchViewModel.sketchRead(context, id: widget.id);

  setShare() => sketchViewModel.sketchShare(context, id: widget.id);

  ///请求图文评论列表
  ///分页获取（课件评论，律师评论,图文评论，案例评论）
  void getTalkList() {
    ///获取评论列表
    caseViewModel
        .caseCommentList(context, id: widget.id, page: 1, limit: 15)
        .then((rep) {
      setState(() {
        talkList = rep.data;
      });
    }).catchError((e) => showToast(context, e.message));
  }

  void _saveImage() async {
    var imgBytes;
    _capturePng().then((data) {
      imgBytes = data;
      _upLoadFile(imgBytes);
    });
  }

  /// 截图
  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          depositRepaintKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      return pngBytes;
    } catch (e) {
      print(e);
      return e;
    }
  }

  _upLoadFile(image) {
    if (image == null) return;
    systemViewModel.uploadUint8ListImage(context, uint8List: image).then((rep) {
      if (strNoEmpty(rep.data["data"].toString())) {
        setShare();
        Share.share(
            'http://fazhikeji.cn/shareArticle.html?img=${rep.data["data"].toString()}&data=123456789');
      } else {
        showToast(context, '分享失败');
      }
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  commentDialog(context, id) {
    TextEditingController textEditingController = new TextEditingController();

    ///新增评论
    Future postNewTalkData(String content, id) async {
      await caseViewModel
          .caseNewComment(
        context,
        content: content,
        targetId: id,
        type: 2,
      )
          .then((rep) {
        showToast(context, '发表成功');
        pop();
        getTalkList();
      }).catchError((e) => showToast(context, e.message));
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      Container(
                        //height: 20,
                        margin: EdgeInsets.only(top: 8, bottom: 16),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff666666)),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "写评论",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            new InkWell(
                              child: Text(
                                "发布",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFE1B96B),
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () => postNewTalkData(
                                  textEditingController.text, id),
                            ),
                          ],
                        ),
                      ),
                      new Expanded(
                          child: TextField(
                        controller: textEditingController,
                        maxLines: null,
                        expands: true,
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: "您的评论对所有人可见",
                            hintStyle: TextStyle(
                                color: Color(0xff999999), fontSize: 14),
                            border: InputBorder.none),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _getSketchDetail();
    getTalkList();
    setRed();
    defC = VideoPlayerController.network(
        'https://www.w3school.com.cn/example/html5/mov_bbb.mp4')
      ..initialize().then((_) {
        setState(() {});
//          _videoPlayerController.play();
      });
    Notice.addListener(JHActions.commentRefresh(), (v) => getTalkList());
  }

  @override
  Widget build(BuildContext context) {
    //SketchDetailModel _sketchDetailModel = data.data;
    return RepaintBoundary(
      key: depositRepaintKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NavigationBar(
          title: '图文详情',
          rightDMActions: <Widget>[
            InkWell(
              child: new Container(
                width: 60,
                height: 26,
                margin: EdgeInsets.symmetric(vertical: 13),
                child: Image.asset('assets/images/lawyer/share1.png',
                    width: 20.0, height: 20, color: Color(0xffdcba76)),
              ),
              onTap: () {
                _saveImage();
              },
            )
          ],
        ),
        body: !_start
            ? Container()
            : ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16),
                        Container(
                          child: Text(
                            data?.title ?? '未知标题',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 28,
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            children: <Widget>[
                              ClipOval(
                                child: strNoEmpty(data?.lawyerAvatar)
                                    ? Image.network(
                                        data?.lawyerAvatar,
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                      )
                                    : new Image.asset(
                                        avatarLawyerMan,
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(width: 16),
                              Text(
                                data?.lawyerName ?? "未知",
                                style: TextStyle(
                                    color: Color(0xff999999), fontSize: 12),
                              ),
                              SizedBox(width: 16),
                              Text(
                                '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble((data?.createTime ?? 0) / 1000), 'yyyy-MM-dd') ?? '未知时间'}',
                                style: TextStyle(
                                    color: Color(0xff999999), fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                data?.categoryName ?? "未知",
                                style: TextStyle(
                                    color: Color(0xff999999), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 23),
                        new Offstage(
                          offstage: !strNoEmpty(data?.headUrl),
                          child: AspectRatio(
                            aspectRatio: cHead?.value?.aspectRatio ?? 3 / 2,
                            child: Chewie(
                              controller: ChewieController(
                                  videoPlayerController: cHead ?? defC,
                                  aspectRatio:
                                      cHead?.value?.aspectRatio ?? 3 / 2),
                            ),
//                       child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                        SizedBox(height: 23),
                        new EditRichShow(json: data?.detail ?? "无详情内容~"),
                        SizedBox(height: 23),
                        new Offstage(
                          offstage: !strNoEmpty(data?.footUrl),
                          child: AspectRatio(
                            aspectRatio: cFoot?.value?.aspectRatio ?? 3 / 2,
                            child: Chewie(
                              controller: ChewieController(
                                  videoPlayerController: cFoot ?? defC,
                                  aspectRatio:
                                      cFoot?.value?.aspectRatio ?? 3 / 2),
                            ),
//                       child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                        SizedBox(height: 30),
                        //赞成与反对
                        new IsLikeBar(id: widget.id),
                        SizedBox(height: 24),
                        //评论
                        Container(
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "评论",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff999999)),
                              ),
                              SizedBox(width: 16),
                              //评论数
                              Text(
                                "${talkList.length}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff999999)),
                              ),
                              Spacer(),
                              //写评论
                              GestureDetector(
                                onTap: () {
                                  if (JHData.isLogin()) {
                                    commentDialog(context, widget.id);
                                  } else {
                                    routePush(new LoginPage());
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "评论",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff999999)),
                                    ),
                                    SizedBox(width: 4),
                                    Image.asset(
                                        "assets/images/lawyer/pinglun.png",
                                        width: 14,
                                        height: 14,
                                        fit: BoxFit.cover),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //评论内容
                        listNoEmpty(talkList)
                            ? Column(
                                children:
                                    List.generate(talkList.length, (index) {
                                  CaseCommentListModel model = talkList[index];
                                  bool choose = model.isThumbsUp;
                                  return CommentDel(
                                    model: model,
                                    choose: choose,
                                    like: () {
                                      if (!choose) {
                                        setState(() {
                                          postZan(model.id);
                                          choose = !choose;
                                        });
                                      }
                                    },
                                    del: () => postCommentDel(model.id),
                                  );
                                }),
                              )
                            : new NoDataView(label: '暂无数据'),
                        SizedBox(height: 16),
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
    if (cHead != null) cHead.dispose();
    if (cFoot != null) cFoot.dispose();
    defC.dispose();
    Notice.removeListenerByEvent(JHActions.commentRefresh());
  }
}

class CommentDel extends StatefulWidget {
  final CaseCommentListModel model;
  final bool choose;
  final GestureTapCallback like;
  final GestureTapCallback del;

  const CommentDel({
    Key key,
    this.model,
    this.choose,
    this.like,
    this.del,
  }) : super(key: key);

  @override
  _CommentDelState createState() => _CommentDelState();
}

class _CommentDelState extends State<CommentDel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //评论者头像
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      widget.model.avatar,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              //评论者名字内容时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20,
                    child: Text(
                      "${widget.model.nickName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff333333)),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: winWidth(context) - (16 * 2 + 40 + 8 + 10 + 24),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.model?.content ?? '未知内容'}",
                      maxLines: 50,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 20,
                    child: new Text(
                      '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(widget.model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 10),
          //点赞数
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: widget.like,
                child: Container(
                  height: 35,
                  width: 24,
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        widget.choose
                            ? "assets/images/lawyer/ynice.png"
                            : "assets/images/lawyer/wnice.png",
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 3),
                      Offstage(
                        offstage: !widget.choose,
                        child: Text(
                          "${widget.model.likeCount}",
                          /*key: _key,*/
                          style: TextStyle(
                            color: Color(0xffFFE1B96B),
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              widget.model.userId == JHData.id()
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
    );
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
  int likeStatus;
  String like;
  String dislike;
  bool isClick = false;
  SketchDetailsModel data = new SketchDetailsModel();

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future getDetails() {
    ///获取详情
    return sketchViewModel
        .sketchDetail(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        data = rep.data;
        likeStatus = data?.likeStatus ?? 0;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///评论（点赞/反对） 1支持  2反对
  Future caseOpinion(int status) async {
    if (isClick) {
      return null;
    } else {
      isClick = true;
    }

    return caseViewModel
        .praiseArticle(
      context,
      sketchId: widget.id,
      status: status,
    )
        .then((rep) {
      setState(() {
        _likeHandle(likeStatus, status, data);
        likeStatus = rep.data['data'];
        isClick = false;
      });
    }).catchError((e) {
      showToast(context, e.message);
      isClick = false;
    });
  }

  void _likeHandle(currentLikeStatus, oldStatus, model) {
    if (currentLikeStatus == 2 && oldStatus == 1) {
      model.dislike--;
      model.like++;
    } else if (currentLikeStatus == 2 && oldStatus == 2) {
      model.dislike--;
    } else if (currentLikeStatus == 1 && oldStatus == 2) {
      model.like--;
      model.dislike++;
    } else if (currentLikeStatus == 1 && oldStatus == 1) {
      model.like--;
    } else if (currentLikeStatus == 0 && oldStatus == 1) {
      model.like++;
    } else if (currentLikeStatus == 0 && oldStatus == 2) {
      model.dislike++;
    }
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
            onTap: () => JHData.isLogin()
                ? caseOpinion(item['status'])
                : routePush(LoginPage()),
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
                  new SizedBox(height: 2.0),
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
                      new SizedBox(width: 3),
                      GestureDetector(
                        child: Text(
                          item['title'] == '支持'
                              ? data.like.toString() ?? '0'
                              : data.dislike.toString() ?? '0',
                          style: TextStyle(
                              color: item['isLike']
                                  ? Colors.white
                                  : ThemeColors.color999),
                        ),
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
