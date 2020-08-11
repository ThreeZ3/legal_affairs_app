import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_lecture/my_courseware_page.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class MySubscribePage extends StatefulWidget {
  final String id;

  MySubscribePage(this.id);

  @override
  _MySubscribePageState createState() => _MySubscribePageState();
}

class _MySubscribePageState extends State<MySubscribePage> {
  bool _isLoadingOk = false;
  int _goPage = 1;
  List _lectureListData = new List();

  /// 获取课件列表
  Future getLectureListData([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return lectureViewModel
        .lectureSubList(
      context,
      limit: 10,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          _lectureListData = List.from(rep.data);
        } else {
          _lectureListData.addAll(List.from(rep.data));
        }
        _isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => _isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getLectureListData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ThemeColors.colorBackground,
      appBar: new NavigationBar(title: '我的订阅'),
      body: new DataView(
        isLoadingOk: _isLoadingOk,
        data: _lectureListData,
        onRefresh: () => getLectureListData(true),
        onLoad: () {
          _goPage++;
          return getLectureListData();
        },
        child: ListView(
          padding: EdgeInsets.only(bottom: 12),
          children: _lectureListData
              .map((item) => LectureListItem(
                    data: item,
                    isUserId: widget.id,
                    openDel: false,
                    delList: [],
                    isBy: true,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
