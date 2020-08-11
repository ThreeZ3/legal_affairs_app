import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/page/mine/my_ad/my_ad_page.dart';
import 'package:jh_legal_affairs/page/mine/my_advisory/my_advisory_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_my_task_page.dart';
import 'package:jh_legal_affairs/page/mine/my_case/my_case_page.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_courseware_page.dart';
import 'package:jh_legal_affairs/page/mine/my_pictures/my_pictures.dart';
import 'package:jh_legal_affairs/page/mine/my_contract/my_contract_page.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/my_sourcecase.dart';
import 'package:nav_router/nav_router.dart';

class LawyerItem extends StatelessWidget {
  final String item;
  final VoidCallback onPressed;
  final String id;

  LawyerItem(this.item, {this.onPressed, this.id});

  @override
  Widget build(BuildContext context) {
    /// ///暂时来区别发布者与非发布者
    bool isComUser = true;

    //跳转页面入口集合
    Map _routePage = {
      '我的案源': MySourcecase(id, '我'),
      '他/她的案源': MySourcecase(id, '他/她'),
      '我的合同': MyContractPage(id, '我'),
      '他/她的合同': MyContractPage(id, '他/她'),
      '我的任务': LawyerMyTaskPage(id, '我'),
      '他/她的任务': LawyerMyTaskPage(id, '他/她'),
      '我的咨询': MyAdvisoryPage(id, '我'),
      '他/她的咨询': MyAdvisoryPage(id, '他/她'),
      '我的图文': MyPicturesPage(id, '我'),
      '他/她的图文': MyPicturesPage(id, '他/她'),
      '我的课件': MyCourseWarePage(id, '我'),
      '他/她的课件': MyCourseWarePage(id, '他/她'),
      '我的案例': MyCasePage(id, '我'),
      '他/她的案例': MyCasePage(id, '他/她'),
      '我的广告': MyAdPage(id, '我'),
      '他/她的广告': MyAdPage(id, '他/她'),
    };

    return new FlatButton(
      onPressed: () {
        routePush(_routePage[item]);
      },
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            '$item',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          new Icon(CupertinoIcons.right_chevron)
        ],
      ),
    );
  }
}
