import 'dart:io';

import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/common/global_variable.dart';
import 'package:jh_legal_affairs/model/tabbar_model.dart';
import 'package:jh_legal_affairs/page/business/business_page.dart';
import 'package:jh_legal_affairs/page/home/home_page.dart';
import 'package:jh_legal_affairs/page/law_firm/law_firm_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_page.dart';
import 'package:jh_legal_affairs/page/mine/mine_page.dart';
import 'package:jh_legal_affairs/util/tools.dart' hide showToast;
import 'package:jh_legal_affairs/widget/dialog/update_dialog.dart';
import 'package:jh_legal_affairs/widget/root_tabbar.dart';
import 'package:nav_router/nav_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:async';
import 'package:uni_links/uni_links.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(
        color: Color(0xffFAFAFA),
      ),
      textPadding: EdgeInsets.only(left: 16, right: 15, top: 10, bottom: 10),
      position: ToastPosition.center,
      backgroundColor: Color(0xff484848),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navGK,
        title: '法π',
        theme: ThemeData(
          hintColor: Colors.grey.withOpacity(0.3),
          splashColor: Colors.transparent,
          scaffoldBackgroundColor: Color.fromRGBO(243, 243, 243, 1),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Color(0xff333333),
            labelColor: Color(0xff333333),
          ),
          indicatorColor: THEME_COLOR,
          primaryColor: themeColor,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        locale: Locale('zh'),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => RootPage(),
        },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  List<TabBarModel> pages() {
    return [
      new TabBarModel(
        title: '首页',
        icon: new Image.asset('assets/images/tab/tab_home_c.webp', width: 20.9),
        selectIcon:
            new Image.asset('assets/images/tab/tab_home_s.webp', width: 20.9),
        page: new HomePage(),
      ),
      new TabBarModel(
        title: '律所',
        icon: new Image.asset('assets/images/tab/tab_lawfirm_c.webp',
            width: 20.9),
        selectIcon: new Image.asset('assets/images/tab/tab_lawfirm_c.webp',
            color: Color(0xffE1B96B), width: 20.9),
        page: new LawFirmPage(),
      ),
      new TabBarModel(
        title: '业务',
        icon: new Image.asset('assets/images/tab/tab_business_c.webp',
            width: 20.9),
        selectIcon: new Image.asset('assets/images/tab/tab_business_s.webp',
            width: 20.9),
        page: new BusinessPage(),
      ),
      new TabBarModel(
        title: '律师',
        icon:
            new Image.asset('assets/images/tab/tab_lawyer_c.webp', width: 20.9),
        selectIcon: new Image.asset('assets/images/tab/tab_lawyer_c.webp',
            color: Color(0xffE1B96B), width: 20.9),
        page: new LawyerPage(),
      ),
      new TabBarModel(
        title: '我的',
        icon: new Image.asset('assets/images/tab/tab_mine_c.webp', width: 20.9),
        selectIcon:
            new Image.asset('assets/images/tab/tab_mine_s.webp', width: 20.9),
        page: new MinePage(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Notice.addListener(JHActions.isLogin(), (isLogin) {
      loginViewModel.userPosition(context);
    });

    _checkPersmission();
    checkVersion();
    initUniLinks();
  }

  Future<Null> initUniLinks() async {
    print('------获取参数--------');
    getLinksStream().listen((String link) {
      print("这是参数：$link");
    }, onError: (err) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _checkPersmission([bool isTips = true]) async {
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if (permission == PermissionStatus.granted) {
      AMapLocation loc = await AMapLocationClient.getLocation(true);
      location = loc;
      if (JHData.isLogin()) {
        loginViewModel.userPosition(context);
      }
    } else {
      if (isTips) showToast('请开启定位功能', context: context);
    }
  }

  /// 检查更新 [check update]
  checkVersion() async {
    if (Platform.isIOS) return;

    final packageInfo = await PackageInfo.fromPlatform();
    systemViewModel.getVersion(context).then((rep) {
      VersionModel model = rep.data;
      int currentVersion = int.parse(removeDot(packageInfo.version));
      int netVersion = int.parse(removeDot(model.version));
      if (currentVersion >= netVersion) {
        debugPrint('当前版本是最新版本');
        return;
      }

      showDialog(
        context: context,
        builder: (ctx2) {
          return UpdateDialog(
            version: model.version,
            updateUrl: model.url,
            updateInfo: model.content,
            isForce: model.isUpdate == 1,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RootTabBar(pages: pages(), currentIndex: 0),
//      body: new CacheWidget(JHActions.isLogin(), (v) {
//        return v
//            ? new RootTabBar(pages: pages(), currentIndex: 0)
//            : new LoginPage();
//      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
