import 'package:flutter/material.dart';

///  自定义 键盘 按钮
class NumberKeyBoardWidget extends StatefulWidget {
  ///  按钮显示的文本内容
  final String text;
  final String letter;
  NumberKeyBoardWidget({Key key, this.text, this.callback, this.letter})
      : super(key: key);

  ///  按钮 点击事件的回调函数
  final callback;
  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

class ButtonState extends State<NumberKeyBoardWidget> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    /// 获取当前屏幕的总宽度，从而得出单个按钮的宽度
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;

    return new Container(
        height: 60,
        width: _screenWidth / 4,
        color: Color(0xFF5A5A5A),
        child: Container(
          margin: EdgeInsets.all(6.0),
          child: new RawMaterialButton(
            //大小
//            constraints: BoxConstraints.tightFor(
//                width: ScreenUtil.getInstance().setWidth(117),
//                height: ScreenUtil.getInstance().setHeight(100)),
            // 直角
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0)),
            fillColor: Color(0XFF333333),
            // 边框颜色
//          borderSide: new BorderSide(color: Colors.transparent),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  widget.text,
                  style: new TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize:28),
                ),
//                new Text(
//                  widget.letter,
//                  style: new TextStyle(
//                      color: Color(0xff444444),
//                      fontSize: 12),
//                ),
              ],
            ),
            // 按钮点击事件
            onPressed: back,
          ),
        ));
  }
}

class NumberKeyBoardWidget1 extends StatefulWidget {
  final String text;
  final callback;
  const NumberKeyBoardWidget1({Key key, this.text, this.callback})
      : super(key: key);
  @override
  _NumberKeyBoardWidget1State createState() => _NumberKeyBoardWidget1State();
}

class _NumberKeyBoardWidget1State extends State<NumberKeyBoardWidget1> {
  var backMethod;

  void back() {
    widget.callback('$backMethod');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /// 获取当前屏幕的总宽度，从而得出单个按钮的宽度
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;
    return new Container(
        height: 120,
        width: _screenWidth / 4,
        color: Color(0xFF5A5A5A),
        child: Container(
          margin: EdgeInsets.all(6.0),
          child: new RawMaterialButton(
            //大小
//            constraints: BoxConstraints.tightFor(
//                width: ScreenUtil.getInstance().setWidth(117),
//                height: ScreenUtil.getInstance().setHeight(100)),
            // 直角
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            fillColor: Color(0XFF333333),
            // 边框颜色
//          borderSide: new BorderSide(color: Colors.transparent),
            child: new Text(
              widget.text,
              style: new TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 28),
            ),
            // 按钮点击事件
            onPressed: back,
          ),
        ));
  }
}

class NumberKeyBoardDeleteWidget extends StatefulWidget {
  final String text;
  final callback;
  const NumberKeyBoardDeleteWidget({Key key, this.text, this.callback})
      : super(key: key);
  @override
  _NumberKeyBoardDeleteWidgetState createState() =>
      _NumberKeyBoardDeleteWidgetState();
}

class _NumberKeyBoardDeleteWidgetState
    extends State<NumberKeyBoardDeleteWidget> {
  var backMethod;

  void back() {
    widget.callback('$backMethod');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /// 获取当前屏幕的总宽度，从而得出单个按钮的宽度
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;
    return new Container(
        height: 60,
        width: _screenWidth / 3,
        color: Color(0xE6D2D5DB),
        child: Container(
          margin: EdgeInsets.all(6.0),
          child: new FlatButton(
            // 直角
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            color: Color(0xE6D2D5DB),
            // 边框颜色
//          borderSide: new BorderSide(color: Colors.transparent),
            child: Image.asset(
              'assets/images/home_closenum.png',
              width: 30,
              height: 25,
              fit: BoxFit.cover,
            ),
            // 按钮点击事件
            onPressed: back,
          ),
        ));
  }
}
