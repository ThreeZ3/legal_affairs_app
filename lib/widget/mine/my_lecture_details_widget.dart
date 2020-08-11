import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///我的课件
///支持反对Bar
///
class IsLikeBar extends StatefulWidget {
  final Function lectureAgree;
  final int likeCount;
  final int disLikeCount;

  IsLikeBar({
    this.lectureAgree,
    this.likeCount,
    this.disLikeCount,
  });

  @override
  _IsLikeBarState createState() => _IsLikeBarState();
}

class _IsLikeBarState extends State<IsLikeBar> {
  @override
  Widget build(BuildContext context) {
    List _isLikeBar = [
      {
        'title': '支持',
        'isLike': false,
        'num': widget.likeCount,
      },
      {
        'title': '反对',
        'isLike': false,
        'num': widget.disLikeCount,
      },
    ];

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _isLikeBar.map((item) {
          return InkWell(
            onTap: () {
              setState(() {
                if (item['isLike'] == false) {
                  item['isLike'] = true;
                } else {
                  return;
                }
                _isLikeBar.forEach((inItem) {
                  if (inItem['title'] != item['title']) {
                    inItem['isLike'] = false;
                  }
                });
              });
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
                      new Space(width: mainSpace / 2),
                      Text(
                        '${item['num'].toString()}',
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

///我的课件
///用户评论
///
class CommentCard extends StatefulWidget {
  final LectureCommentListModel data;

  CommentCard({this.data});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isLike = false;
  int _isLikeNum = 23;

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
                backgroundImage: CachedNetworkImageProvider(NETWORK_IMAGE),
              ),
            ),
            new Space(),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '用户名称',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                new Space(height: mainSpace / 3),
                new Text('${widget.data.comment}'),
                new Container(
                  child: new Text(
                    '8月12日',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            new Spacer(),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _isLike = !_isLike;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.thumb_up,
                      color: _isLike
                          ? ThemeColors.colorOrange
                          : ThemeColors.color999,
                      size: 16,
                    ),
                    new Text(
                      _isLikeNum.toString(),
                      style: TextStyle(
                        color: _isLike
                            ? ThemeColors.colorOrange
                            : ThemeColors.color999,
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

///我的课件
///写评论
///

// ignore: must_be_immutable
class LectureCommentWrite extends StatelessWidget {
  final TextEditingController commentC;
  final Function sendComment;

  const LectureCommentWrite({Key key, this.commentC, this.sendComment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
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
                  onPressed: sendComment),
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
                    controller: commentC,
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
