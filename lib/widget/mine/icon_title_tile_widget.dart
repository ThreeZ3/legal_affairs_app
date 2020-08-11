import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///图标Tile
class IconTitleTileWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTapEditOne;
  final VoidCallback onTapEditTwo;
  //title左边图标
  final String iconUrl;
  //Tile 右边第一个图标
  final String editIconUrlOne;
  //Tile 右边第二个图标
  final String editIconUrlTwo;
  final double fontSize;
  final double iconSize;
  final double iconSizeOne;
  IconTitleTileWidget({
    Key key,
    this.title = '',
    this.onTapEditOne,
    this.iconUrl = 'assets/images/mine/gold_bar.png',
    this.fontSize = 14.0,
    this.editIconUrlOne,
    this.editIconUrlTwo = 'assets/images/mine/edit_icon.png',
    this.onTapEditTwo,
    this.iconSize = 18,
    this.iconSizeOne = 18,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 2.0),
                child: Image.asset('$iconUrl'),
              ),
              new Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  letterSpacing: 1.0,
                ),
              ),
              new Spacer(),
              Row(
                children: <Widget>[
                  editIconUrlOne != ''
                      ? InkWell(
                          onTap: onTapEditOne,
                          child: new Container(
                            child: Image.asset(
                              '$editIconUrlOne',
                              width: iconSizeOne,
                            ),
                          ),
                        )
                      : null,
                  Space(width: 5),
                  new InkWell(
                    onTap: onTapEditTwo,
                    child: new Container(
                      child: Image.asset(
                        '$editIconUrlTwo',
                        width: iconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
