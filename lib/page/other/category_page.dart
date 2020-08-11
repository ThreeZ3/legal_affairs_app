import 'package:flutter/material.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Widget itemBuild(item) {
    return new SizedBox(
      width: (winWidth(context) - (20 * 5)) / 4,
      child: new FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        color: Color(0xffF5F5F5),
        onPressed: () => {},
        child: new Text(
          item,
          style: TextStyle(color: Color(0xff707070)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NavigationBar(title: '常用类型'),
      backgroundColor: Colors.white,
      body: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '已选',
                style: TextStyle(color: Color(0xffBFBFBF), fontSize: 14.0),
              ),
              new Image.asset('assets/images/ic_set.png', width: 17.8),
            ],
          ),
          new Space(),
          new Wrap(
            spacing: 20,
            children:
                ['闽商', '闽商', '闽商', '闽商', '闽商', '闽商'].map(itemBuild).toList(),
          ),
          new Space(height: mainSpace * 2),
          new Text(
            '备选',
            style: TextStyle(color: Color(0xffBFBFBF), fontSize: 14.0),
          ),
          new Space(),
          new Wrap(
            spacing: 20,
            children:
                ['闽商', '闽商', '闽商', '闽商', '闽商', '闽商'].map(itemBuild).toList(),
          ),
          new Space(),
          new Text(
            '注明：已选的显示在导航栏，超出的隐藏在右划菜单；从已选中删除的选项，在备选中显示',
            style: TextStyle(color: Color(0xffFF0000), fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
