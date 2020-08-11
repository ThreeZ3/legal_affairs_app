import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/bid/bid_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

BidViewModel bidViewModel = new BidViewModel();

class BidViewModel extends BaseViewModel {
  /// 竞价案源
  Future<ResponseModel> sourceCaseBidding(
    BuildContext context, {
    final String advantage,
    final String sourceId,
    final int limit,
    final int offer,
  }) async {
    if (limit == null || limit < 1) {
      throw ResponseModel.fromParamError('时限不能为空或小于1');
    } else if (offer == null || offer < 1) {
      throw ResponseModel.fromParamError('报价不能为空或小于1');
    }
    ResponseModel data = await SourceCaseBiddingRequestModel(
      advantage: advantage,
      sourceId: sourceId,
      limit: limit,
      offer: offer,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      if (rep["code"] == 403) {
        return showToast(context, "当前律师未通过审核");
      }
      showToast(context, '竞价成功，等待选用');
      pop();
      maybePop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 通过案源id获取竞价列表
  Future<ResponseModel> sourceCaseBiddingList(
    BuildContext context, {
    final String id,
    final int page,
    final int limit,
  }) async {
    ResponseModel data = await SourceCaseBiddingListRequestModel(
      id: id,
      page: page,
      limit: limit,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new SourceCaseBidModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 选用竞价-案源
  Future<ResponseModel> sourceCaseBidSelect(
    BuildContext context, {
    final String id,
  }) async {
    ResponseModel data = await SourceCaseBidSelectRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, "选用成功");
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 任务竞价
  ///
  /// 新增任务竞价
  Future<ResponseModel> missionsBid(
    BuildContext context, {
    final String advantage,
    final String missionsId,
    final int limit,
    final int offer,
  }) async {
    if (limit == null || limit < 1) {
      throw ResponseModel.fromParamError('时限不能为空或小于1');
    } else if (offer == null || offer < 1) {
      throw ResponseModel.fromParamError('报价不能为空或小于1');
    }
    ResponseModel data = await MissionsBiddingRequestModel(
      advantage: advantage,
      missionsId: missionsId,
      limit: limit,
      offer: offer,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, '竞价成功，等待选用');
      pop();
      maybePop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 通过案源id获取任务竞价列表
  Future<ResponseModel> missionsBidList(
    BuildContext context, {
    final String id,
    final int page,
    final int limit,
  }) async {
    ResponseModel data = await MissionsBidListRequestModel(
      id: id,
      page: page,
      limit: limit,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new SourceCaseBidModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 选用竞价-任务
  Future<ResponseModel> missionsBidSelect(
    BuildContext context, {
    final String id,
  }) async {
    ResponseModel data = await MissionsBidSelectRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.put,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
