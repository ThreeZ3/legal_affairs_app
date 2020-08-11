import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

SketchViewModel sketchViewModel = new SketchViewModel();

class SketchViewModel extends BaseViewModel {
  /// 查询用户发表图文列表
  Future<ResponseModel> sketchList(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await SketchListRequestModel(
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List listData = dataModelListFromJson(rep['data']['records'], Records());
      return ResponseModel.fromSuccess(listData);
    });
    return data;
  }

  /// 律所获取图文咨询列表
  Future<ResponseModel> sketchFirm(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await SketchFirmRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List listData = dataModelListFromJson(rep['data'], Records());
      return ResponseModel.fromSuccess(listData);
    });
    return data;
  }

  /// 通过用户id查询用户发表图文列表
  Future<ResponseModel> sketchMyList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await SketchMyListRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List listData = dataModelListFromJson(rep['data']['records'], Records());
      return ResponseModel.fromSuccess(listData);
    });
    return data;
  }

  /// 发布图文
  Future<ResponseModel> sketchRelease(
    BuildContext context, {
    String category,
    String describe,
    String detail,
    String title,
    String footUrl,
    String headUrl,
    String pictures,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError('标题不能为空');
    } else if (!strNoEmpty(detail)) {
      throw ResponseModel.fromParamError('图文内容不能为空');
    } else if (!strNoEmpty(category)) {
      throw ResponseModel.fromParamError('请选择类别');
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (detail.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }
    ResponseModel data = await SketchReleaseRequestModel(
      category: category,
      describe: describe,
      detail: detail,
      id: '',
      footUrl: footUrl,
      headUrl: headUrl,
      title: title,
      pictures: pictures,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, "发布成功");
      Navigator.pop(context);
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改图文
  Future<ResponseModel> sketchChange(
    BuildContext context, {
    String category,
    String detail,
    String id,
    String title,
  }) async {
    ResponseModel data = await SketchReleaseRequestModel(
      category: category,
      detail: detail,
      id: id,
      title: title,
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

  /// 图文赞成
  Future<ResponseModel> sketchAgree(
    BuildContext context, {
    String sketchId,
    String userId,
  }) async {
    ResponseModel data = await SketchAgreeRequestModel(
      sketchId: sketchId,
      userId: userId,
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

  /// 图文反对
  Future<ResponseModel> sketchOpposition(
    BuildContext context, {
    String sketchId,
    String userId,
  }) async {
    ResponseModel data = await SketchOppositionRequestModel(
      sketchId: sketchId,
      userId: userId,
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

  /// 图文详情
  Future<ResponseModel> sketchDetail(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchDetailRequestModel(id)
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      SketchDetailsModel model = SketchDetailsModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    });
    return data;
  }

  /// 图文删除
  Future<ResponseModel> sketchDel(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchDetailRequestModel(id)
        .sendApiAction(
      context,
      reqType: ReqType.del,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 批量删除图文,id间用 ; 隔开
  Future<ResponseModel> sketchDeletes(
    BuildContext context, {
    String ids,
  }) async {
    ResponseModel data = await SketchDeletesRequestModel(
      ids,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// updateSketchcollect  图文收藏
  Future<ResponseModel> sketchCollection(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchCollectionRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// updateSketchnotcollect  图文取消收藏
  Future<ResponseModel> sketchNotCollection(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchNotCollectionRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// updateSketchread  更新图文读
  Future<ResponseModel> sketchRead(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchReadRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 图文咨询分享
  Future<ResponseModel> sketchShare(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchShareRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 图文点评操作  图文点评（支持反对）
  Future<ResponseModel> sketchComment(
    BuildContext context, {
    String sketchId,
    int status,
  }) async {
    ResponseModel data = await SketchCommentRequestModel(
      sketchId: sketchId,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///图文详情
  Future<ResponseModel> sketchDetailData(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SketchDetailRequestModel(id)
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      SketchDetailsModel model = SketchDetailsModel.fromJson(rep);
      return ResponseModel.fromSuccess(model);
    });
    return data;
  }
}
