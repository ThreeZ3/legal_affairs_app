import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/wallet/waller_detail_model.dart';
import 'package:jh_legal_affairs/api/wallet/waller_detail_view_model.dart';
import 'package:jh_legal_affairs/page/wallet/wallet_money_detail.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class OutRecordPage extends StatefulWidget {
  final String inEx;
  final String start;
  final String end;

  OutRecordPage(this.inEx, this.start, this.end);

  @override
  _OutRecordPageState createState() => _OutRecordPageState();
}

class _OutRecordPageState extends State<OutRecordPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoadingOk = false;
  bool isSelect = false;
  String _suspensionTag = '最近';
  double total = 0.0;

  List<WallMoneyListModel> data = new List();

  @override
  void initState() {
    super.initState();
    _detail();
  }

  Future _detail() async {
    return WallerDetailViewModel()
        .getWallerDetailViewModel(
      context,
      endTime: widget.end,
      startTime: widget.start,
      inEx: widget.inEx,
    )
        .then((rep) {
      setState(() {
        data = List.from(rep.data);
        data.forEach((WallMoneyListModel model) {
          total = total + model.amount;
        });
//        SuspensionUtil.sortListBySuspensionTag(data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  Widget _buildSusWidget(String susTag, [String option]) {
    return new Details(data: susTag, option: option);
  }

  _buildListItem(item) {
    WallMoneyListModel model = item;
    return new Column(
      children: <Widget>[
        Offstage(
          offstage: !model.isShowSuspension,
          child: _buildSusWidget(
              model.index, '${total > 0 ? '收入' : '支出'}:￥$total'),
        ),
        Container(
          height: 44,
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              color: Color(0XFF333333),
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Colors.grey.withOpacity(0.5)))),
          width: winWidth(context),
          child: Row(
            children: <Widget>[
              Text(
                '${model?.time ?? '未知时间'}',
                style: TextStyle(
                    color: Color(0XFFE1B96B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '${model?.amount ?? '未知'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _onSusTagChanged(String tag) {
    setState(() => _suspensionTag = tag);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new DataView(
      isLoadingOk: isLoadingOk,
      data: data,
      child: AzListView(
        data: data,
        suspensionWidget: _buildSusWidget(_suspensionTag),
        onSusTagChanged: _onSusTagChanged,
        itemBuilder: (context, model) => _buildListItem(model),
        isUseRealIndex: true,
        itemHeight: 44,
        suspensionHeight: 30,
        indexBarBuilder: (BuildContext context, List<String> tags,
            IndexBarTouchCallback onTouch) {
          return new Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => listNoEmpty(data);
}
