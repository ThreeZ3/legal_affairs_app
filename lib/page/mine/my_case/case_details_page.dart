import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:share/share.dart';

/// 我的案例-案例详情

class CaseDetailsPage extends StatefulWidget {
  final String id;
  final String no;
  final String url;

  const CaseDetailsPage({Key key, this.id, this.no, this.url})
      : super(key: key);

  //详情字体
  static Diagnosticable _style = TextStyle(
    fontSize: 12.0,
    color: ThemeColors.color333,
    fontWeight: FontWeight.w500,
  );

  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  List _caseCommentList = new List();

  CaseDetailsModel model = new CaseDetailsModel();

  @override
  void initState() {
    super.initState();
    getCaseDetails();
    getCommentList();
    Notice.addListener(JHActions.commentRefresh(), (v) => getCommentList());
    Notice.addListener(JHActions.commentClicked(), (v) => getCaseDetails());
  }

  void getCaseDetails() {
    ///获取案例详情
    caseViewModel.caseDetailsList(context, id: widget.id).then((rep) {
      setState(() {
        model = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///请求案例评论列表
  void getCommentList() {
    caseViewModel
        .caseCommentList(context, id: widget.id, page: 1, limit: 10)
        .then((rep) {
      setState(() {
        _caseCommentList = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.commentRefresh());
    Notice.removeListenerByEvent(JHActions.commentClicked());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: '案例详情',
        rightDMActions: <Widget>[
          new IconButton(
            icon: Image.asset(
              'assets/images/mine/share_icon.png',
              width: 19,
            ),
            onPressed: () {
              Share.share('test');
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          new Space(),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  model?.title ?? "标题",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              new Space(),
              _yellowWord(
                  '${listNoEmpty(model?.trialStage?.split(';')) ? model?.trialStage?.split(';')[1] ?? '阶段' : ''}'),
            ],
          ),
          new Space(),
          Row(
            children: <Widget>[
              ClipOval(
                child: new CachedNetworkImage(
                  imageUrl: model?.avatar ?? NETWORK_IMAGE,
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
              ),
              new SizedBox(
                width: 5,
              ),
              _smallGrayWord('${model?.realName ?? '未知'}'),
              new Space(),
              _label('${model?.categoryName ?? "类别"}'),
              new Space(),
              new Expanded(
                  child: _smallGrayWord(
                '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(int.parse(model?.createTime?.toString() ?? '0') / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
              )),
              Space(),
              _redWord('${formatNum(model.value) ?? "0"}')
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                    child: _smallGrayWord("经办院：${model?.court ?? " "}")),
                Space(),
                _smallGrayWord("审判长：${model?.judge ?? " "}"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                  child: _yellowWord(
                      strNoEmpty(widget.url) ? widget.url : model?.url ?? "")),
              Space(),
              _yellowWord(
                  "编号：${strNoEmpty(widget.no) ? widget.no : model?.no ?? ""}"),
            ],
          ),
          new Space(),
          new EditRichShow(json: model.detail),
          SizedBox(
            height: 20,
          ),
          //支持反对
          IsLikeBar(
            id: widget.id,
          ),
          SizedBox(
            height: 12,
          ),
          new SizedBox(height: 30),
          //评论模块
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
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
                      '${_caseCommentList.length.toString()}',
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
                listNoEmpty(_caseCommentList)
                    ? new Column(
                        children: _caseCommentList.map((item) {
                        return CaseCommentItem(
                          data: item,
                        );
                      }).toList())
                    : new NoDataView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTitle(String str) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        "$str",
        style: TextStyle(color: Color(0xffFF000000), fontSize: 16),
      ),
    );
  }

  Widget _context(String str) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        "$str",
        style: TextStyle(color: Color(0xffFF666666), fontSize: 14),
      ),
    );
  }

  Widget _yellowWord(String str) {
    return Text(
      "$str",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xffFFE1B96B), fontSize: 12),
    );
  }

  Widget _redWord(String str) {
    return Text(
      "￥ $str",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xffFFD9001B), fontSize: 12),
    );
  }

  Widget _smallGrayWord(String context) {
    return Text(
      "$context",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xffFF999999), fontSize: 14),
    );
  }

  Widget _label(String str) {
    return new Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ThemeColors.color999.withOpacity(0.2),
        )
      ]),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
        child: new Text(
          '$str',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color.fromRGBO(225, 185, 107, 1), fontSize: 12.0),
        ),
      ),
    );
  }

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
  String likeCount;
  String disLikeCount;
  bool isClick = false;
  CaseDetailsModel data = new CaseDetailsModel();

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future getDetails() {
    ///获取详情
    return caseViewModel
        .caseDetailsList(
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
  Future opinion(int status) async {
    if (isClick) {
      return null;
    } else {
      isClick = true;
    }

    return caseViewModel
        .caseAttitude(
      context,
      caseId: widget.id,
      status: status,
    )
        .then((rep) {
      setState(() {
        likeHandle(likeStatus, status, data);
        likeStatus = rep.data['data'];
        isClick = false;
      });
    }).catchError((e) {
      showToast(context, e.message);
      isClick = false;
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
                  : opinion(item['status']);
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
                              ? data?.likeCount.toString() ?? '0'
                              : data?.dislikeCount.toString() ?? '0',
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

///我的案例
///用户评论
///
class CaseCommentItem extends StatefulWidget {
  final CaseCommentListModel data;

  const CaseCommentItem({Key key, this.data}) : super(key: key);

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
    return caseViewModel
        .agreementComments(
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
                backgroundImage: NetworkImage(
                    '${widget.data?.avatar}' ?? '${JHData.avatar()}'),
              ),
            ),
            new Space(),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    '${widget.data?.nickName}' ?? 'null',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  new Space(height: mainSpace / 3),
                  new Text(
                    '${widget.data?.content}' ?? 'null',
                  ),
                  new Space(height: mainSpace / 9),
                  new Container(
                    child: new Text(
                      '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(widget.data.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            new Space(),
            new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    !JHData.isLogin() ? routePush(new LoginPage()) : handle(),
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
                )),
          ],
        ),
      ],
    );
  }
}

///案例详情评论
///写评论
///

class CaseCommentWrite extends StatefulWidget {
  final String caseId;

  const CaseCommentWrite({Key key, this.caseId}) : super(key: key);

  @override
  _CaseCommentWriteState createState() => _CaseCommentWriteState();
}

class _CaseCommentWriteState extends State<CaseCommentWrite> {
  TextEditingController _textC = new TextEditingController();

  ///新增案例评论
  void addCaseComment() {
    caseViewModel
        .caseComment(
          context,
          targetId: widget.caseId,
          content: _textC.text,
          type: 3, //3为案例评论
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
                  width: MediaQuery.of(context).size.width - 30,
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
//                new Space(),
//                new IconButton(
//                    icon: Icon(
//                      Icons.sentiment_very_satisfied,
//                      size: 32,
//                      color: ThemeColors.color999,
//                    ),
//                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
