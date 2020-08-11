import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/data/data.dart';
import 'package:jh_legal_affairs/model/tabbar_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

typedef CheckLogin(int index);

class RootTabBar extends StatefulWidget {
  RootTabBar({
    this.pages,
    this.checkLogin,
    this.currentIndex = 0,
  });

  final List<TabBarModel> pages;
  final CheckLogin checkLogin;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => new RootTabBarState();
}

class RootTabBarState extends State<RootTabBar> {
  int currentIndex;
  PageController pageController = new PageController();
  bool nextKickBackExitApp = false;
  @override
  void initState() {
    super.initState();

    currentIndex = widget.currentIndex;
    Notice.addListener(JHActions.toTabBarIndex(), (index) {
      setState(() => currentIndex = index);
      pageController.jumpToPage(index);
//      if (index == 4) Notice.send(JHActions.minePageRefresh());
    });
  }

  BottomNavigationBarItem itemBuild(item) {
    TabBarModel model = item;
    return new BottomNavigationBarItem(
      icon: model.icon,
      activeIcon: model.selectIcon,
      title: new Text(model.title, style: new TextStyle(fontSize: 12.0)),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return new BottomNavigationBar(
      items: widget.pages.map(itemBuild).toList(),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      fixedColor: Color(0xffE1B96B),
      unselectedItemColor: Colors.white,
      backgroundColor: Color(0xff333333),
      onTap: (int index) async {
        if (widget.checkLogin != null) {
          widget.checkLogin(index);
        } else if (index == 4 && !JHData.isLogin()) {
          routePush(LoginPage());
        } else {
          setState(() => currentIndex = index);
          pageController.jumpToPage(index);
          Notice.send(JHActions.toTab(index), 'refresh');
        }
      },
      iconSize: 18.0,
    );
  }

  Widget pageBuild(item) {
    TabBarModel model = item;
    return model.page;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(),
          body: new PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: widget.pages.map((item) {
              return item.page;
            }).toList(),
            onPageChanged: (index) {
              Notice.send(JHActions.toTabBarIndex(), index);
            },
          ),
//      body: new IndexedStack(
//        index: currentIndex,
//        children: widget.pages.map(pageBuild).toList(),
//      ),
        ),
        onWillPop: () async {
          if (nextKickBackExitApp) {
            return Future<bool>.value(true);
          } else {
            showToast(context, '再按一次退出app');
            nextKickBackExitApp = true;
            Future.delayed(
              const Duration(seconds: 2),
              () => nextKickBackExitApp = false,
            );
            return Future<bool>.value(false);
          }
        });
  }
}
