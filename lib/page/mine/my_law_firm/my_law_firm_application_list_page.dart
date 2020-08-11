import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/mine/round_check_box.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

class MyLawFirmApplicationListPage extends StatefulWidget {
  @override
  _MyLawFirmApplicationListPageState createState() =>
      _MyLawFirmApplicationListPageState();
}

class _MyLawFirmApplicationListPageState
    extends State<MyLawFirmApplicationListPage> {
  bool _isLoadingOk = false;
  //int _goPage = 1;
  List delList = new List();

  //判断是否删除状态
  bool _delSwitch = false;

  List<FirmApplyListModel> data = new List();

  Future getApplyList() async {
    return myLawFirmViewModel.firmApplyList(context).then((rep) {
      setState(() {
        data = List.from(rep.data);
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
    getApplyList();
    Notice.addListener(JHActions.viewMyFirmRefresh(), (v) => getApplyList());
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.viewMyFirmRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: NavigationBar(
        title: '申请列表',
        /*rightDMActions: <Widget>[
          widget.dataSuperList.id == widget.id
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _delSwitch = !_delSwitch;
                    });
                  },
                  child: new Container(
                    padding: EdgeInsets.all(13.0),
                    child: Image.asset('assets/images/mine/list_icon@3x.png'),
                  ),
                )
              : new Container(),
        ],*/
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DataView(
              isLoadingOk: _isLoadingOk,
              data: data,
              onRefresh: () => getApplyList(),
              onLoad: () => getApplyList(),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  FirmApplyListModel model = data[index];
                  return FirmApplyListCard(
                    data: model,
                    openDel: _delSwitch,
                    delList: delList,
                    itemList: data,
                    id: model.id,
                    userId: model.userId,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: _delSwitch,
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: MagicBt(
                      onTap: () {
                        delCase();
                      },
                      text: '删除',
                      radius: 10.0,
                      height: 40,
                      color: Color.fromRGBO(225, 185, 107, 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: MagicBt(
                      onTap: () {
                        setState(() {
                          _delSwitch = false;
                        });
                      },
                      text: '取消',
                      radius: 10.0,
                      height: 40,
                      color: ThemeColors.color999,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void delCase() {
    ///暂时未有删除接口
    /*for (int a = 0; a < delList.length; a++) {
      sketchViewModel.sketchDel(context, id: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _delSwitch = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {}).then((v) {
        getData(true);
      });
    });*/
  }
}

class FirmApplyListCard extends StatefulWidget {
  final FirmApplyListModel data;
  final bool openDel;
  final List itemList;
  final List delList;
  final String id;
  final String userId;

  const FirmApplyListCard({
    Key key,
    this.data,
    this.openDel,
    this.itemList,
    this.delList,
    this.id,
    this.userId,
  }) : super(key: key);

  @override
  _FirmApplyListCardState createState() => _FirmApplyListCardState();
}

class _FirmApplyListCardState extends State<FirmApplyListCard> {
  int value;
  bool status = false;

  List lawyerInfoData = [];

  putFirmExamine(status) {
    myLawFirmViewModel
        .firmExamine(
      context,
      id: widget.id,
      status: status ? 1 : -1,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  lawyerInfo() {
    lawyerInFoViewModel.lawyerViewInfo(context, id: widget.userId).then((rep) {
      setState(() {
        lawyerInfoData = List.from(rep.data);
      });
    }).catchError((e) {
      showToast(context, e.meesgae);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          !widget.openDel
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(right: 9),
                  child: RoundCheckBox(
                    value: widget.data.delCheck,
                    onChanged: (v) {
                      setState(() {
                        widget.data.delCheck = !widget.data.delCheck;
                        if (widget.data.delCheck)
                          widget.delList.add(widget.data.id);
                        if (!widget.data.delCheck)
                          widget.delList.remove(widget.data.id);
                      });
                    },
                  ),
                ),
          Expanded(
            child: Row(
              children: <Widget>[
                //头像
                _head(),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //信息
                          _information(),
                          //按钮
                          _button(),
                        ],
                      ),
                      SizedBox(height: 5),
                      //类型
                      _type(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  ///头像
   _head(),
   ///信息
  _information(),
  ///按钮
   _button(),
  ///类型
   _type(),
   */

  Widget _head() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: CachedNetworkImage(
        imageUrl: widget.data?.avatar ?? FlutterLogo(),
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _information() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.data?.realName ?? '未知',
          style: TextStyle(
            color: ThemeColors.color333,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '执业5年',
          style: TextStyle(
            color: ThemeColors.color333,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '金湾区 | 红旗镇',
          style: TextStyle(
            color: Color(0xffbfbfbf),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return Column(
      children: <Widget>[
        Btn(
          text: '同意',
          textColor: Colors.white,
          btnBackground: ThemeColors.colorOrange,
          onTap: () {
            setState(() {
              status = true;
            });
            putFirmExamine(status);
          },
        ),
        SizedBox(height: 10),
        Btn(
          text: '拒绝',
          textColor: ThemeColors.colorOrange,
          btnBackground: ThemeColors.colorDivider,
          onTap: () {
            setState(() {
              status = false;
            });
            putFirmExamine(status);
          },
        ),
      ],
    );
  }

  Widget _type() {
    double _width = (MediaQuery.of(context).size.width - 16 * 2 - 8 - 100);
    return Container(
      width: _width,
      height: 30,
      child: Row(
        children: lawyerInfoData.map((item) {
          LawyerViewInfoModel model = item;
          return Wrap(
            spacing: 12,
            children: []..addAll(
                (model.legalField.length > 4
                        ? model.legalField.sublist(0, 4)
                        : model.legalField)
                    .map((item) {
                  LegalFieldModel models = item;
                  return Container(
                    width: (_width - 12 * 3) / 4,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      '${models?.name ?? '未知类别'} ${stringDisposeWithDouble(model?.rank ?? '0')}',
                      style: TextStyle(
                        color: ThemeColors.colorOrange,
                        fontSize: 12,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ThemeColors.colorf0,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }).toList()
                      ..addAll([
                        model.legalField.length > 4 ? Text('...') : Container()
                      ]),
              ),
          );
        }).toList(),
      ),
    );
  }
}

class Btn extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final Color btnBackground;
  final double btnRadius;
  final GestureTapCallback onTap;

  const Btn({
    Key key,
    this.text,
    this.textSize = 12,
    this.textColor,
    this.btnBackground,
    this.btnRadius = 5,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
        decoration: BoxDecoration(
          color: btnBackground,
          borderRadius: BorderRadius.circular(btnRadius),
        ),
      ),
    );
  }
}
