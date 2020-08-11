import 'package:flutter/material.dart';

/// 创建者：吕宁
/// 开发者：吕宁
/// 版本：1.0
/// 创建日期：2020-01-01
///
/// 描述
///
///globalVariable 全局变量
///
/// 项目级别的设置、枚举

///token 的几种状态
///
/// [expired]为已过期
/// [notExist]为不存在
/// [available]为未过期
enum tokenExpire {
  EXPIRED,
  NOT_EXIST,
  AVAILABLE,
}

/// 签名密钥
const String SECRET = '';

/// 应用尺寸
///
const double UI_DESIGN_WIDTH = 375.0;
const double UI_DESIGN_HEIGHT = 812.0;

/// 全局图片路径
const String THEME_IMAGE_URL = 'assets/images/';

/// 全局颜色
const Color THEME_COLOR = Color(0xffdcba76);
const Color THEME_BACKGROUND_COLOR = Color(0xfff6f7f7);
const Color THEME_GREY_COLOR = Color.fromRGBO(64, 67, 85, 0.8);
const Color THEME_LINE_COLOR = Color(0xffF4F4FA);

/// 全局 THEME DATA 颜色
const MaterialColor themeColor = const MaterialColor(
  0xffE1B96B,
  const <int, Color>{
    50: const Color(0xffE1B96B),
    100: const Color(0xffE1B96B),
    200: const Color(0xffE1B96B),
    300: const Color(0xffE1B96B),
    400: const Color(0xffE1B96B),
    500: const Color(0xffE1B96B),
    600: const Color(0xffE1B96B),
    700: const Color(0xffE1B96B),
    800: const Color(0xffE1B96B),
    900: const Color(0xffE1B96B),
  },
);

///全局 padding
const double THEME_PADDING_WIDTH = 17.0;

/// 应用底部Tab栏ICON的尺寸 单位PX
///
const int BOTTOM_NAVIGATION_BAR_ICON_WIDTH = 20;
const int BOTTOM_NAVIGATION_BAR_ICON_HEIGHT = 24;
const int BOTTOM_NAVIGATION_BAR_ICON_SIZE = 10;

/// Tab图片URL
///
const String TAB_IMAGE_URL = 'assets/tabs/';

/// Tab图片名称
///
const String TAB_HOME_IMAGE_ACTIVE = 'home-normal.png';
const String TAB_HOME_IMAGE_NORMAL = 'home-normal.png';
const String TAB_SECOND_IMAGE_ACTIVE = 'second-active.png';
const String TAB_SECOND_IMAGE_NORMAL = 'second-normal.png';
const String TAB_THIRD_IMAGE_ACTIVE = 'third-active.png';
const String TAB_THIRD_IMAGE_NORMAL = 'third-normal.png';
const String TAB_FOURTH_IMAGE_ACTIVE = 'fourth-active.png';
const String TAB_FOURTH_IMAGE_NORMAL = 'fourth-normal.png';
const String TAB_MINE_IMAGE_ACTIVE = 'mine-active.png';
const String TAB_MINE_IMAGE_NORMAL = 'mine-normal.png';

/// Tab 颜色
///
const Color TAB_DEFAULT_COLOR = Color.fromRGBO(17, 21, 43, 0.6);
const Color TAB_ACTIVE_COLOR = Color(0xff5461ec);

/// AppBar 相关属性设置
///
/// 设置AppBar的背景色、文字大小、高度
const double APPBAR_NORMAL_HEIGHT = 49.0;
const double APPBAR_EX_HEIGHT = 212.0;
const Color APPBAR_TITLE_COLOR = Color(0xff24262e);
const int APPBAR_EX_HEIGHT_TITLE_FONT_SIZE = 56;
const int APPBAR_NORMAL_HEIGHT_TITLE_FONT_SIZE = 18;

/// 短信类型枚举

enum MessageCode {
  REGISTER,
  UPDATE_PHONE_NUMBER,
  FORGET_LOGIN_PASSWORD,
  SET_PAY_PASSWORD
}

/// 主题按钮
const double THEME_BUTTON_MAIN_HEIGHT = 50.0;
const double THEME_BUTTON_MAIN_RADIUS = 14;
const int THEME_BUTTON_TEXT_SIZE = 16;

/// 用户默认头像
String userDefaultAvatarOld =
    'http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png';

const avatarLawFirm = 'assets/images/avatar/law_firm.png';
const avatarLawyerFemale = 'assets/images/avatar/lawyer_female.png';
const avatarLawyerMan = 'assets/images/avatar/lawyer_man.png';
const avatarCommon = 'assets/images/avatar/commom.png';

/// 模拟网络图片
const String NETWORK_IMAGE =
    'https://p5.ssl.qhimgs1.com/bdr/326__/t01faa0569f68a773ff.jpg';
