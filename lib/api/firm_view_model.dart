import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/firm_model.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';

FirmViewModel firmViewModel = new FirmViewModel();

class FirmViewModel extends BaseViewModel {
  Future<ResponseModel> firmList(
    BuildContext context,
  ) async {
    ResponseModel data = await FirmListRequestModel()
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new FirmListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
