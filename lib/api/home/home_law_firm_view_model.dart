import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/home/home_law_firm_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';


class HomeLawFirmViewModel extends BaseViewModel {
  Future<ResponseModel> getLawFirmData(BuildContext context) async {
    ResponseModel data = await HomeLawyerFirmRequestModel()
        .sendApiAction(context, reqType: ReqType.get, )
        .then((rep) {
      HomeFirmsModel homeLawyerModel = HomeFirmsModel.fromJson(rep);
//      listData = dataModelListFromJson(rep['data'], HomeLawFirmRequestModel());
      return ResponseModel.fromSuccess(homeLawyerModel);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
