import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/contract/contract_model.dart';
import 'package:jh_legal_affairs/common/ui.dart';
import 'package:jh_legal_affairs/page/mine/my_contract/my_contract_detail_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

import 'package:jh_legal_affairs/api/contract/contract_view_model.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';

import '../../../widget_common/data/data_view.dart';
import '../../../widget_common/view/show_toast.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 律所详情-咨询合同
///
class ConsultantContractPage extends StatefulWidget {
  final String id;
  final bool isMe;

  ConsultantContractPage(this.id, this.isMe);

  @override
  _ConsultantContractPageState createState() => _ConsultantContractPageState();
}

class _ConsultantContractPageState extends State<ConsultantContractPage> {
  List<ContractFirmModel> data = new List();
  bool isLoadingOk = false;
  int _goPage = 1;
  bool openDel = false;
  List delList = new List();

  @override
  void initState() {
    super.initState();
    contractFirmGet();
    Notice.addListener(JHActions.contractRefresh(), (v) {
      contractFirmGet(true);
    });
  }

  Future contractFirmGet([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return contractViewModel
        .contractFirm(
      context,
      id: widget.id,
      page: _goPage,
      limit: 15,
    )
        .then((rep) {
      setState(() {
        data = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.emssage);
    });
  }

  ///超级管理员-删除合同
  void delContract() {
    for (int a = 0; a < delList.length; a++) {
      contractViewModel.contractDel(context, id: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      openDel = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        contractFirmGet(true);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.contractRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: new NavigationBar(
        title: '顾问合同',
        rightDMActions: widget.isMe
            ? <Widget>[
                new GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      openDel = !openDel;
                    });
                  },
                  child: Image.asset(
                    'assets/images/mine/list_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                new SizedBox(
                  width: 15,
                ),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: new DataView(
              isLoadingOk: isLoadingOk,
              data: data,
              onRefresh: () => contractFirmGet(true),
              onLoad: () {
                _goPage++;
                return contractFirmGet();
              },
              child: ListView(
                padding: EdgeInsets.only(top: 4, left: 16, right: 16),
                children: data.map((item) {
                  return ContractFirmItem(
                    data: item,
                    openDel: openDel,
                    itemList: data,
                    delList: delList,
                  );
                }).toList(),
              ),
            ),
          ),
          new Visibility(
            visible: openDel,
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
                        delContract();
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
                          openDel = false;
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
}

class ContractFirmItem extends StatefulWidget {
  final ContractFirmModel data;
  final bool openDel;
  final List itemList;
  final List delList;

  const ContractFirmItem(
      {Key key, this.data, this.openDel, this.itemList, this.delList})
      : super(key: key);

  @override
  _ContractFirmItemState createState() => _ContractFirmItemState();
}

class _ContractFirmItemState extends State<ContractFirmItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Container(
                margin: EdgeInsets.only(right: 8),
                width: 16,
                height: 16,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.data.delCheck = !widget.data.delCheck;
                        if (widget.data.delCheck)
                          widget.delList.add(widget.data.id);
                        if (!widget.data.delCheck)
                          widget.delList.remove(widget.data.id);
                      });
                    },
                    child: widget.data.delCheck
                        ? Icon(
                            Icons.check_circle,
                            size: 20.0,
                            color: Color(0xffC0984E),
                          )
                        : Icon(
                            Icons.panorama_fish_eye,
                            size: 20.0,
                            color: Colors.grey,
                          )),
              ),
        Expanded(child: contractFirmItem(widget.data)),
      ],
    );
  }
}

Widget contractFirmItem(item) {
  ContractFirmModel model = item;
  return Column(
    children: <Widget>[
      InkWell(
        onTap: () => routePush(new ContractDetailsPage(
          contractId: model.id,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
//                  Image.asset(
//                    "assets/images/law_firm/book.png",
//                    width: 130,
//                    height: 79,
//                    fit: BoxFit.cover,
//                  ),
                  new CachedNetworkImage(
                    imageUrl: '${model?.img ?? userDefaultAvatarOld}',
                    width: 100,
                    height: 79,
                    fit: BoxFit.cover,
                  ),
                  new Space(),
                  new Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${model.title}",
                        style: TextStyle(
                          color: Color(0xff24262e),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Space(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25 / 2,
                            backgroundImage: strNoEmpty(model?.lawyerAvatar)
                                ? CachedNetworkImageProvider(
                                    model?.lawyerAvatar)
                                : AssetImage(avatarLawyerMan),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${model?.lawyerName ?? '未知发布者'}",
                            style: TextStyle(
                              color: Color(0xffaaaaaa),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Space(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 31,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '${model?.categoryName ?? '未知类别'}',
                              style: TextStyle(
                                color: Color(0xffEBB769),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: 8),
                          new Expanded(
                              child: Text(
                            '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                            style: TextStyle(
                              color: Color(0xffaaaaaa),
                              fontSize: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Container(
              height: 77,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      '${model.status.split(";")[1]}',
                      style: 1 <= 2
                          ? TextStyle(
                              color: Color(0xffebb769),
                              fontSize: 12,
                            )
                          : TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12,
                            ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Space(),
                  Container(
                    child: Text(
                      '￥${model.price}',
                      style: TextStyle(
                          color: Color(0xffff3333),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Divider(
        color: ThemeColors.coloref,
      ),
    ],
  );
}
