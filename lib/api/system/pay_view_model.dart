import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/system/pay_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

PayViewModel payViewModel = new PayViewModel();

class PayViewModel extends BaseViewModel {
  /// 微信支付回调
  Future<ResponseModel> wxPayCallback(
    BuildContext context,
  ) async {
    ResponseModel data = await WxPayCallbackRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 统一下单接口
  Future<ResponseModel> placeOrder(
    BuildContext context, {
    final String amount,
    final int orderType,
    final int payType,
    final String sourceId,
  }) async {
    ResponseModel data = await PlaceOrderRequestModel(
      amount: amount,
      orderType: orderType,
      payType: payType,
      sourceId: sourceId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.payRefresh());
      pop(true);
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
