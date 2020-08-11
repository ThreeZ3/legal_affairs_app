import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/http/base_request.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'withdrawal_model.dart';

///提现view model
class WithdrawalViewModel extends BaseViewModel {
  static Future<ResponseModel> getWithdrawalViewModel(BuildContext context,
      {String amount, int type}) async {
    double _amount = double.parse(amount.replaceAll('￥', ''));
    ResponseModel data = await WithDrawalModel(amount: '$_amount', type: type)
        .sendApiAction(context, hud: '请求中', reqType: ReqType.post)
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
