import 'package:azlistview/azlistview.dart';
import 'package:jh_legal_affairs/http/base_request.dart';

///获取钱包可用金额 model
class WallerDetailMoneyModel extends BaseRequest {
  @override
  String url() => '/income/frozen_amount';
}

///获取收支明细 model
class WallerDetailModel extends BaseRequest {
  final String endTime;
  final String startTime;
  final String inEx;

  WallerDetailModel({
    this.endTime,
    this.startTime,
    this.inEx,
  });

  @override
  String url() => '/income/income_expenses_record/$inEx/$startTime/$endTime';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [收支记录
*
* @param amount number 金额
* @param time string($date) 时间]
* */
class WallMoneyListModel extends ISuspensionBean {
  final double amount;
  final String time;
  final String index;

  WallMoneyListModel({
    this.amount,
    this.time,
    this.index = 'A',
  });

  factory WallMoneyListModel.fromJson(Map<String, dynamic> json) =>
      _$WallMoneyListModelFromJson(json);

  WallMoneyListModel from(Map<String, dynamic> json) =>
      _$WallMoneyListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['time'] = this.time;
    return data;
  }

  @override
  String getSuspensionTag() => index ?? 'A';
}

WallMoneyListModel _$WallMoneyListModelFromJson(Map<String, dynamic> json) {
  return WallMoneyListModel(
    amount: json['amount'],
    time: json['time'],
    index: '${DateTime.parse(json['time']).month}月',
  );
}

///修改支付密码
class WallerPaymentCodeRequestModel extends BaseRequest {
  final String code;
  final String mobile;
  final String firstPassword;
  final String secondPassword;

  WallerPaymentCodeRequestModel(
      {this.code, this.mobile, this.firstPassword, this.secondPassword});

  @override
  String url() => '/user/payment_code';

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'mobile': this.mobile,
      'firstPassword': this.firstPassword,
      'secondPassword': this.secondPassword,
    };
  }
}
