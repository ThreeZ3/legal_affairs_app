import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/contract/contract_model.dart';
import 'package:jh_legal_affairs/api/contract/contract_view_model.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class ByContractPage extends StatefulWidget {
  @override
  _ByContractPageState createState() => _ByContractPageState();
}

class _ByContractPageState extends State<ByContractPage> {
  List _getcontractList = new List();
  bool isLoadingOk = false;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData([bool isInit = false]) {
    if (isInit) goPage = 1;
    contractViewModel
        .byContracts(
      context,
      id: JHData.id(),
      limit: 15,
      page: 1,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NavigationBar(title: '我购买的合同'),
      body: DataView(
        isLoadingOk: isLoadingOk,
        data: _getcontractList,
        onRefresh: () => getData(true),
        onLoad: () {
          goPage++;
          return getData();
        },
        child: ListView(
          children: _getcontractList.map((item) {
            ContractsRecordsDataModel model = item;
            return IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[300])),
                      child: CachedNetworkImage(
                        imageUrl: model?.img ?? userDefaultAvatarOld,
                        height: 81,
                        width: 81,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${model.title}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            new CircleAvatar(
                              radius: 20 / 2,
                              backgroundImage: strNoEmpty(model?.lawyerAvatar)
                                  ? CachedNetworkImageProvider(
                                      "${model?.lawyerAvatar}")
                                  : AssetImage(avatarLawyerMan),
                            ),
                            new Space(width: mainSpace / 3),
                            Text(
                              "${model?.lawyerName ?? '未知名称'}",
                              style: TextStyle(
                                  color: Color(0xff999999), fontSize: 14),
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
                              child: Text("${model.categoryName}",
                                  style: TextStyle(
                                      color: Color(0xffE1B96B), fontSize: 12)),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000))}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[400]),
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${model.status.split(';')[1]}",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffE1B96B)),
                        ),
                        Spacer(),
                        Text(
                          "￥" + "${model.price}",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xffFF3333)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
