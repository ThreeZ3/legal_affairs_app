import 'package:amap_location/amap_location.dart';
import 'package:easy_video_compress/easy_video_compress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alipay/flutter_alipay.dart';
import 'package:fluwx/fluwx.dart';
import 'package:jh_legal_affairs/app.dart';
import 'dart:io';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:takingdata_sdk/takingdata_sdk.dart';
//import 'package:pay_sdk/pay_sdk.dart';

void main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化数据
  JHData.initStore();

  /// 是否模拟登录（写死Token）
  Store(JHActions.isMockLogin()).value = false;

  /// talkingData
  TakingdataSdk.init('DEBD9889AD1E4083B5F57A2479DB8425',
      Platform.isIOS ? 'legal.iOS' : 'legal.android');

  /// 高德IOSkey
  AMapLocationClient.setApiKey('2c88ab75ad7be977d655f09c621a7744');

  /// 高德配置
  await AMapLocationClient.startup(new AMapLocationOption(
      desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));

  /// 视频压缩
  if (Platform.isAndroid) await EasyVideoCompress().platformVersion;

  /// 微信支付注册
  await registerWxApi(
    appId: "wx04ed5fd2809f6194",
    doOnAndroid: true,
    doOnIOS: true,
    universalLink: "https://help.wechat.com/app/hLegalAffairs/",
  );
  await FlutterAlipay.setIosUrlSchema('com.jh.legal.jhLegalAffairs.alipay');

  /// app入口
  runApp(MyApp());

  /// 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// 自定义红屏页
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint("flutterErrorDetails::" + flutterErrorDetails.toString());
    return new Center(child: new Text("网络开小差了"));
  };
}
