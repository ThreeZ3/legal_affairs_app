//合同详情

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/contract/contract_view_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';

class ContractDetailsPage extends StatefulWidget {
  final contractId;
  final userId;

  ContractDetailsPage({this.contractId, this.userId});

  @override
  _ContractDetailsPageState createState() => _ContractDetailsPageState();
}

class _ContractDetailsPageState extends State<ContractDetailsPage> {
  Map details;
  bool _start = false;
  String _price;

  @override
  void initState() {
    super.initState();
    getContractDetail();
  }

  getContractDetail() {
    contractViewModel
        .contractDetail(context, id: widget.contractId)
        .then((rep) {
      setState(() {
        details = rep.data;
        _start = true;
        _price = details["data"]["price"].toString();
      });
    }).catchError((e) {
      showToast(context, e?.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: "合同详情",
      ),
      backgroundColor: Colors.white,
      bottomSheet: new Visibility(
        visible: widget.userId != JHData.id(),
        child: new SmallButton(
          minWidth: winWidth(context) - 40,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: new Text('订购合同'),
          onPressed: () => !JHData.isLogin()
              ? routePush(new LoginPage())
              : payDetailDialog(
                  context,
                  itemId: widget.contractId,
                  type: payType.weChat,
                  orderType: 2,
                  price: _price,
                ),
        ),
      ),
      body: !_start
          ? Container()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: ListView(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: details["data"]["img"],
                    height: 121,
                    width: 121,
                  ),
                  SizedBox(height: 12),
                  ContractDetailsList(
                      contractTerms: "合同名称",
                      contractTermsName: details["data"]["title"]),
                  ContractDetailsList(
                    contractTerms: "价格",
                    contractTermsName: "￥" + _price,
                  ),
                  ContractDetailsList(
                      contractTerms: "业务类别",
                      contractTermsName: details["data"]["categoryName"]),
                  ContractDetailsList(
                    contractTerms: "审查合同次数",
                    contractTermsName: details["data"]["contractReview"] + "次",
                  ),
                  ContractDetailsList(
                    contractTerms: "在线视频咨询时长",
                    contractTermsName:
                        '${details["data"]["videoLimit"]}分钟',
                  ),
                  ContractDetailsList(
                    contractTerms: "在线语音咨询时长",
                    contractTermsName:
                        '${details["data"]["voiceLimit"]}分钟',
                  ),
                  ContractDetailsList(
                    contractTerms: "在线文字咨询时长",
                    contractTermsName:
                        '${details["data"]["textLimit"]}分钟',
                  ),
                ],
              ),
            ),
    );
  }
}

//合同详情的抽离组件
class ContractDetailsList extends StatelessWidget {
  final contractTerms;
  final contractTermsName;

  const ContractDetailsList(
      {Key key, this.contractTerms, this.contractTermsName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
      child: Row(
        children: <Widget>[
          Text(
            contractTerms,
            style: TextStyle(fontSize: 14),
          ),
          Spacer(),
          Text(
            contractTermsName,
            style: TextStyle(fontSize: 14, color: Color(0xffFF666666)),
          )
        ],
      ),
    );
  }
}
