import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';

/// 用户评论
class UserReviewsPage extends StatefulWidget {
  @override
  _UserReviewsPageState createState() => _UserReviewsPageState();
}

class _UserReviewsPageState extends State<UserReviewsPage> {
  List<LectureCommentListModel> list = new List();
  bool isLoadingOk = false;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    getCommentData();
    Notice.addListener(JHActions.commentUserRefresh(), (v){
      getCommentData(true);
    });
  }

  Future getCommentData([bool isInit = false]) {
    if (isInit) goPage = 1;
    return lectureViewModel
        .lectureCommentList(
      context,
      id: JHData.id(),
      page: goPage,
      limit: 15,
    )
        .then((v) {
      setState(() {
        if (goPage == 1) {
          list = List.from(v.data);
        } else {
          list.addAll(List.from(v.data));
        }
        isLoadingOk = true;
      });
    }).catchError(
      (e) {
        setState(() => isLoadingOk = true);
        showToast(context, e.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: '用户评论',
      ),
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: list,
        onRefresh: () => getCommentData(true),
        onLoad: () {
          goPage++;
          return getCommentData();
        },
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              LectureCommentListModel model = list[index];
              return UserReviewsItem(
                model,
                callback: (id) => agreementComments(id),
              );
            }),
      ),
    );
  }

  void dispose(){
    super.dispose();
    Notice.removeListenerByEvent(JHActions.commentUserRefresh());
  }

  /// 评论点赞
  Future agreementComments(id) async {
    return lectureViewModel
        .agreementComments(
      context,
      typeId: id,
    )
        .catchError((e) {
      return showToast(context, e.message);
    });
  }
}

class UserReviewsItem extends StatelessWidget {
  final LectureCommentListModel model;
  final Callback callback;

  UserReviewsItem(this.model, {this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0),
      child: reviewsItem(
        userName: model?.nickName ?? '未知',
        content: model?.content ?? '未知内容',
        createTime: DateTimeForMater.formatTimeStampToString(
            stringDisposeWithDouble(model.createTime / 1000) ?? '0'),
        avatar: model?.avatar,
        isLike: model?.isThumbsUp ?? false,
        isLikeNum: model?.likeCount ?? 0,
        id: model.id,
        isLikeOnTap: callback,
      ),
    );
  }

  Widget reviewsItem(
      {String userName,
      String content,
      String createTime,
      String avatar,
      String id,
      int isLikeNum,
      bool isLike,
      Callback isLikeOnTap}) {
    return Row(
      children: <Widget>[
        new Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 5.0),
          child: new CircleAvatar(
            radius: 50,
            backgroundImage:
                CachedNetworkImageProvider(avatar ?? userDefaultAvatarOld),
          ),
        ),
        Space(width: mainSpace / 2),
        new Expanded(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                userName,
                style: TextStyle(
                    color: ThemeColors.color333,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                content,
                style: TextStyle(
                  color: ThemeColors.color999,
                  fontSize: 14.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              new Text(
                createTime,
                style: TextStyle(color: ThemeColors.color999, fontSize: 14.0),
              ),
            ],
          ),
        ),
        Space(),
        new GestureDetector(
          onTap: () {
            if (isLikeOnTap != null) isLikeOnTap(id);
          },
          child: new Container(
            child: Column(
              children: <Widget>[
                new SizedBox(
                  height: 2,
                ),
                new Container(
                  height: 17,
                  width: 17,
                  child: isLike
                      ? Image.asset('assets/images/mine/is_like_icon.png')
                      : Image.asset('assets/images/mine/un_like_icon.png'),
                ),
                new SizedBox(
                  height: 15,
                ),
                new Text(
                  isLikeNum.toString(),
                  style: TextStyle(
                      color: isLike
                          ? Color.fromRGBO(225, 185, 107, 1)
                          : ThemeColors.color999),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
