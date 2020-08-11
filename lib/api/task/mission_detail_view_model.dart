import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/task/mission_detail_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

MissionDetailViewModel missionDetailViewModel = new MissionDetailViewModel();

/// 任务详情-ViewModel
class MissionDetailViewModel extends BaseViewModel {
  Future<ResponseModel> missionDetail(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await MissionDetailRequestModel(id)
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      MissionDetailModel data = MissionDetailModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 发布者确认完成
  Future<ResponseModel> missionPublishConfirm(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await MissionPublishConfirmModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '确认成功');
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 承接者确认完成
  Future<ResponseModel> missionCompleted(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await MissionCompletedModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '确认成功');
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
