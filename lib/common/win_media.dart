/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-13
///
/// 媒体查询封装
import 'dart:ui';

import 'package:flutter/material.dart';

/// 屏幕宽度
double winWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// 屏幕高度
double winHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// 顶部距离
double winTop(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// 底部距离
double winBottom(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

/// 左边距离
double winLeft(BuildContext context) {
  return MediaQuery.of(context).padding.left;
}

/// 右边距离
double winRight(BuildContext context) {
  return MediaQuery.of(context).padding.right;
}

/// 键盘高度
/// 如果为0则是键盘未弹出
double winKeyHeight(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom;
}

/// 状态栏高度
double statusBarHeight(BuildContext context) {
  return MediaQueryData.fromWindow(window).padding.top;
}

/// navigationBar高度
double navigationBarHeight(BuildContext context) {
  return kToolbarHeight;
}

/// 整AppBar高度
/// 状态栏高度 + navigationBar高度
double topBarHeight(BuildContext context) {
  return navigationBarHeight(context) + statusBarHeight(context);
}
