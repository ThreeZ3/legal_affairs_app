import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/business/consult_model.dart';
import 'package:jh_legal_affairs/api/business/consult_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class AdvisoryDetailsPage extends StatefulWidget {
  final String id;

  AdvisoryDetailsPage(this.id);

  @override
  _AdvisoryDetailsPageState createState() => _AdvisoryDetailsPageState();
}

class _AdvisoryDetailsPageState extends State<AdvisoryDetailsPage> {
  ConsultDetailsModel model = new ConsultDetailsModel();

  TextEditingController textEditingController = TextEditingController();
  List replyList = List();
  bool isLoadingOk = false;
  int _goPage = 1;

  Future consultAnswerLimitData([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    await consultViewModel
        .consultAnswerLimit(
      context,
      id: widget.id,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          replyList = List.from(rep.data);
        } else {
          replyList.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  getDetailsData() {
    consultViewModel.consultDetails(context, id: widget.id).then((rep) {
      setState(() {
        model = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///删除评论
  postConsultAnswerDel(id) {
    consultViewModel.consultAnswerDel(context, id).then((rep) {
      showToast(context, '删除成功');
      consultAnswerLimitData();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailsData();
    consultAnswerLimitData();
    Notice.addListener(JHActions.consultAnswerRefresh(), (v) {
      consultAnswerLimitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xffF4F7F9),
      appBar: new NavigationBar(title: '咨询详情'),
      body: strNoEmpty(model?.title)
          ? ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 13, horizontal: winWidth(context) * 0.0426),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${model?.title ?? '未知标题'}',
                              style: TextStyle(
                                color: ThemeColors.color333,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Space(width: mainSpace),
                          //Spacer(),
                          Text(
                            '${model.status?.split(';')[1] ?? '未知'}',
                            style: TextStyle(
                                color: ThemeColors.colorOrange, fontSize: 14),
                          ),
                        ],
                      ),
                      Space(height: 9),
                      new Row(
                        children: <Widget>[
                          labelItem('${model?.category ?? '未知类别'}'),
                          labelItem('${model?.limit.toString() + '天' ?? '未知'}'),
                          Time(
                            time:
                                '${DateTime.fromMillisecondsSinceEpoch(model?.createTime).toString().substring(0, 10) ?? '未知时间'}',
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 14, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '问题',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ThemeColors.color333),
                            ),
                            SizedBox(height: 7),
                            new EditRichShow(
                              json: model.content,
                            ),
                          ],
                        ),
                      ),
                      MainPart(
                        title: '要求',
                        des: '${model?.require ?? '未知内容'}',
                      ),
                      SizedBox(height: 7),
                    ],
                  ),
                ),
                Space(),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: winWidth(context) * 0.0426),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '发布咨询',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ThemeColors.color333),
                          ),
                          Spacer(),
                          Text(
                            '${model?.issuerName ?? ''}',
                            style: TextStyle(
                                color: ThemeColors.color666, fontSize: 14),
                          )
                        ],
                      ),
                      Space(),
                      Row(
                        children: <Widget>[
                          Text(
                            '报价',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ThemeColors.color333),
                          ),
                          Spacer(),
                          Text(
                            '￥${formatNum(model?.totalAsk)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFF3333),
                                fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Space(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(
                            '回答 ${replyList.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.color333,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          model.issuerId != JHData.id()
                              ? InkWell(
                                  child: Image.asset(
                                    'assets/images/lawyer/liuyanban.png',
                                    width: 15,
                                  ),
                                  onTap: () => !JHData.isLogin()
                                      ? routePush(new LoginPage())
                                      : replySheet())
                              : SizedBox(),
                        ],
                      ),
                      new Space(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: replyList?.length ?? 0,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => routePush(
                          LawyerDetailsPage(replyList[index].respondentId)),
                      child: CommentCard(
                          issuerId: model.issuerId,
                          data: replyList[index],
                          del: () {
                            postConsultAnswerDel(replyList[index].id);
                            print(
                                'replyList========================>${replyList[index].id}');
                          }),
                    ),
                  ),
                ),
              ],
            )
          : new LoadingView(),
    );
  }

  replySheet() {
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
                        /*height: 20,*/
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: 14, color: ThemeColors.color666),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "回答",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ThemeColors.color333,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            new InkWell(
                              child: new Container(
                                //padding: EdgeInsets.all(5),
                                child: Text(
                                  "发布",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeColors.colorOrange,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              onTap: () => JHData.isLogin()
                                  ? consultViewModel
                                      .consultAnswer(context,
                                          consultId: widget.id,
                                          content: textEditingController.text)
                                      .then((rep) {
                                      pop();
                                    }).catchError((e) {
                                      showToast(context, e.message);
                                    })
                                  : routePush(new LoginPage()),
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
                            hintText: "您的回答对所有人可见",
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
  void dispose() {
    super.dispose();
    textEditingController.clear();
    Notice.removeListenerByEvent(JHActions.consultAnswerRefresh());
  }
}

//标签
Widget labelItem(item) {
  return new Container(
    color: Color(0xfff0f0f0),
    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
    margin: EdgeInsets.only(right: 8),
    child: new Text(item, style: TextStyle(color: THEME_COLOR)),
  );
}

//时间
class Time extends StatelessWidget {
  final String time;

  Time({this.time});

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: TextStyle(
        color: ThemeColors.color999,
        fontSize: 10,
      ),
    );
  }
}

