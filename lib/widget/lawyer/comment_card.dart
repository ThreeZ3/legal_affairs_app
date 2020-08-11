import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class CommentCard extends StatefulWidget {
  final CaseCommentListModel model;
  final GestureTapCallback del;

  const CommentCard({Key key, this.model, this.del}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
//  bool widget.model.isThumbsUp = false;
  int cont = 0;

  @override
  void initState() {
    super.initState();
    cont = widget.model.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Space(height: mainSpace / 2),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 50 / 2,
                  backgroundImage: CachedNetworkImageProvider(
                      widget.model?.avatar ?? NETWORK_IMAGE),
                ),
                SizedBox(width: 10),
                Container(
                  width: winWidth(context) - (16 * 2 + 50 + 10 + 5 + 24),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '${widget.model?.nickName ?? '未知昵称'}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      new Space(height: mainSpace / 3),
                      new Container(
                        width: winWidth(context) - 110,
                        child: new Text(
                          '${widget.model?.content ?? '未知内容'}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 5),
            Container(
              width: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => !JHData.isLogin()
                        ? routePush(new LoginPage())
                        : handle(widget.model.id),
                    child: Column(
                      children: <Widget>[
                        new Icon(
                          Icons.thumb_up,
                          color: widget.model.isThumbsUp
                              ? ThemeColors.colorOrange
                              : ThemeColors.color999,
                          size: 16,
                        ),
                        new Text(
                          '$cont',
                          style: TextStyle(
                            color: widget.model.isThumbsUp
                                ? ThemeColors.colorOrange
                                : ThemeColors.color999,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
            ),
          ],
        ),
        SizedBox(height: 5),
        new Container(
          margin: EdgeInsets.only(left: 60.0),
          child: new Text(
            '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(widget.model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
            style: TextStyle(color: Color(0xff999999), fontSize: 12),
          ),
        )
      ],
    );
  }

  handle(String inId) {
    if (widget.model.isThumbsUp) {
      agreementCommentsCancel(inId);
    } else {
      agreementComments(inId);
    }
  }

  /// 取消评论点赞
  Future agreementCommentsCancel(String inId) async {
    return caseViewModel
        .cancelCommentAgree(
      context,
      typeId: inId,
    )
        .then((rep) {
      setState(() {
        widget.model.isThumbsUp = false;
        cont--;
      });
    }).catchError((e) {
      return showToast(context, e.message);
    });
  }

  Future agreementComments(String inId) async {
    return caseViewModel
        .agreementComments(
      context,
      typeId: inId,
    )
        .then((rep) {
      setState(() {
        widget.model.isThumbsUp = true;
        cont++;
      });
    }).catchError((e) {
      return showToast(context, e.message);
    });
  }
}
