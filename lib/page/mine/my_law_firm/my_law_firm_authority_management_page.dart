import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/add_member.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/button/title_icon_btn.dart';

/// 创建者：李鸿杰
/// 开发者：李鸿杰
/// 创建日期：2020-05-12
///
/// 我的-权限管理(管理员)
///
class MyLawAuthorityManagementPage extends StatefulWidget {
  @override
  _MyLawAuthorityManagementPageState createState() =>
      _MyLawAuthorityManagementPageState();
}

class _MyLawAuthorityManagementPageState
    extends State<MyLawAuthorityManagementPage> {
  List dataList = List();
  bool isLoadingOk = false;

  @override
  void initState() {
    super.initState();
    getMyLawFirm();
    Notice.addListener(JHActions.myLawFirmRefresh(), (v) {
      getMyLawFirm();
    });
    Notice.addListener(JHActions.memberPermissions(), (v) {
      getMyLawFirm();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myLawFirmRefresh());
    Notice.removeListenerByEvent(JHActions.memberPermissions());
  }

  /// 获取管理员列表
  Future getMyLawFirm() async {
    myLawFirmViewModel
        .viewFirmNumber(
      context,
    )
        .then((rep) {
      setState(() {
        dataList = rep.data;
        isLoadingOk = true;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '权限管理',
        rightDMActions: <Widget>[
          InkWell(
            child: Image.asset(
              'assets/register/icon_add.png',
              width: 22,
            ),
            onTap: () {
              routePush(AddMemberPage());
//              routePush(new SearchPage(
//                SearchType.lawyer,
//                callback: (id) {
//                  if (!strNoEmpty(id)) return;
//                  inviteHandle(id);
//                },
//              ));
            },
          ),
          new SizedBox(width: 14),
        ],
      ),
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: dataList,
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) =>
                AuthorityManagementWidget(data: dataList[index])),
      ),
    );
  }

  inviteHandle(id) {
    firmViewModel.firmInvited(context, userId: id).catchError((e) {
      showToast(context, e.message);
    });
  }
}

class AuthorityManagementWidget extends StatelessWidget {
  double _globlePositionY = 0.0;

  final FirmNumberModel data;

  AuthorityManagementWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            new Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: strNoEmpty(data?.avatar)
                      ? CachedNetworkImageProvider(data?.avatar)
                      : AssetImage(avatarLawFirm),
                ),
              ),
            ),
            Space(width: 8),
            Text('${data?.realName ?? '未知'}'),
            Spacer(),
            TitleIconBtn(
              title: '${data.type?.split(';')[1] ?? '未知内容'}',
              imgUrl: 'assets/images/mine/drop_down.png',
            ),
          ],
        ),
      ),
      onTap: () =>
          _showPromptBox(context, data.userId, data.type.split(";")[0]),
      onPanDown: (DragDownDetails details) {
        _globlePositionY = details.globalPosition.dy;
      },
    );
  }

  _showPromptBox(context, id, type) {
    int memberType = int.parse(type);
    double _base = _globlePositionY - 10;
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned(
              right: 16,
              top: _base > 600 ? _base - 70 : _base,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  alignment: Alignment.center,
                  /*height: 32,*/
                  width: 150,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => deleteFirmAdmin(context, id),
                        child: Text(
                          '移除',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                      Divider(),
                      memberType == 1
                          ? InkWell(
                              onTap: () => putFirmAdmin(context, 0, id),
                              child: Text(
                                '设为超级管理员',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            )
                          : InkWell(
                              onTap: () => putFirmAdmin(context, 1, id),
                              child: Text(
                                '设为管理员',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  ///修改律所成员权限
  putFirmAdmin(context, type, userId) async {
    firmViewModel.putFirmAdmin(context, type: type, userId: userId).then((rep) {
      pop();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///删除管理员
  deleteFirmAdmin(context, id) async {
    firmViewModel
        .deleteAdmin(
      context,
      id,
    )
        .then((rep) {
      showToast(context, '删除成功');
      Notice.send(JHActions.myLawFirmRefresh(), '');
      Navigator.pop(context);
    }).catchError((e) {
      showToast(context, e.message);
      Navigator.pop(context);
    });
  }
}
