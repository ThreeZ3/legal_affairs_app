import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/common/win_media.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-27
///
/// 封装：间隔条、竖线+词条、排名样式、标签样式、词条+图片、文字
///

//间隔条
class HorizontalLinee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: winWidth(context),
      height: 12,
      color: Color(0xffF6F7F9),
    );
  }
}

//图标+词条
class Entry extends StatefulWidget {
  final String text;
  final Color borderColor;
  final Widget icon;
  Entry({this.text, this.borderColor, this.icon});
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 13),
      width: MediaQuery.of(context).size.width,
      color: Color(0xfffffffe),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 17,
            width: 2,
            margin: EdgeInsets.only(right: 2.0),
            decoration: BoxDecoration(
              color: Color(0xffE1B96B),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            child: widget.icon,
          ),
        ],
      ),
    );
  }
}

//词条+图标
class EntryIcon extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  EntryIcon({this.text, this.onTap});
  @override
  _EntryIconState createState() => _EntryIconState();
}

class _EntryIconState extends State<EntryIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      /* padding: EdgeInsets.only(right: 16),*/
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 16, right: 16),
        leading: Text(
          widget.text,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Image.asset(
          'assets/images/mine/right_arrow_icon.png',
          width: 8,
          height: 14,
        ),
        /* IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff777777),
          ),
          onPressed: null,
        ),*/
        onTap: widget.onTap,
      ),
    );
  }
}

//排名
class IconBox extends StatefulWidget {
  final String text;
  final String number;
  IconBox({this.text, this.number});
  @override
  _IconBoxState createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 44,
      child: Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffE1B96B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xfffffffe),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF0F0F0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              widget.number,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xffE1B96B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//标签
class LabelBox extends StatefulWidget {
  final String text;
  final Function onTap;
  final double height;
  final double width;
  final Color boxColor;
  final Color textColor;
  LabelBox({
    this.text,
    this.onTap,
    this.height = 23,
    this.width = 56,
    this.boxColor = const Color(0xFFF0F0F0),
    this.textColor = const Color(0xffE1B96B),
  });
  @override
  _LabelBoxState createState() => _LabelBoxState();
}

class _LabelBoxState extends State<LabelBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

//文字
class TextModule extends StatefulWidget {
  final String text;
  final Function onTap;
  TextModule({this.text, this.onTap});
  @override
  _TextModuleState createState() => _TextModuleState();
}

class _TextModuleState extends State<TextModule> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(left: 4),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.text,
          style: TextStyle(
            color: Color(0xff999999),
            fontSize: 12,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

//灰色字体
class GreyText extends StatefulWidget {
  final String text;
  GreyText({this.text});
  @override
  _GreyTextState createState() => _GreyTextState();
}

class _GreyTextState extends State<GreyText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 2),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Color(0xff999999),
          fontSize: 12,
        ),
      ),
    );
  }
}

//红色标签
class RedLabel extends StatefulWidget {
  final String text;
  RedLabel({this.text});
  @override
  _RedLabelState createState() => _RedLabelState();
}

class _RedLabelState extends State<RedLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 14,
      color: Color(0xffff3333),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}

//代理
class MyDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double heght;

  MyDelegate({this.child, this.heght});

  @override
  double get maxExtent => heght;

  @override
  double get minExtent => heght;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
