/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-14
///
/// 有感觉的按钮

import 'package:flutter/material.dart';

class MagicBt extends StatelessWidget {
  final double width;
  final double height;
  final List<BoxShadow> boxShadow;
  final double radius;
  final String text;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle style;
  final Color color;
  final bool isBorder;
  final int borderColor;
  final double borderWidth;
  final Gradient gradient;
  final bool enable;
  final double unSatisfy;

  MagicBt({
    this.width,
    this.height = 40.0,
    this.boxShadow,
    this.radius = 30.0,
    this.borderWidth = 0.5,
    this.text = '按钮1',
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0),
    this.margin,
    this.style = const TextStyle(color: Colors.white, fontSize: 16.0),
    this.color = const Color(0xff2B2B57),
    this.isBorder = false,
    this.gradient,
    this.enable = true,
    this.borderColor = 0xffFC6973,
    this.unSatisfy = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    Color _color = color.withOpacity(enable ? 1 : unSatisfy);

    return new Container(
      margin: margin,
      child: new InkWell(
        child: new Container(
          alignment: Alignment.center,
          padding: padding,
          width: width,
          height: height,
          decoration: gradient != null
              ? BoxDecoration(
            gradient: gradient,
            boxShadow: boxShadow,
            border: isBorder
                ? Border.all(
                width: borderWidth, color: Color(borderColor))
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          )
              : enable
              ? BoxDecoration(
            color: color,
            boxShadow: boxShadow,
            border: isBorder
                ? Border.all(
                width: borderWidth, color: Color(borderColor))
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          )
              : BoxDecoration(
            color: _color,
            boxShadow: boxShadow,
            border: isBorder
                ? Border.all(
                width: borderWidth, color: Color(borderColor))
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: new Text(
            '$text',
            style: style != null
                ? style
                : TextStyle(fontSize: 15.0, color: _color),
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          if (enable && onTap != null) {
            onTap();
          }
        },
      ),
    );
  }
}
