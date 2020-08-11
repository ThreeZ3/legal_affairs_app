import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/all_mission_model.dart';
import 'package:jh_legal_affairs/api/task/mission_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';

MissionViewModel missionViewModel = new MissionViewModel();

class MissionViewModel extends BaseViewModel {
  /// 发布任务
  Future<ResponseModel> missionRelease(
    BuildContext context, {
    String ask,
    String categoryId,
    String content,
    int limit,
    String title,
    String require,
  }) async {
    if (!isPrice(ask)) {
      throw ResponseModel.fromParamError("不合法报价");
    } else if (!isPrice(ask)) {
      throw ResponseModel.fromParamError("不合法报价");
    } else if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError("请输入标题");
    } else if (!strNoEmpty(content) && content != '') {
      throw ResponseModel.fromParamError("请输入任务简介");
    } else if (!strNoEmpty(require) && require != '') {
      throw ResponseModel.fromParamError("请输入任务要求");
    } else if (!strNoEmpty(ask) && ask != '') {
      throw ResponseModel.fromParamError("请输入报价");
    } else if (categoryId == '0' || categoryId == '') {
      throw ResponseModel.fromParamError("请选择类别");
    } else if (limit < 1) {
      throw ResponseModel.fromParamError("时限必须大于等于1");
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (content.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    } else if (require.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '要求长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }

    ResponseModel data = await MissionReleaseDetailRequestModel(
      ask: ask,
      title: title,
      content: content,
      id: '',
      limit: limit,
      categoryId: categoryId,
      require: require,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
//      hud: '发布中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(
        payDetailDialog(
          context,
          type: payType.weChat,
          itemId: rep['data'],
          orderType: 4,
          price: '$ask',
        ).then((v) {
          if (v == null || !v) {
//          showToast(context, '请支付');
          } else {
            showToast(context, '发布成功');
            pop(true);
            Notice.send(JHActions.taskRefresh(), '');
          }
        }),
      );
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///修改任务
  Future<ResponseModel> missionChange(
    BuildContext context, {
    String ask,
    String categoryId,
    String content,
    String id,
    int limit,
    String title,
  }) async {
    ResponseModel data = await MissionReleaseDetailRequestModel(
      ask: ask,
      title: title,
      content: content,
      id: id,
      limit: limit,
      categoryId: categoryId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      if (!strNoEmpty(title)) {
        throw ResponseModel.fromParamError("请输入标题");
      } else if (!strNoEmpty(ask)) {
        throw ResponseModel.fromParamError("请输入价格");
      } else if (categoryId == '0' || categoryId == '') {
        throw ResponseModel.fromParamError("请选择类别Id");
      } else if (!strNoEmpty(content)) {
        throw ResponseModel.fromParamError("请输入内容");
      } else if (limit < 1) {
        throw ResponseModel.fromParamError("时限必须大于等于1");
      }
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///用户发布的任务列表
  Future<ResponseModel> missionUserList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await UserMissionRequestModel(
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

  ///用户承载的任务列表
  Future<ResponseModel> missionUnderTake(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await MissionUnderTakeRequestModel(
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

  ///分页获取所有任务
  Future<ResponseModel> missionPublishing(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await MissionPublishingRequestModel(
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new MissionRecords());

      if (!listNoEmpty(data) && page > 1) {
        showToast(context, '没有更多数据啦');
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 最新任务
  Future<ResponseModel> newMission(
    BuildContext context,
  ) async {
    ResponseModel data = await NewMissionRequestModel()
        .sendApiAction(
      context,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 多选删除我的任务 【多个】
  Future<ResponseModel> deletesMission(
    BuildContext context, {
    String ids,
  }) async {
    ResponseModel data = await DeletesMissionRequestModel(
      ids,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除任务 【单个】
  Future<ResponseModel> deleteMission(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await DeleteMissionRequestModel(
      id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 承接任务  文档有误，此地正确
  Future<ResponseModel> missionTake(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await MissionTakeRequestModel(
      id,
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
