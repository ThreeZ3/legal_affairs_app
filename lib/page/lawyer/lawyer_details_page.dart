import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jh_legal_affairs/api/business/consult_view_model.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_accusation_page.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/lawyer/comment_card.dart';
import 'package:jh_legal_affairs/widget/lawyer/lawyer_entry.dart';
import 'package:jh_legal_affairs/widget/lawyer/lawyer_item.dart';
import 'package:jh_legal_affairs/widget/lawyer/lawyer_title.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:jh_legal_affairs/widget_common/view/image_photo.dart';
import '../mine/live_video/live_video_page.dart';
import 'lawyer_details/complaint_page.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';

class LawyerDetailsDes {
  String title;
  String des;

  LawyerDetailsDes(this.title, this.des);
}

class LawyerDetailsPage extends StatefulWidget {
  final String id;

//  final int rank;
//  final List<NewCategoryModel> legalField;

  LawyerDetailsPage(
    this.id,
//    this.rank,
//    this.legalField,
  );

  @override
  _LawyerDetailsPageState createState() => _LawyerDetailsPageState();
}

class _LawyerDetailsPageState extends State<LawyerDetailsPage> {
  LawyerDetailsInfoModel infoModel = new LawyerDetailsInfoModel();

  lawyerClick() => lawyerViewModel.lawyerClick(context, id: widget.id);

  getDetail() {
    lawyerViewModel
        .lawyerDetail(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        infoModel = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail();
    lawyerClick();
    Notice.addListener(JHActions.lawyerDetailPageRefresh(), (v) {
      getDetail();
    });
  }

  Widget desItem(LawyerDetailsDes item) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 10.0, top: 5),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new LawyerTitle(item.title),
          new Text('${item.des}'),
        ],
      ),
    );
  }

  Widget rowItem(icons, item, value) {
    return new Material(
      color: Colors.white,
      child: new Container(
        decoration: BoxDecoration(
          border: item != '举报'
              ? Border(
                  right: BorderSide(
                      color: Colors.grey.withOpacity(0.8), width: 0.5),
                )
              : null,
        ),
        width: (winWidth(context) - 30) / 4,
        padding: EdgeInsets.symmetric(vertical: 7.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(child: Image.asset(icons), width: 22, height: 22),
            new Space(width: mainSpace / 4),
            new Text(
              '$item(${value ?? 0})',
              style: TextStyle(color: THEME_COLOR),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelItem(item) {
    NewCategoryModel model = item;
    return new Container(
      color: Color(0xfff9f9f9),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      margin: EdgeInsets.only(right: 8),
      child: new Text(
        '${model?.name ?? '未知'} ${stringDisposeWithDouble(model?.rank) ?? '0'}',
        style: TextStyle(color: THEME_COLOR, fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<LawyerDetailsDes> des = [
      new LawyerDetailsDes('律师理念', '${infoModel?.lawyerValue ?? '未知'}'),
      new LawyerDetailsDes('律师简介', '${infoModel?.lawyerInfo ?? '未知'}'),
    ];

    return new Scaffold(
      appBar: new NavigationBar(title: '律师详情'),
      body: new ListView(children: <Widget>[
        new Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new InkWell(
                    child: new Hero(
                      tag: 'avatar${infoModel?.avatar}${infoModel?.id}',
                      child: new CircleAvatar(
                          backgroundImage: strNoEmpty(infoModel?.avatar)
                              ? CachedNetworkImageProvider(infoModel?.avatar)
                              : AssetImage(avatarLawyerMan),
                          radius: 35),
                    ),
                    onTap: () => strNoEmpty(infoModel?.avatar)
                        ? routePush(
                            new HeroAnimationRouteB(
                                infoModel?.avatar, infoModel?.id),
                            RouterType.fade)
                        : () {},
                  ),
                  new Space(),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          '${infoModel?.realName ?? infoModel?.firmName ?? '未知昵称'}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 2),
                        new Text(
                          '执业${workYearStr(infoModel?.workYear)}年',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 1),
                        new Text(
                          '${infoModel?.city ?? '未知'}  ${infoModel?.district ?? '未知'}${infoModel?.firmName ?? "未知事务所"}',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 1),
                        new Wrap(
                          runSpacing: 10,
                          children: // legalField
                              List.from(infoModel?.legalField ?? [])
                                  .map(labelItem)
                                  .toList(),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ThemeColors.colorOrange,
                        ),
                        alignment: Alignment.topRight,
                        child: Text(
                          '执业执照',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 19),
                        child: IconBox(
                            text: '排名', number: '${infoModel?.rank ?? 0}'),
                      ),
                    ],
                  ),
                ],
              ),
              new Space(height: mainSpace),
              new Row(
                children: <Widget>[
                  InkWell(
                    onTap: () => JHData.isLogin()
                        ? opinion(context)
                        : routePush(new LoginPage()),
                    child: rowItem('assets/images/lawyer/comment.png', '评论',
                        infoModel.commentCount),
                  ),

                  /// 跳转到IM系统
                  new InkWell(
                    child: rowItem(
                      'assets/images/lawyer/advisory.png',
                      '咨询',
                      infoModel.consultCount,
                    ),
                    onTap: () => routerIm(context),
                  ),
                  new InkWell(
                    child: rowItem(
                      'assets/images/lawyer/tell.png',
                      '投诉',
                      infoModel.complaintCount,
                    ),
                    onTap: () => routePush(!JHData.isLogin()
                        ? new LoginPage()
                        : new ComplaintPage(id: widget.id, type: 1)),
                  ),
                  InkWell(
                    child: rowItem(
                      'assets/images/lawyer/accusation.png',
                      '举报',
                      infoModel.accusationCount,
                    ),
                    onTap: () => routePush(!JHData.isLogin()
                        ? new LoginPage()
                        : new AccusationPage(id: widget.id, type: 1)),
                  ),
                ],
              )
            ],
          ),
        ),
        new Space(),
        new Container(
          color: Colors.white,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: des.map(desItem).toList(),
          ),
        ),
        new Space(),
        new LawyerDetailList(
          id: widget.id,
        ), //律师词条列表
        new Space(),
      ]),
    );
  }

