import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/contract/contract_model.dart';
import 'package:jh_legal_affairs/api/contract/contract_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_contract/my_contract_detail_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

import 'publish_online_contract_page.dart';

class MyContractPage extends StatefulWidget {
  final String id;
  final String oc;

  MyContractPage(this.id, this.oc);

  @override
  _MyContractPageState createState() => _MyContractPageState();
}

class _MyContractPageState extends State<MyContractPage> {
  List _getcontractList = new List();
  bool isLoadingOk = false;
  int goPage = 1;
  bool _delSwitch = false;
  List delList = new List();
  String text;

  @override
  void initState() {
    super.initState();
    getcontractListData();
    Notice.addListener(JHActions.contractRefresh(), (v) {
      getcontractListData();
    });
  }

  ///获取当前律师合同列表
  Future getcontractListData([bool isInit = false]) {
    if (isInit) goPage = 1;
    return contractViewModel
        .getcontractList(
      context,
      limit: 6,
      page: goPage,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          _getcontractList = List.from(rep.data);
        } else {
          _getcontractList.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  //删除律师合同
  delContractData() {
    for (int a = 0; a < delList.length; a++) {
      contractViewModel.contractDel(context, id: delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _delSwitch = false;
      delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        getcontractListData();
      });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new NavigationBar(
          title: '${widget.oc}的合同',
          rightDMActions: widget.id == JHData.id() &&
                  JHData.userType() == '2;律师'
              ? <Widget>[
                  listNoEmpty(_getcontractList)
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _delSwitch = !_delSwitch;
                            });
                          },
                          child: new Container(
                            padding: EdgeInsets.all(13.0),
                            child: Image.asset(
                                'assets/images/mine/list_icon@3x.png'),
                          ),
                        )
                      : new Container(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _delSwitch = false;
                      });
                      routePush(ContractIssuePage());
                    },
                    child: new Container(
                      padding: EdgeInsets.all(13.0),
                      child:
                          Image.asset('assets/images/mine/share_icon@3x.png'),
                    ),
                  ),
                ]
              : [],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: DataView(
                isLoadingOk: isLoadingOk,
                data: _getcontractList,
                onRefresh: () => getcontractListData(true),
                onLoad: () {
                  goPage++;
                  return getcontractListData();
                },
                child: ListView(
                  children: _getcontractList.map((item) {
                    ContractsRecordsDataModel model = item;
                    return Row(
                      children: <Widget>[
                        _delSwitch == false
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(left: 16),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        model.delCheck =
                                            !model.delCheck; //不可取消选择
                                        if (model.delCheck)
                                          delList.add(model.id);
                                        if (!model.delCheck)
                                          delList.remove(model.id);
                                        // text = model.id;
                                      });
                                    },
                                    child: model.delCheck
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 22,
                                            color: ThemeColors.colorOrange,
                                          )
                                        : Icon(
                                            Icons.panorama_fish_eye,
                                            size: 22,
                                            color: Colors.grey,
                                          )),
                              ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (_delSwitch) {
                                setState(() {
                                  model.delCheck = !model.delCheck; //不可取消选择
                                  if (model.delCheck) delList.add(model.id);
                                  if (!model.delCheck) delList.remove(model.id);
                                  // text = model.id;
                                });
                              } else {
                                routePush(ContractDetailsPage(
                                  contractId: model.id,
                                  userId: widget.id,
                                ));
                              }
                            },
                            child: IntrinsicHeight(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 12, left: 16, right: 16),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey[300])),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            model?.img ?? userDefaultAvatarOld,
                                        height: 81,
                                        width: 81,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${model.title}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: <Widget>[
                                            new CircleAvatar(
                                              radius: 20 / 2,
                                              backgroundImage: strNoEmpty(
                                                      model?.lawyerAvatar)
                                                  ? CachedNetworkImageProvider(
                                                      "${model?.lawyerAvatar}")
                                                  : AssetImage(avatarLawyerMan),
                                            ),
                                            new Space(width: mainSpace / 3),
                                            Text(
                                              "${model?.lawyerName ?? '未知名称'}",
                                              style: TextStyle(
                                                  color: Color(0xff999999),
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 32,
                                              height: 18,
                                              color: Colors.grey[300],
                                              alignment: Alignment.center,
                                              child: Text(
                                                  "${model.categoryName}",
                                                  style: TextStyle(
                                                      color: Color(0xffE1B96B),
                                                      fontSize: 12)),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000))}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[400]),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "${model.status.split(';')[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffE1B96B)),
                                        ),
                                        Spacer(),
                                        Text(
                                          "￥" + "${model.price}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffFF3333)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(height: 17, color: Colors.white),
            _delSwitch == false
                ? Container()
                : Column(
                    children: <Widget>[
                      RegisterButtonWidget(
                        title: '删除',
                        horizontal: 16,
                        onTap: () => delContractData(),
                      ),
                      SizedBox(height: 14),
                      RegisterButtonWidget(
                        title: '取消',
                        horizontal: 16,
                        titleColors: ThemeColors.color999,
                        backgroundColors: ThemeColors.colore4,
                        onTap: () {
                          setState(() {
                            _delSwitch = false;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.contractRefresh());
  }
}
