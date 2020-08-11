import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

LawyerViewModel lawyerViewModel = new LawyerViewModel();

class LawyerViewModel extends BaseViewModel {
  /// 首页律师推荐列表
  Future<ResponseModel> lawyerList(
    BuildContext context,
  ) async {
    ResponseModel data = await LawyerListRequestModel()
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new LawyerListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 搜索获取律师列表
  Future<ResponseModel> lawyerSearch(
    BuildContext context, {
    final int page,
    final int limit,
    final String name,
    final String typeId,
    final int orderType,
    final String city,
    final String district,
    final String province,
    final int maxRank,
    final int maxRange,
  }) async {
    ResponseModel data = await LawyerSearchRequestModel(
      lat: '${location?.latitude ?? '0'}',
      lng: '${location?.longitude ?? '0'}',
      city: city,
      district: district,
      province: province,
      page: page,
      limit: limit,
      name: name,
      typeId: typeId,
      orderType: orderType,
      maxRank: maxRank,
      maxRange: maxRange,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], new LawyerListModel());
      if (page > 1 && !listNoEmpty(data)) {
        throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///律所注册-完善律师基本信息
  Future<ResponseModel> lawyerRegister(
    BuildContext context, {
    String city,
    String district,
    String email,
    String id,
    String name,
    String province,
  }) async {
    ResponseModel data = await LawyerRegisterRequestModel(
      city: city,
      district: district,
      email: email,
      id: id,
      name: name,
      province: province,
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

  /// 新增资质证明
  Future<ResponseModel> lawyerCertification(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String type,
    String value,
  }) async {
    ResponseModel data = await LawyerCertificationRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      type: type,
      value: value,
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

  /// 修改资质证明
  Future<ResponseModel> lawyerChangeCertification(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String type,
    String value,
  }) async {
    ResponseModel data = await LawyerCertificationRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      type: type,
      value: value,
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

  /// 删除资质证明
  Future<ResponseModel> lawyerDeleteCertification(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String type,
    String value,
  }) async {
    ResponseModel data = await LawyerCertificationRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      type: type,
      value: value,
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

  /// 修改律师详细资料->微信,电话,邮箱,微博,公众号
  Future<ResponseModel> lawyerChangeInfo(
    BuildContext context, {
    String content,
    String id,
    String type,
  }) async {
    ResponseModel data = await LawyerChangeInfoRequestModel(
      content: content,
      id: id,
      type: type,
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

  /// 删除律师社会荣誉
  Future<ResponseModel> lawyerDelHonor(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String value,
  }) async {
    ResponseModel data = await LawyerDelHonorRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      value: value,
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

  /// 律师详情下的详细资料
  Future<ResponseModel> lawyerDetailsInfo(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerDetailRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      ViewLawyerDetailModel model = ViewLawyerDetailModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律师简介
  Future<ResponseModel> lawyerChangeInfoDes(
    BuildContext context, {
    String id,
    String info,
  }) async {
    ResponseModel data = await LawyerChangeInfoDesRequestModel(
      id: id,
      info: info,
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

  /// 新增律师照片
  Future<ResponseModel> lawyerAddPhoto(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String type,
    String value,
  }) async {
    ResponseModel data = await LawyerAddPhotoRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      type: type,
      value: value,
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

  /// 修改律师照片
  Future<ResponseModel> lawyerChangePhoto(
    BuildContext context, {
    List<String> introductionValue,
    String lawId,
    String title,
    String type,
    String value,
  }) async {
    ResponseModel data = await LawyerAddPhotoRequestModel(
      introductionValue: introductionValue,
      lawId: lawId,
      title: title,
      type: type,
      value: value,
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

  /// 律师评分
  Future<ResponseModel> lawyerScore(
    BuildContext context, {
    String id,
    int score,
  }) async {
    ResponseModel data = await LawyerScoreRequestModel(
      id: id,
      score: score,
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

  /// 查询律师详情
  Future<ResponseModel> lawyerDetail(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerDetailsRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      LawyerDetailsInfoModel model =
          LawyerDetailsInfoModel.fromJson(rep['data']);

      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律师投诉
  Future<ResponseModel> lawyerComplaint(
    BuildContext context, {
    String lawId,
    String content,
    String img,
    int type,
  }) async {
    if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError("请输入投诉内容");
    }
    ResponseModel data = await LawyerComplaintRequestModel(
      lawId: lawId,
      content: content,
      img: img,
      type: type,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.lawFirmDetailsPageRefresh());
      Notice.send(JHActions.lawyerDetailPageRefresh());
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律师举报
  Future<ResponseModel> lawyerAccusation(
    BuildContext context, {
    String lawId,
    String content,
    String img,
    int type,
  }) async {
    if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError("请输入举报内容");
    }
    ResponseModel data = await LawyerAccusationRequestModel(
      lawId: lawId,
      content: content,
      img: img,
      type: type,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.lawFirmDetailsPageRefresh());
      Notice.send(JHActions.lawyerDetailPageRefresh());
      showToast(context, '举报成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 点击律师
  Future<ResponseModel> lawyerClick(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerClickRequestModel(
      id: id,
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

  /// firm/detail/{id}/{type} 通过律所id，属性详情类型获取律所详情
  Future<ResponseModel> firmDetail(
    BuildContext context, {
    String id,
    int type,
  }) async {
    ResponseModel data = await FirmDetailRequestModel(
      id: id,
      type: type,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], FirmDetailModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
