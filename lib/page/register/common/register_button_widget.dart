import 'package:flutter/material.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 按钮

class RegisterButtonWidget extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color titleColors;
  final Color backgroundColors;
  final double fontSize;
  final double radiusCircularAll;
  final GestureTapCallback onTap;
  final double horizontal;
  final double vertical;

  const RegisterButtonWidget({
    Key key,
    this.title,
    this.height = 48.0,
    this.width = double.infinity,
    this.titleColors = Colors.white,
    this.backgroundColors = const Color(0xffE1B96B),
    this.fontSize = 18.0,
    this.radiusCircularAll = 5.0,
    this.onTap,
    this.horizontal = 0,
    this.vertical = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        margin:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Text(
          title,
          style: TextStyle(color: titleColors, fontSize: fontSize),
        ),
        decoration: BoxDecoration(
          color: backgroundColors,
          borderRadius: BorderRadius.all(Radius.circular(radiusCircularAll)),
        ),
      ),
    );
  }
}
