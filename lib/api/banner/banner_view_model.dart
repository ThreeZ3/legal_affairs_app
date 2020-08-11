import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/banner/banner_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

BannerViewModel contractViewModel = new BannerViewModel();

class BannerViewModel extends BaseViewModel {
  /// 添加banner图
  Future<ResponseModel> bannerAdd(
    BuildContext context, {
    String createTime,
    int deleted,
    String id,
    int isShow,
    String title,
    int type,
    String updateTime,
    String bannerUrl,
  }) async {
    ResponseModel data = await BannerAddRequestModel(
      createTime: createTime,
      deleted: deleted,
      id: id,
      isShow: isShow,
      title: title,
      type: type,
      updateTime: updateTime,
      bannerUrl: bannerUrl,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 首页、律所、律师、业务 banner图列表
  Future<ResponseModel> bannerList(
    BuildContext context, {
    String createTime,
    int deleted,
    String id,
    int isShow,
    String title,
    int type,
    String updateTime,
    String bannerUrl,
  }) async {
    ResponseModel data = await BannerListRequestModel(
      createTime: createTime,
      deleted: deleted,
      id: id,
      isShow: isShow,
      title: title,
      type: type,
      updateTime: updateTime,
      bannerUrl: bannerUrl,
    )
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

  /// 修改banner图状态
  Future<ResponseModel> bannerChange(
    BuildContext context, {
    String id,
    int isShow,
    String title,
    int type,
    String bannerUrl,
  }) async {
    ResponseModel data = await BannerChangeRequestModel(
      id: id,
      isShow: isShow,
      title: title,
      type: type,
      bannerUrl: bannerUrl,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改banner图状态
  Future<ResponseModel> bannerDel(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await BannerDelRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
      hud: '删除中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
