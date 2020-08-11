import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_new_mission_model.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/really_add.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///最新任务-ViewModel

class HomeNewMissionViewModel extends BaseViewModel {
  Future<ResponseModel> getNewMissionData(BuildContext context) async {
    ResponseModel data = await HomeNewMissionRequest()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], new HomeMissionModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> firmInvite(BuildContext context) async {
    ResponseModel data = await FirmInviteRequest()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new InviteFirmModel());
      if (listNoEmpty(data)) {
        routePush(
            new ReallyAddFirmPage(id: data[0].id, firmId: data[0].firmId));
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
