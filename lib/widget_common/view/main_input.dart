import 'package:flutter/material.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-29
class MainInputBody extends StatefulWidget {
  MainInputBody({
    this.child,
    this.color = Colors.transparent,
    this.decoration,
    this.onTap,
    this.padding,
  });

  final Widget child;
  final Color color;
  final Decoration decoration;
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry padding;

  @override
  State<StatefulWidget> createState() => new MainInputBodyState();
}

class MainInputBodyState extends State<MainInputBody> {
  @override
  Widget build(BuildContext context) {
    return widget.decoration != null
        ? new Container(
            decoration: widget.decoration,
            height: double.infinity,
            width: double.infinity,
            padding: widget.padding,
            child: new GestureDetector(
              child: widget.child,
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (widget.onTap != null) {
                  widget.onTap();
                }
              },
            ),
          )
        : new Container(
            color: widget.color,
            height: double.infinity,
            width: double.infinity,
            padding: widget.padding,
            child: new GestureDetector(
              child: widget.child,
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (widget.onTap != null) {
                  widget.onTap();
                }
              },
            ),
          );
  }
}
