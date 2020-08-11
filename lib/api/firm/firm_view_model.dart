import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

FirmViewModel firmViewModel = new FirmViewModel();

class FirmViewModel extends BaseViewModel {
  /// 插入律所地址
  Future<ResponseModel> firmInsertAddress(
    BuildContext context, {
    String address,
    String city,
    String district,
    String id,
    String lat,
    String lng,
    String province,
    String town,
  }) async {
    ResponseModel data = await FirmInsertAddressRequestModel(
      address: address,
      city: city,
      district: district,
      id: id,
      lat: lat,
      lng: lng,
      province: province,
      town: town,
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

  /// 新增律所地址
  Future<ResponseModel> firmChangeAddress(
    BuildContext context, {
    String address,
    String city,
    String district,
    String id,
    String lat,
    String lng,
    String province,
    String town,
  }) async {
    ResponseModel data = await FirmInsertAddressRequestModel(
      address: address,
      city: city,
      district: district,
      id: id,
      lat: lat,
      lng: lng,
      province: province,
      town: town,
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

  /// 新增律所管理员
  Future<ResponseModel> addAdmin(
    BuildContext context, {
    String firmId,
    int type,
    String userId,
  }) async {
    ResponseModel data = await AddAdminRequestModel(
      firmId: firmId,
      type: type,
      userId: userId,
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

  ///修改律所成员权限
  Future<ResponseModel> putFirmAdmin(
    BuildContext context, {
    int type,
    String userId,
  }) async {
    ResponseModel data =
        await PutFirmAdminRequestModel(type: type, userId: userId)
            .sendApiAction(
      context,
      reqType: ReqType.put,
    )
            .then((rep) {
      Notice.send(JHActions.memberPermissions());
      showToast(context, "修改成功");
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///获取所有律所名称
  Future<ResponseModel> firmAllName(
    BuildContext context,
  ) async {
    ResponseModel data = await FirmAllNameRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep['data']);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取所有律所简略信息
  Future<ResponseModel> firmAllShortInfo(
    BuildContext context, {
    String firmName,
    String id,
  }) async {
    ResponseModel data =
        await FirmAllShortInfoRequestModel(firmName: firmName, id: id)
            .sendApiAction(
      context,
      reqType: ReqType.get,
    )
            .then((rep) {
      return ResponseModel.fromSuccess(rep['data']);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// deleteAdmin 删除管理员
  Future<ResponseModel> deleteAdmin(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await DeleteAdminRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律所电话、微信、邮箱、微博、公众号
  Future<ResponseModel> changeContacts(
    BuildContext context, {
    String id,
    String value,
  }) async {
    ResponseModel data = await ChangeContactsRequestModel(
      id: id,
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

  /// 新增律所荣誉
  Future<ResponseModel> addHonor(
    BuildContext context, {
    String title,
    String value,
  }) async {
    ResponseModel data = await AddHonorRequestModel(
      title: title,
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

  /// 根据id修改荣誉
  Future<ResponseModel> changeHonor(
    BuildContext context, {
    String title,
    String value,
    String id,
  }) async {
    ResponseModel data = await ChangeHonorRequestModel(
      title: title,
      value: value,
      id: id,
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

  /// 根据id删除荣誉
  Future<ResponseModel> deleteHonor(
    BuildContext context, {
    String title,
    String value,
    String id,
  }) async {
    ResponseModel data = await ChangeHonorRequestModel(
      title: title,
      value: value,
      id: id,
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

  /// 修改律所简介
  Future<ResponseModel> changeInfo(
    BuildContext context, {
    String content,
  }) async {
    ResponseModel data = await ChangeInfoRequestModel(
      content: content,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      showToast(context, '修改成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 邀请加入律所
  Future<ResponseModel> firmInvited(
    BuildContext context, {
    String userId,
  }) async {
    ResponseModel data = await FirmInvitedRequestModel(
      userId: userId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, '邀请成功，等待同意');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律所列表
  Future<ResponseModel> firmList(
    BuildContext context,
  ) async {
    ResponseModel data = await FirmListRequestModel()
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

  /// 新增律所照片
  Future<ResponseModel> addPhoto(
    BuildContext context, {
    String value,
  }) async {
    ResponseModel data = await AddPhotoRequestModel(
      value: value,
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

  /// 根据id修改荣誉[照片]
  Future<ResponseModel> changePhoto(
    BuildContext context, {
    String value,
    String id,
  }) async {
    ResponseModel data = await ChangePhotoRequestModel(
      value: value,
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

  /// 根据id删除荣誉[照片]
  Future<ResponseModel> deletePhoto(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ChangePhotoRequestModel(
      value: null,
      id: id,
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

  /// 新增律所资质证明
  Future<ResponseModel> qualification(
    BuildContext context, {
    String firmType,
    String firmValue,
    String lawId,
  }) async {
    ResponseModel data = await QualificationRequestModel(
      firmType: firmType,
      firmValue: firmValue,
      lawId: lawId,
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

  /// 修改律所资质证明
  Future<ResponseModel> changeQualification(
    BuildContext context, {
    String firmType,
    String firmValue,
    String lawId,
  }) async {
    ResponseModel data = await QualificationRequestModel(
      firmType: firmType,
      firmValue: firmValue,
      lawId: lawId,
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

  /// 删除律所资质证明
  Future<ResponseModel> deleteQualification(
    BuildContext context, {
    String firmType,
    String firmValue,
    String lawId,
  }) async {
    ResponseModel data = await QualificationRequestModel(
      firmType: firmType,
      firmValue: firmValue,
      lawId: lawId,
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

  /// 修改律所理念
  Future<ResponseModel> changeFirmValue(
    BuildContext context, {
    String content,
  }) async {
    ResponseModel data = await ChangeFirmValueRequestModel(
      content: content,
    )
        .sendApiAction(
      context,
      hud: '修改中',
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '修改成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 查看律所详情  查看律所所有信息详情
  Future<ResponseModel> viewFirmDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ViewFirmDetailsRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      ViewMyFirmDetailModel model = ViewMyFirmDetailModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 查看律所信息
  Future<ResponseModel> viewFirmInfo(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ViewFirmInfoRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      FirmDetailsInfoModel model = FirmDetailsInfoModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取律所成员
  Future<ResponseModel> viewFirmMembers(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ViewFirmMembersRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new FirmMemberModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///修改律师事务所名称
  Future<ResponseModel> changFirmName(
    BuildContext context, {
    String firmName,
  }) async {
    ResponseModel data = await ChangeFirmNameRequestModel(
      firmName: firmName,
    ).sendApiAction(context, reqType: ReqType.put).then((rep) {
      showToast(context, '修改成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///创建律所
  Future<ResponseModel> createFirm(
    BuildContext context, {
    String address,
    String city,
    String district,
    String firmAvatar,
    String firmInfo,
    String firmName,
    String firmValue,
    String lat,
    List<Field> legalField,
    String lng,
    String province,
    String town,
    List<Setting> setting,
  }) async {
    ResponseModel data = await CreateFirmRequestModel(
      address: address,
      city: city,
      district: district,
      firmAvatar: firmAvatar,
      firmInfo: firmInfo,
      firmName: firmName,
      firmValue: firmValue,
      lat: lat,
      lng: lng,
      legalField: legalField,
      province: province,
      town: town,
      firmSettingDTOS: setting,
    ).sendApiAction(context, reqType: ReqType.post).then((rep) {
      if (rep["code"] == 200) {
        showToast(context, '创建成功');
        return ResponseModel.fromSuccess(rep);
      } else {
        return showToast(context, rep['data']);
      }
    }).catchError((e) {
      print('e====>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///查看律所信息
  Future<ResponseModel> getFirmMessage(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ViewFirmInfoRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      FirmDetailsInfoModel model = FirmDetailsInfoModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///申请加入律所
  Future<ResponseModel> applyFirm(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ApplyFirmRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      if (rep['code'] == 200) {
        showToast(context, '已发送申请');
      }
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///接受或拒绝律所邀请
  Future<ResponseModel> firmInviteHandle(
    BuildContext context, {
    String id,
    int mode,
  }) async {
    ResponseModel data = await FirmInviteHandleRequestModel(
      id: id,
      mode: mode,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      if (mode == 1) {
        pop();
        showToast(context, '已同意');
      } else {
        pop();
        showToast(context, '已拒绝');
      }
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律所各项属性信息
  Future<ResponseModel> changeFirmSetting(
    BuildContext context, {
    String id,
    String title,
    String value,
  }) async {
    ResponseModel data = await ChangeFirmSettingRequestModel(
      id: id,
      title: title,
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

  /// 新增律所各项属性信息
  Future<ResponseModel> addFirmSetting(
    BuildContext context, {
    String lawId,
    String title,
    int type,
    String value,
  }) async {
    ResponseModel data = await AddFirmSettingRequestModel(
      lawId: lawId,
      title: title,
      type: type,
      value: value,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除律所各项属性信息
  Future<ResponseModel> delFirmSetting(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await DelFirmSettingRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 点击律所
  Future<ResponseModel> firmClick(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await FirmClickRequestModel(
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
}
