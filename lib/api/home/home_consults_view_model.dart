import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/home/home_consults_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///首页资讯viewmodel
class HomeInformationViewModel extends BaseViewModel {
  Future<ResponseModel> getInformationData(BuildContext context) async {
    ResponseModel informationData = await HomeInformationModel()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      List listData =
          dataModelListFromJson(rep['data'], HomeInformationRecords());
      return ResponseModel.fromSuccess(listData);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return informationData;
  }
}
