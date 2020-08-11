import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/common/ui.dart';

class ListTileCardWidget extends StatefulWidget {
  final int length;
  final String leading;
  final String trailing;
  final bool style;
  final bool icon;
  final bool iconHead;
  final String iconText;
  final double iconWidth;
  final double iconHeight;
  final bool input;
  final GestureTapCallback onTap;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool time;
  final bool money;
  final bool number;
  final TextEditingController controller;
  final List<TextInputFormatter> formats;

  const ListTileCardWidget(
      {Key key,
      this.length = 8,
      this.leading,
      this.trailing,
      this.style = false,
      this.icon = false,
      this.iconHead = false,
      this.iconWidth = 140,
      this.iconHeight = 120,
      this.iconText,
      this.input = false,
      this.onTap,
      this.onChanged,
      this.hintText = '请输入',
      this.time = true,
      this.money = false,
      this.controller,
      this.number = true,
      this.formats = const []})
      : super(key: key);

  @override
  _ListTileCardWidgetState createState() => _ListTileCardWidgetState();
}

class _ListTileCardWidgetState extends State<ListTileCardWidget> {
  TextStyle _styleOne = TextStyle(
    color: Color(0xff333333),
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle _styleTwo = TextStyle(
    color: Color(0xff999999),
    fontSize: 14.0,
  );
  TextStyle _styleThree = TextStyle(
    color: Color(0xff999999),
    fontSize: 16.0,
  );

  double _globlePositionX = 0.0;
  double _globlePositionY = 0.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.leading,
                style: widget.style ? _styleThree : _styleOne,
              ),
              SizedBox(width: 6.0),
              widget.icon
                  ? GestureDetector(
                      onTap: () => _showPromptBox(),
                      onPanDown: (DragDownDetails details) {
                        _globlePositionX = details.globalPosition.dx;
                        _globlePositionY = details.globalPosition.dy;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Image.asset(
                          'assets/images/mine/icon_tips.png',
                          width: 16.0,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          widget.input
              ? ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 32.0),
                  child: Row(
                    children: <Widget>[
                      widget.money ? Text('', style: _styleTwo) : Container(),//￥
                      Container(
                        width: 66,
                        child: TextField(
                          style: _styleTwo,
                          maxLines: 1,
                          autofocus: false,
                          textAlign: TextAlign.right,
                          obscureText: false,
                          controller: widget.controller,
                          onChanged: widget.onChanged,
                          keyboardType: widget.number
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(widget.length),
                            /*WhitelistingTextInputFormatter(RegExp("[0-9.]")),*/
                            WhitelistingTextInputFormatter.digitsOnly,
                          ]..addAll(widget.formats),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 13),
                            border: InputBorder.none,
                            hintText: widget.hintText,
                          ),
                        ),
                      ),
                      new Space(),
                      widget.time ? Text('天', style: _styleTwo) : Container(),
                    ],
                  ),
                )
              : Text(widget.trailing, style: _styleTwo),
        ],
      ),
    );
  }

  _showPromptBox() {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: _globlePositionY - 30,
              left: _globlePositionX + 15,
              child: Material(
                type: MaterialType.transparency,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget.iconHead
                                ? Text('竞价规则：', style: _styleTwo)
                                : Container(),
                            Text(
                              widget.iconText,
                              /*'系统根据竞价高低，竞价先后，推送时间长短来确定最终竞价是否成功',*/
                              style: _styleTwo,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
