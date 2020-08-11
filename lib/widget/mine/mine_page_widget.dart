import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/page/mine/user_header/normal_user_modifies_data_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';

///我的页面-AppBarLeadingButton
///
///
class AppBarButton extends StatelessWidget {
  final String buttonUrl;
  final Function onPressed;

  const AppBarButton({Key key, this.buttonUrl, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(2.0),
      child: new IconButton(
          icon: new Image.asset(
            buttonUrl,
            width: 22,
          ),
          onPressed: onPressed),
    );
  }
}

///我的页面-用户头部
///
///
class UserHeader extends StatelessWidget {
  final bool isLawyer;
  final String seniority;
  final List category;
  final String rank;
  final String generalUser;
  final String realName;

  const UserHeader(
    this.isLawyer, {
    Key key,
    this.seniority,
    this.category,
    this.rank,
    this.generalUser,
    this.realName,
  }) : super(key: key);

  static TextStyle _style = TextStyle(
    color: ThemeColors.color999,
    fontSize: 14.0,
  );

  //金黄色
  static Color goldenColor = Color.fromRGBO(225, 185, 107, 1);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 12.0, top: 12, bottom: 12, right: 13),
      child: Row(
        children: <Widget>[
          //头像
          new InkWell(
            child: new Hero(
              tag: 'avatar${JHData.avatar()}${JHData?.id}',
              child: new Container(
                width: 80,
                height: 80,
                child: new CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(JHData.avatar()),
                ),
              ),
            ),
            onTap: () => strNoEmpty(JHData?.avatar())
                ? routePush(
                    new HeroAnimationRouteB(JHData?.avatar(), JHData?.id()),
                    RouterType.fade)
                : () {},
          ),
          new Space(),
          //个人信息
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new InkWell(
                        child: new Text(
                          realName ?? JHData.nickName(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ThemeColors.color333,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () =>
                            routePush(new NorMalUserModifiesDataPage(realName)),
                      ),
                    ),
                    new Visibility(
                      visible: isLawyer,
                      child: new Text(
                        '${JHData.status() == -1 ? '状态:审核失败' : JHData.status() == 0 ? '状态:待审核' : ''}',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                new SizedBox(
                  height: 2.0,
                ),
                new Visibility(
                  visible: isLawyer,
                  child: new Text(
                    '执业${seniority.toString()}年',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _style,
                  ),
                ),
                new SizedBox(height: 2.0),
                new Visibility(
                  visible: isLawyer,
                  child: new Row(
                    children: <Widget>[
                      Text(JHData.city(), style: _style),
                      new Space(),
                      new Expanded(
                          child: Text(
                        JHData.district(),
                        style: _style,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                  replacement: Container(
                    child: new Row(
                      children: <Widget>[
                        new Text(JHData.sex() == '0' ? '男' : '女',
                            style: _style),
                        new Space(),
                        new VerticalLine(
                            height: 12, color: ThemeColors.color999),
                        new Space(),
                        new Text(JHData.city(), style: _style),
                        new Space(),
                        new Text(JHData.district(), style: _style),
                        new Spacer(),
                        new InkWell(
                          onTap: () {
                            routePush(NorMalUserModifiesDataPage(realName));
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/images/mine/edit_icon.png',
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new SizedBox(height: 8.0),
                new Visibility(
                  visible: isLawyer,
                  child: new RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: category.map((item) {
                          NewCategoryModel model = item;
                          return WidgetSpan(
                            child: categoryItem(model?.name ?? '未知'),
                          );
                        }).toList(),
                      )),
                  replacement: categoryItem('普通用户'),
                ),
              ],
            ),
          ),
          new Space(),
          //执业执照与排名
          new Visibility(
            visible: isLawyer,
            child: Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {},
                    child: new Container(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(225, 185, 107, 1),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '执业执照',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  new SizedBox(
                    height: 30,
                  ),
                  new GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 60.0,
                      child: Column(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(225, 185, 107, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0),
                                )),
                            child: Center(
                              child: Text(
                                '排名',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                              color: ThemeColors.color999.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 5.0),
                            child: Center(
                              child: Text(
                                stringDisposeWithDouble(rank.toString()),
                                style: TextStyle(
                                    color: Color.fromRGBO(225, 185, 107, 1),
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
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

///用户类别
Widget categoryItem(item) {
  //金黄色
  Color goldenColor = Color.fromRGBO(225, 185, 107, 1);
  return new Container(
    margin: EdgeInsets.only(right: 15, bottom: 2),
    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    decoration: BoxDecoration(
        color: ThemeColors.color999.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5)),
    child: Text(
      item,
      style: TextStyle(
        color: goldenColor,
        fontSize: 14.0,
      ),
    ),
  );
}

///我的页面-选卡列表
///
///
class MineListItem extends StatelessWidget {
  final bool isUpDivider;
  final bool isVerLine;
  final String title;
  final VoidCallback onPressed;

  const MineListItem(
      {Key key,
      this.title,
      this.onPressed,
      this.isUpDivider = false,
      this.isVerLine = false})
      : super(key: key);

  static TextStyle _style = TextStyle(
      color: ThemeColors.color333,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isUpDivider
          ? BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ThemeColors.colorDivider,
                  width: 8.0,
                ),
              ),
            )
          : null,
      child: new FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
        onPressed: onPressed,
        child: new Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Visibility(
                  visible: isVerLine,
                  child: new Container(
                    margin: EdgeInsets.only(right: 2.0),
                    child: Image.asset('assets/images/mine/gold_bar.png'),
                  ),
                ),
                new Text(title, style: _style),
              ],
            ),
            new Spacer(),
            new Icon(
              CupertinoIcons.right_chevron,
              color: ThemeColors.color999,
            ),
          ],
        ),
      ),
    );
  }
}

///律师理念与简介

class EditInformation extends StatefulWidget {
  final String title;
  final VoidCallback onTapEdit;
  final Widget infoWidget;

  const EditInformation({Key key, this.title, this.onTapEdit, this.infoWidget})
      : super(key: key);

  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(
        left: 13.0,
        right: 16.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 2.0),
                child: Image.asset('assets/images/mine/gold_bar.png'),
              ),
              new Text(widget.title,
                  style: TextStyle(
                      color: ThemeColors.color333,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.0)),
              new Spacer(),
              new GestureDetector(
                onTap: widget.onTapEdit,
                child: new Container(
                  width: 16,
                  height: 16,
                  child: Image.asset('assets/images/mine/edit_icon.png'),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 10.0),
            child: widget.infoWidget,
          )
        ],
      ),
    );
  }
}

///我的页面-分隔线
///
///
class MinePageDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(height: 8.0, color: ThemeColors.colorDivider);
  }
}
