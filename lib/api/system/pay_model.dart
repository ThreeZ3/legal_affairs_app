import 'package:jh_legal_affairs/http/base_request.dart';

/// wxPayCallback
class WxPayCallbackRequestModel extends BaseRequest {
  @override
  String url() => '/wxPayCallback';
}

/// 统一下单接口
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 统一下单数据信息
* 
* @param orderType integer($int32)
* @param example: 1 下单类型:1咨询，2合同，3.课程，11.充值，12.提现
* @param payType integer($int32)
* @param example: 1 支付类型:1.支付宝，2.微信，3.余额
* @param sourceId string 对应类型的id
* */
class PlaceOrderRequestModel extends BaseRequest {
  final String amount;
  final int orderType;
  final int payType;
  final String sourceId;

  PlaceOrderRequestModel({
    this.amount,
    this.orderType,
    this.payType,
    this.sourceId,
  });

  @override
  String url() => '/system/trade-record/place-order';

  @override
  Map<String, dynamic> toJson() {
    return {
      "amount": this.amount,
      "orderType": this.orderType,
      "payType": this.payType,
      "sourceId": this.sourceId,
    };
  }
}
