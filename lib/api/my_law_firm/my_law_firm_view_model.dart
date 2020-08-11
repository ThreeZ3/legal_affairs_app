import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

MyLawFirmViewModel myLawFirmViewModel = new MyLawFirmViewModel();

class MyLawFirmViewModel extends BaseViewModel {
  ///查看我的律所
  Future<ResponseModel> viewMyFirm(
    BuildContext context,
  ) async {
    ResponseModel data = await ViewMyFirmRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      MyFirmModel model = MyFirmModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///查看我的律所信息详细
  Future<ResponseModel> viewMyFirmDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ViewMyFirmDetailsRequestModel(id: id)
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      ViewMyFirmDetailModel model = ViewMyFirmDetailModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///修改当前律所头像
  Future<ResponseModel> firmAvatars(
    BuildContext context, {
    String avatarUrl,
  }) async {
    ResponseModel data = await FirmAvatarsRequestModel(avatarUrl: avatarUrl)
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '修改头像成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///查看我的律所成员
  Future<ResponseModel> viewFirmNumber(
    BuildContext context,
  ) async {
    ResponseModel data = await ViewFirmNumberRequestModel()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      List list = dataModelListFromJson(rep['data'], FirmNumberModel());
      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///律所获取任务列表
  Future<ResponseModel> missionFirmList(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await MissionFirmListRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new MissionFirmModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///修改我的律师事务所类型
  Future<ResponseModel> changeFirmField(
    BuildContext context, {
    List legalFieldIds,
  }) async {
    ResponseModel data = await ChangeFirmFieldRequestModel(
      legalFieldIds: legalFieldIds,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      Notice.send(JHActions.viewMyFirmRefresh(), '');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// firm/apply-list 获取申请列表(get)
  Future<ResponseModel> firmApplyList(context) async {
    ResponseModel data = await FirmApplyListModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], FirmApplyListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 审核律所申请
  Future<ResponseModel> firmExamine(
    context, {
    String id,
    int status,
  }) async {
    ResponseModel data = await FirmExamineRequestModel(
      id: id,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.viewMyFirmRefresh(), '');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
