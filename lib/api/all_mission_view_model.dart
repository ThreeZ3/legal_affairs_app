
import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/all_mission_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

AllMissionViewModel allMissionViewModel = new AllMissionViewModel();

/// 用户全部任务列表-ViewModel
class AllMissionViewModel extends BaseViewModel {
  Future<ResponseModel> getAllMission(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await AllMissionRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], new MissionRecords());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
