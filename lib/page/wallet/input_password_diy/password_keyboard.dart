
import 'package:flutter/material.dart';
import 'number_key_board.dart';
class PassWordKeyboard extends StatefulWidget {
  final callback;

  PassWordKeyboard(this.callback);

  @override
  State<StatefulWidget> createState() {
    return new MyKeyboardStat();
  }
}

class MyKeyboardStat extends State<PassWordKeyboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 定义 确定 按钮 接口  暴露给调用方
  ///回调函数执行体
  var backMethod;
  void onCommitChange() {
    widget.callback(new KeyEvent("commit"));
  }

  void onOneChange(BuildContext cont) {
    widget.callback(new KeyEvent("1"));  setState(() {

    });
  }

  void onTwoChange(BuildContext cont) {
    widget.callback(new KeyEvent("2"));  setState(() {

    });
  }

  void onThreeChange(BuildContext cont) {
    widget.callback(new KeyEvent("3"));  setState(() {

    });
  }

  void onFourChange(BuildContext cont) {
    widget.callback(new KeyEvent("4"));  setState(() {

    });
  }

  void onFiveChange(BuildContext cont) {
    widget.callback(new KeyEvent("5"));  setState(() {

    });
  }

  void onSixChange(BuildContext cont) {
    widget.callback(new KeyEvent("6"));  setState(() {

    });
  }

  void onSevenChange(BuildContext cont) {
    widget.callback(new KeyEvent("7"));  setState(() {

    });
  }

  void onEightChange(BuildContext cont) {
    widget.callback(new KeyEvent("8"));
    setState(() {

    });}

  void onNineChange(BuildContext cont) {
    widget.callback(new KeyEvent("9"));
    setState(() {

    });
  }

  void onZeroChange(BuildContext cont) {
    widget.callback(new KeyEvent("0"));  setState(() {

    });
  }

  /// 点击删除
  void onDeleteChange() {
    widget.callback(new KeyEvent("del"));  setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: _scaffoldKey,
      width: double.infinity,
      height: 250.0,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 30.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: new Text(
              '下滑隐藏',
              style: new TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),

          ///  键盘主体
          new Column(
            children: <Widget>[
              ///  第一行
              new Row(
                children: <Widget>[
                  NumberKeyBoardWidget(
                      text: '1', callback: (val) => onOneChange(context)),
                  NumberKeyBoardWidget(
                      text: '2', callback: (val) => onTwoChange(context)),
                  NumberKeyBoardWidget(
                      text: '3', callback: (val) => onThreeChange(context)),
                ],
              ),

              ///  第二行
              new Row(
                children: <Widget>[
                  NumberKeyBoardWidget(
                      text: '4', callback: (val) => onFourChange(context)),
                  NumberKeyBoardWidget(
                      text: '5', callback: (val) => onFiveChange(context)),
                  NumberKeyBoardWidget(
                      text: '6', callback: (val) => onSixChange(context)),
                ],
              ),

              ///  第三行
              new Row(
                children: <Widget>[
                  NumberKeyBoardWidget(
                      text: '7', callback: (val) => onSevenChange(context)),
                  NumberKeyBoardWidget(
                      text: '8', callback: (val) => onEightChange(context)),
                  NumberKeyBoardWidget(
                      text: '9', callback: (val) => onNineChange(context)),
                ],
              ),

              ///  第四行
              new Row(
                children: <Widget>[
                  NumberKeyBoardWidget(
                      text: '删除', callback: (val) => onDeleteChange()),
                  NumberKeyBoardWidget(
                      text: '0', callback: (val) => onZeroChange(context)),
                  NumberKeyBoardWidget(
                      text: '确定', callback: (val) => onCommitChange()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
class KeyEvent {
  ///  当前点击的按钮所代表的值
  String key;
  KeyEvent(this.key);

  bool isDelete() => this.key == "del";
  bool isCommit() => this.key == "commit";
}