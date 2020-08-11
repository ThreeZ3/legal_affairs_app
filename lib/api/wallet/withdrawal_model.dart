import 'package:jh_legal_affairs/http/base_request.dart';

///提现model
class WithDrawalModel extends BaseRequest {
  final String amount;
  final int type;

  WithDrawalModel({this.amount, this.type});

  @override
  String url() => '/system/trade-record/withdrawal';

  @override
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'type': this.type,
    };
  }
}
