import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

AdViewModel adViewModel = new AdViewModel();

class AdViewModel extends BaseViewModel {
  /// ad/incomes/{id}/{page}/{limit} 根据用户ID查询广告收入列表 (Get)
  Future<ResponseModel> adIncomes(
    BuildContext context, {
    String id,
    int page,
    int limit,
  }) async {
    ResponseModel data = await AdIncomesRequestModel(
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
      List data =
          dataModelListFromJson(rep['data']['records'], AdIncomesModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// ad/sys-ad-bid/bidding 广告位竞价 (Post)
  Future<ResponseModel> adSysBidding(
    BuildContext context, {
    String bidPrice,
    String contentUrl,
    int day,
    String id,
    String sysAdId,
  }) async {
    if (!strNoEmpty(contentUrl)) {
      throw ResponseModel.fromParamError('请上传广告内容');
    } else if (!isMoney(bidPrice)) {
      throw ResponseModel.fromParamError('请输入推送费用');
    } else if (day == null) {
      throw ResponseModel.fromParamError('请输入推送时间');
    } else if (!strNoEmpty(sysAdId)) {
      throw ResponseModel.fromParamError('请选择推送位置');
    }
    ResponseModel data = await AdSysBiddingRequestModel(
      bidPrice: bidPrice,
      contentUrl: contentUrl,
      day: day,
      id: id,
      sysAdId: sysAdId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, '操作成功');
      Notice.send(JHActions.myAdListRefresh());
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除案例
  Future<ResponseModel> deleteAd(
    BuildContext context, {
    String ids,
  }) async {
    ResponseModel data = await DeleteAdRequestModel(
      ids,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      Notice.send(JHActions.sourceCaseRefresh());
      showToast(context, '删除成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// ad/sys-ad-bid/click/{id} 浏览广告 (Put)

  Future<ResponseModel> adSysClick(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await AdSysClickRequestModel(id)
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

  /// ad/sys-ad-bid/{id}/{page}/{limit} 获取我的广告 (Get)
  Future<ResponseModel> adSysBid(
    BuildContext context, {
    String id,
    int page,
    int limit,
  }) async {
    ResponseModel data = await AdSysBidRequestModel(id, page, limit)
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], AdSysBidModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// ad/sys-ad/all 获取所有推送位置信息 (Get)
  Future<ResponseModel> adSysAll(
    BuildContext context,
  ) async {
    ResponseModel data = await AdSysAllRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], AdSysAllModel());
      return ResponseModel.fromSuccess(data);
      /*}).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);*/
    });
    return data;
  }

  /// ad/sys-ad/{type} 根据推送位置获取广告列表 （Get）
  Future<ResponseModel> adSys(
    BuildContext context, {
    int type,
  }) async {
    if (type == null) {
      showToast(context, '请选择推送位置');
      return Future.value();
    }
    ResponseModel data = await AdSysRequestModel(type)
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], AdSysModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// ad/{id}查询广告详情信息 (Get)
  Future<ResponseModel> adDetail(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await AdDetailRequestModel(id)
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      AdDetailsModel data = AdDetailsModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
