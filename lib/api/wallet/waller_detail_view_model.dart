import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/wallet/waller_detail_model.dart';
import 'package:jh_legal_affairs/page/wallet/wallet_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 获取钱包可用金额view model
class WallerMoneyViewModel extends BaseViewModel {
  Future<ResponseModel> getWallerMoneyViewModel(BuildContext context) async {
    ResponseModel data = await WallerDetailMoneyModel()
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}

/// 获取收支明细view model
class WallerDetailViewModel extends BaseViewModel {
  Future<ResponseModel> getWallerDetailViewModel(BuildContext context,
      {String endTime, String startTime, String inEx}) async {
    ResponseModel data = await WallerDetailModel(
            endTime: endTime, startTime: startTime, inEx: inEx)
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new WallMoneyListModel());

      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}

///修改支付密码-view_model
class WallerPaymentCodeViewModel extends BaseViewModel {
  Future<ResponseModel> putWallerPaymentCode(BuildContext context,
      {String code,
      String mobile,
      String firstPassword,
      String secondPassword}) async {
    if (firstPassword != secondPassword) {
      throw ResponseModel.fromParamError('两次新支付密码不一致');
    } else if (firstPassword.length != 6) {
      throw ResponseModel.fromParamError('支付密码必须为6位数字密码');
    }
    ResponseModel data = await WallerPaymentCodeRequestModel(
      code: code,
      mobile: mobile,
      firstPassword: firstPassword,
      secondPassword: secondPassword,
    )
        .sendApiAction(
      context,
      hud: '修改中',
      reqType: ReqType.put,
    )
        .then((rep) {
      popUntil(ModalRoute.withName(WalletPage().toStringShort()));
      showToast(context, '密码已修改！');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