//发表评论
  void opinion(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Opinion(widget.id);
      },
    );
  }
}

//律师词条列表
class LawyerDetailList extends StatefulWidget {
  final String id;

  const LawyerDetailList({Key key, this.id}) : super(key: key);

  @override
  _LawyerDetailListState createState() => _LawyerDetailListState();
}

class _LawyerDetailListState extends State<LawyerDetailList> {
  bool isShow = false;

  List<CaseCommentListModel> _caseCommentList = new List();
  ViewLawyerDetailModel detailsInfo = new ViewLawyerDetailModel();

  getComment() {
    caseViewModel
        .caseCommentList(
      context,
      id: widget.id,
      limit: 10,
      page: 1,
    )
        .then((rep) {
      setState(() {
        _caseCommentList = List.from(rep.data);
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  getDetailsInfo() {
    lawyerViewModel
        .lawyerDetailsInfo(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        detailsInfo = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///删除评论
  postCommentDel(id) {
    caseViewModel.commentDel(context, id).then((rep) {
      showToast(context, '删除成功');
      getComment();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getComment();
    Notice.addListener(JHActions.lawyerCommentRefresh(), (v) => getComment());
    getDetailsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        detailInformation(), //详细资料
        isShow == true
            ? Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 13),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 16),
                        lawFirmWidget(
                          title: '律师电话',
                          list: detailsInfo.mobile,
                          type: '电话',
                        ), //律师电话
                        SizedBox(height: 16),
                        lawFirmWidget(
                          title: '律师微信',
                          list: detailsInfo.wechat,
                          type: '微信',
                        ), //律师微信
                        SizedBox(height: 16),
                        lawFirmWidget(
                          title: '律师邮箱',
                          list: detailsInfo.email,
                          type: '邮箱',
                          widgetWidth:
                              (MediaQuery.of(context).size.width - 46) / 2,
                        ), //律师邮箱
                        SizedBox(height: 16),
                        webPublicWidget(), //微博、公众号
                        SizedBox(height: 24),
                        lawyerFirmPic(), //律师照片
                        SizedBox(height: 24),
                        socialHonor(), //社会荣誉
                        SizedBox(height: 24),
                        credentials(), //资质证明
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Container(
                    height: 12,
                    color: Color(0xffF5F5F5),
                  ),
                ],
              )
            : new Space(),
        new FlatButton(
          onPressed: () {
            routePush(LiveVideoPage(widget.id));
          },
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          color: Colors.white,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '视频直播',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              new Icon(CupertinoIcons.right_chevron)
            ],
          ),
        ),
        new Space(),
      ]
        ..addAll([
          '他/她的案源',
          '他/她的合同',
          '他/她的任务',
          '他/她的咨询',
          '他/她的图文',
          '他/她的课件',
          '他/她的案例',
          '他/她的广告',
        ]
            .map((item) => new LawyerItem(
                  item,
                  id: widget.id,
                ))
            .toList())
        //用户评价
        ..addAll(
          [
            new Space(),
            new Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                        '用户评价',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Space(),
                      new Text(
                        '(${_caseCommentList.length})',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  new Space(),
                  new DataView(
                    isLoadingOk: true,
                    data: _caseCommentList,
                    label: '暂无评论',
                    child: new Column(
                      children: List.generate(_caseCommentList.length, (index) {
                        CaseCommentListModel model = _caseCommentList[index];
                        return new CommentCard(
                          model: model,
                          del: () => postCommentDel(model.id),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  //详细资料
  Widget detailInformation() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 13),
      child: Entry(
        text: '详细资料',
        icon: isShow == false
            ? IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Image.asset('assets/images/law_firm/arrow_up.png'),
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
              )
            : IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Image.asset('assets/images/law_firm/arrow_down.png'),
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
              ),
      ),
    );
  }

  Widget lawFirmWidget({
    String title,
    List list,
    String type,
    double widgetWidth,
    Widget routerPage,
  }) {
    double width = (MediaQuery.of(context).size.width - 60) / 3;
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '$title',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          child: Wrap(
            spacing: 14,
            runSpacing: 4,
            children: list.map((index) {
              return new InkWell(
                child: Container(
                  width: widgetWidth != null ? widgetWidth : width,
                  child: Text(
                    '${index?.title ?? '暂无数据'} ${index?.value ?? ''}',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
                onTap: () => launchTel(context, index?.value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  //律师微博、律师公众号
  Widget webPublicWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律师微博',
                editIconUrlTwo: null,
              ),
              SizedBox(height: 8),
              GreyText(
                text:
                    '${listNoEmpty(detailsInfo?.weibo ?? []) ? detailsInfo?.weibo[0].value : '暂无微博'}',
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律师公众号',
                editIconUrlTwo: null,
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(detailsInfo?.officialAccounts ?? []) ? detailsInfo?.officialAccounts[0].value : '暂无数据'}'),
            ],
          ),
        ),
      ],
    );
  }

  //律师照片
  Widget lawyerFirmPic() {
    List images = new List();
    for (int i = 0; i < List.from(detailsInfo?.photo ?? []).length; i++) {
      ImageModel imageModel = new ImageModel();
      imageModel.img = List.from(detailsInfo?.photo ?? [])[i].value;
      imageModel.index = i;
      images.add(imageModel);
    }
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '律师照片',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(List.from(detailsInfo?.photo ?? []))
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: List.generate(
                      List.from(detailsInfo?.photo ?? []).length, (index) {
                    var item = detailsInfo.photo[index];

                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: '${item.value}',
                              fit: BoxFit.fill,
                              width: 180,
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${item.title ?? '未知标题'}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () => routePush(new PhotoPage(images, index)),
                    );
                  }),
                )
              : new Text('暂无照片'),
        ),
      ],
    );
  }

  //社会荣誉
  Widget socialHonor() {
    List _innerImages = new List();
    List _dataList = List.from(detailsInfo?.spocialhonor ?? []);
    for (int i = 0; i < _dataList.length; i++) {
      var item = _dataList[i];
      ImageModel imageModel = new ImageModel();
      imageModel.img = item?.value ?? userDefaultAvatarOld;
      imageModel.title = item?.title ?? '未知标题';
      imageModel.index = i;
      _innerImages.add(imageModel);
    }

    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '社会荣誉',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(_dataList)
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: _innerImages.map((index) {
                    ImageModel model = index;
                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: '${model.img}',
                              fit: BoxFit.fill,
                              width: 180,
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${model.title}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () =>
                          routePush(new PhotoPage(_innerImages, model.index)),
                    );
                  }).toList(),
                )
              : new Text('暂无数据'),
        ),
      ],
    );
  }

  //资质证明
  Widget credentials() {
    List _innerImages = new List();
    List _dataList = List.from(detailsInfo?.qualification ?? []);
    for (int i = 0; i < _dataList.length; i++) {
      var item = _dataList[i];
      ImageModel imageModel = new ImageModel();
      imageModel.img = item?.value ?? userDefaultAvatarOld;
      imageModel.title = item?.title ?? '未知标题';
      imageModel.index = i;
      _innerImages.add(imageModel);
    }

    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '资质证明',
          editIconUrlTwo: null,
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(_innerImages)
              ? Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: _innerImages.map((item) {
                    ImageModel model = item;
                    return new InkWell(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 47) / 2,
                        child: Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: '${model.img}',
                              fit: BoxFit.fill,
                              width: 180,
                            ),
                            SizedBox(height: 4),
                            GreyText(
                              text: '${model.title}',
                            ),
                          ],
                        ),
                      ),
                      onTap: () =>
                          routePush(new PhotoPage(_innerImages, model.index)),
                    );
                  }).toList(),
                )
              : new Text('暂无数据'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.lawyerDetailPageRefresh());
    Notice.removeListenerByEvent(JHActions.lawyerCommentRefresh());
  }
}

class Opinion extends StatefulWidget {
  final String id;

  Opinion(this.id);

  @override
  _OpinionState createState() => _OpinionState();
}

class _OpinionState extends State<Opinion> {
  TextEditingController _textC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 390,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      '取消',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.color999,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 23),
                    child: Text(
                      '写评论',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.color999,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: Text(
                      '提交',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.colorOrange,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => commitComment(),
                  )
                ],
              ),
              new Expanded(
                child: TextField(
                  controller: _textC,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "您的评论将对所有人可见",
                    hintStyle: TextStyle(
                      color: ThemeColors.color999,
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.only(bottom: 10, left: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  commitComment() {
    consultViewModel
        .newComment(
      context,
      content: _textC.text,
      targetId: widget.id,
      type: 1,
    )
        .then(
      (v) {
        pop();
        Notice.send(JHActions.lawyerCommentRefresh(), '');
      },
    ).catchError((e) {
      showToast(context, e.message);
    });
  }
}
