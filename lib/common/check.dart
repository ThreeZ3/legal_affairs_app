/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-13
///
/// 校验

import 'package:flutter/material.dart';

/// 手机号正则表达式->true匹配
bool isMobilePhoneNumber(String value) {
  RegExp mobile = new RegExp(r"(0|86|17951)?(1[0-9][0-9])[0-9]{8}");

  return mobile.hasMatch(value);
}

///验证网页URl
bool isUrl(String value) {
  RegExp url = new RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");

  return url.hasMatch(value);
}

///校验身份证
bool isIdCard(String value) {
  if (!strNoEmpty(value)) return false;
  RegExp identity = new RegExp(r"\d{17}[\d|x]|\d{15}");

  return identity.hasMatch(value);
}

///正浮点数
bool isMoney(String value) {
  RegExp identity = new RegExp(
      r"^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$");
  return identity.hasMatch(value);
}

///校验中文
bool isChinese(String value) {
  RegExp identity = new RegExp(r"[\u4e00-\u9fa5]");

  return identity.hasMatch(value);
}

///校验支付宝名称
bool isAliPayName(String value) {
  RegExp identity = new RegExp(r"[\u4e00-\u9fa5_a-zA-Z]");

  return identity.hasMatch(value);
}

/// 字符串不为空
bool strNoEmpty(String value) {
  if (value == null) return false;

  return value.trim().isNotEmpty;
}

/// 字符串不为空
bool mapNoEmpty(Map value) {
  if (value == null) return false;
  return value.isNotEmpty;
}

///判断List是否为空
bool listNoEmpty(List list) {
  if (list == null) return false;

  if (list.length == 0) return false;

  return true;
}

///判断验证码是否正确
bool isValidateCaptcha(String value) {
  RegExp mobile = new RegExp(r"\d{6}$");
  return mobile.hasMatch(value);
}

///验证金额价格的正则表达式
bool isPrice(String value) {
  RegExp mobile = new RegExp(r"(?!^0*(\.0{1,2})?$)^\d{1,13}(\.\d{1,2})?$");
  return mobile.hasMatch(value);
}

/// 判断是否网络
bool isNetWorkImg(String img) {
  return img.startsWith('http') || img.startsWith('https');
}

/// 判断是否资源图片
bool isAssetsImg(String img) {
  return img.startsWith('asset') || img.startsWith('assets');
}

double getMemoryImageCache() {
  return PaintingBinding.instance.imageCache.maximumSize / 1000;
}

void clearMemoryImageCache() {
  PaintingBinding.instance.imageCache.clear();
}

String stringAsFixed(value, num) {
  double v = double.parse(value.toString());
  String str = ((v * 100).floor() / 100).toStringAsFixed(2);
  return str;
}

/// 隐藏手机号
String hiddenPhone(String phone) {
  String result = '';

  if (phone != null && phone.length >= 11) {
    String sub = phone.substring(0, 3);
    String end = phone.substring(8, 11);
    result = '$sub*****$end';
  }

  return result;
}

/// 隐藏用户名
String hiddenUserName(String userName) {
  String result = '';

  if (userName != null && userName.length >= 3) {
    String sub = userName.substring(0, 2);
    String end = userName.substring(2, 3);
    result = '$sub****$end';
  }

  return result;
}

///去除后面的0
String stringDisposeWithDouble(v, [fix = 0]) {
  if (v == null) return '0';
  double b = double.parse(v.toString());
  String vStr = b.toStringAsFixed(fix);
  int len = vStr.length;
  for (int i = 0; i < len; i++) {
    if (vStr.contains('.') && vStr.endsWith('0')) {
      vStr = vStr.substring(0, vStr.length - 1);
    } else {
      break;
    }
  }

  if (vStr.endsWith('.')) {
    vStr = vStr.substring(0, vStr.length - 1);
  }

  return vStr;
}

/// 距离大于1000 显示km
String stringDisposeToKm(v) {
  if (v == null) return '0';
  int distance = double.parse(v.toString()).ceil();
  String d = distance
      .toString()
      .substring(0, v.toString().length > 3 ? v.toString().length - 3 : 0);
  if (distance > 1000) {
    int num = int.parse(distance
        .toString()
        .substring(distance.toString().length - 3, distance.toString().length));
    if (num >= 500) {
      return (int.parse(d) + 1).toString() + "km";
    }
    return d + "km";
  } else {
    return v + "m";
  }
}

/// 邮箱正则
final String regexEmail =
    "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

/// 检查是否是邮箱格式
bool isEmail(String input) {
  if (input == null || input.isEmpty) return false;
  return new RegExp(regexEmail).hasMatch(input);
}

/// 数字千分位方法及其价格保留两位小数
String formatNum(num, {point: 2}) {
  if (num != null) {
    String str = double.parse(num.toString()).toString();
    List<String> sub = str.split('.');
    List val = List.from(sub[0].split(''));
    List<String> points = List.from(sub[1].split(''));
    for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
      //  && i != 1
      if (index % 3 == 0 && index != 0) val[i] = val[i] + ',';
    }
    for (int i = 0; i <= point - points.length; i++) {
      points.add('0');
    }
    if (points.length > point) {
      points = points.sublist(0, point);
    }
    if (points.length > 0) {
      return '${val.join('')}.${points.join('')}';
    } else {
      return val.join('');
    }
  } else {
    return "0.0";
  }
}

String limitToMonth(int limit) {
  if (limit == null || limit == 0) return '0天';
  switch (limit) {
    case 7:
      return '一周';
      break;
    case 14:
      return '两周';
      break;
    case 1 * 30:
      return '一个月';
      break;
    case 2 * 30:
      return '1~2个月';
      break;
    case 6 * 30:
      return '半年';
      break;
    case 12 * 30:
      return '一年';
      break;
    default:
      return '$limit天';
      break;
  }
}

/// 工作年限
String workYearStr(workYear) {
  if (workYear == null) return '0';
  try {
    Duration duration = DateTime.parse(workYear).difference(DateTime.now());
    String result = stringDisposeWithDouble(duration.inDays / 365, 0);
    return result.replaceAll('-', '');
  } catch (e) {
    return '0';
  }
}

void likeHandle(currentLikeStatus, oldStatus, model) {
  if (currentLikeStatus == 2 && oldStatus == 1) {
    model.dislikeCount--;
    model.likeCount++;
  } else if (currentLikeStatus == 2 && oldStatus == 2) {
    model.dislikeCount--;
  } else if (currentLikeStatus == 1 && oldStatus == 2) {
    model.likeCount--;
    model.dislikeCount++;
  } else if (currentLikeStatus == 1 && oldStatus == 1) {
    model.likeCount--;
  } else if (currentLikeStatus == 0 && oldStatus == 1) {
    model.likeCount++;
  } else if (currentLikeStatus == 0 && oldStatus == 2) {
    model.dislikeCount++;
  }
}


///去除小数点
String removeDot(v) {
  String vStr = v.toString().replaceAll('.', '');

  return vStr;
}