//主体（问题+要求）
class MainPart extends StatelessWidget {
  final String title;
  final String des;

  MainPart({this.title, this.des});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ThemeColors.color333),
          ),
          SizedBox(height: 7),
          Text(
            des,
            style: TextStyle(fontSize: 14, color: ThemeColors.color999),
          )
        ],
      ),
    );
  }
}

//评论
class CommentCard extends StatefulWidget {
  final Recordss data;
  final String issuerId;
  final GestureTapCallback del;

  CommentCard({this.data, this.issuerId, this.del});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  double _globlePositionY = 0.0;

  int choose; //选择的类型1.最佳答案，2.相似答案，3.首个答案，
  String chooseValue;

  void printSelectValue() {
    consultViewModel
        .consultAnswerMark(
      context,
      id: '${widget.data.id}',
      score: choose,
    )
        .then((rep) {
      setState(() {});
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Space(height: mainSpace / 2),
        new Container(
          height: widget.issuerId == JHData.id() ? 54 : 33,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  widget.data.respondentAvatar,
                  height: 36,
                  width: 36,
                  fit: BoxFit.cover,
                ),
              ),
              new Space(),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    '${widget.data?.respondentName ?? '未知用户'}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.color333,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(widget.data.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                    style: TextStyle(color: Color(0xff999999), fontSize: 11),
                  ),
                  Spacer(),
                ],
              ),
              new Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  widget.issuerId == JHData.id()
                      ? GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${widget.data?.score ?? '未采纳'}",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff666666)),
                              ),
                              Space(width: 5),
                              Image.asset(
                                'assets/images/lawyer/xiala.png',
                                width: 13,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          onTap: () => _chooseAnswer(context, widget.data.id)
                              .then((rep) {
                            setState(() {
                              chooseValue = rep;
                            });
                          }),
                          onPanDown: (DragDownDetails details) {
                            _globlePositionY = details.globalPosition.dy;
                          },
                        )
                      : (strNoEmpty(widget.data.score.split(";")[1])
                          ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Color(0xffE1B96B),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "${widget.data.score.split(";")[1]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            )
                          : SizedBox()),
//                  SizedBox(height: 10),
                  widget.data.respondentId == JHData.id()
                      ? GestureDetector(
                          onTap: widget.del,
                          child: Text(
                            '删除',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: ThemeColors.color999, fontSize: 14),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 6, bottom: 18),
          child: new Text(
            '${widget.data.content}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ThemeColors.color666, fontSize: 12),
          ),
        )
      ],
    );
  }

  Future _chooseAnswer(context, id) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned(
              right: 16,
              top: _globlePositionY + 75 >
                      winHeight(context) - statusBarHeight(context)
                  ? _globlePositionY - 145
                  : _globlePositionY - 10,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: ['首个答案', '最佳答案', '相似答案'].map((item) {
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: item == '相似答案'
                                  ? null
                                  : Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey[300]))),
                          child: Text(
                            '$item',
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                        ),
                        onTap: () {
                          //选择的类型1.最佳答案，2.相似答案，3.首个答案，
                          if (item == '最佳答案') {
                            choose = 1;
                          } else if (item == '相似答案') {
                            choose = 2;
                          } else if (item == '首个答案') {
                            choose = 3;
                          }
                          printSelectValue();
                          pop(item);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
