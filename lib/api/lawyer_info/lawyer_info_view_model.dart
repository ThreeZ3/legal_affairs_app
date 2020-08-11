import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_new_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

LawyerInFoViewModel lawyerInFoViewModel = new LawyerInFoViewModel();

class LawyerInFoViewModel extends BaseViewModel {
  /// 律师注册-完善律师基本信息
  Future<ResponseModel> basicInfo(
    BuildContext context, {
    String city,
    String district,
    String email,
    String name,
    String province,
  }) async {
    ResponseModel data = await BasicInfoRequestModel(
      city: city,
      district: district,
      email: email,
      name: name,
      province: province,
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

  /// 新增资质证明数据
  Future<ResponseModel> certification(
    BuildContext context, {
    String id,
    String title,
    String value,
  }) async {
    ResponseModel data = await CertificationRequestModel(
      id: id,
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

  /// 修改资质证明
  Future<ResponseModel> certificationChange(
    BuildContext context, {
    String id,
    String title,
    String value,
  }) async {
    ResponseModel data = await CertificationRequestModel(
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

  ///删除资质证明
  Future<ResponseModel> certificationDelete(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await CertificationDeleteRequestModel(
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

  /// 添加律师详细资料->微信,电话,邮箱,微博,公众号
  Future<ResponseModel> lawyerContacts(
    BuildContext context, {
    String id,
    String title,
    String value,
    int type,
  }) async {
    ResponseModel data = await LawyerContactsRequestModel(
      id: id,
      title: title,
      value: value,
      type: type,
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

  /// 修改律师详细资料->微信,电话,邮箱,微博,公众号
  Future<ResponseModel> lawyerContactsChange(
    BuildContext context, {
    String id,
    String title,
    String value,
    int type,
  }) async {
    ResponseModel data = await LawyerContactsRequestModel(
      id: id,
      title: title,
      value: value,
      type: type,
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

  /// 删除律师详细资料->微信,电话,邮箱,微博,公众号
  Future<ResponseModel> lawyerContactsDelete(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerContactsDeleteRequestModel(
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

  /// 获取当前律师信息
  Future<ResponseModel> lawyerCurInfo(
    BuildContext context, {
    String firmId,
  }) async {
    ResponseModel data = await LawyerCurInfoRequestModel(
      firmId: firmId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 新增律师社会荣誉
  Future<ResponseModel> addLawyerHonor(
    BuildContext context, {
    String id,
    String title,
    String value,
  }) async {
    ResponseModel data = await AddLawyerHonorRequestModel(
      id: id,
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

  /// 修改律师社会荣誉
  Future<ResponseModel> updateLawyerHonor(
    BuildContext context, {
    String id,
    String title,
    String value,
  }) async {
    ResponseModel data = await AddLawyerHonorRequestModel(
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

  /// 删除律师社会荣誉
  Future<ResponseModel> lawyerHonorDelete(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerHonorDeleteRequestModel(
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

  /// 修改律师简介
  Future<ResponseModel> changeLawyerInfo(
    BuildContext context, {
    String id,
    String info,
  }) async {
    if (!strNoEmpty(info)) {
      throw ResponseModel.fromParamError('请输入理念信息');
    }
    ResponseModel data = await ChangeLawyerInfoRequestModel(
      id: id,
      info: info,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.minePageRefresh());
      pop();
      showToast(context, '修改成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 新增律师照片
  Future<ResponseModel> addLawyerPhoto(
    BuildContext context, {
    String id,
    String lawId,
    String title,
    String value,
  }) async {
    if (!strNoEmpty(value)) {
      throw ResponseModel.fromParamError('图片不能为空');
    }
    if (!strNoEmpty(lawId)) {
      throw ResponseModel.fromParamError('律师ID不能为空');
    }
    ResponseModel data = await AddLawyerPhotoRequestModel(
      id: id,
      lawId: lawId,
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

  /// 修改律师照片
  Future<ResponseModel> updateLawyerPhoto(
    BuildContext context, {
    String id,
    String lawId,
    String title,
    String value,
  }) async {
    ResponseModel data = await AddLawyerPhotoRequestModel(
      id: id,
      lawId: lawId,
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

  /// 律所注册-插入律师执业信息
  Future<ResponseModel> lawyerPracticeInfo(
    BuildContext context, {
    String firmName,
    String idCardBackImg,
    String idCardImg,
    String lawyerCard,
    String lawyerCardBackImg,
    String lawyerCardImg,
    List<String> legalField,
  }) async {
    ResponseModel data = await LawyerPracticeInfoRequestModel(
      firmName: firmName,
      idCardBackImg: idCardBackImg,
      idCardImg: idCardImg,
      lawyerCard: lawyerCard,
      lawyerCardBackImg: lawyerCardBackImg,
      lawyerCardImg: lawyerCardImg,
      legalField: legalField,
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

  /// 律师注册-设置密码
  Future<ResponseModel> lawyerSetPassword(
    BuildContext context, {
    String firstPassword,
    String id,
    String mobile,
    String secondPassword,
  }) async {
    ResponseModel data = await LawyerSetPasswordRequestModel(
      firstPassword: firstPassword,
      id: id,
      mobile: mobile,
      secondPassword: secondPassword,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      showToast(context, '注册完毕，等待审核');
      popUntil(ModalRoute.withName(LoginPage().toStringShort()));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律师理念
  Future<ResponseModel> lawyerChangeValue(
    BuildContext context, {
    String id,
    String value,
  }) async {
    if (!strNoEmpty(value)) {
      throw ResponseModel.fromParamError('请输入理念信息');
    }
    ResponseModel data = await LawyerChangeValueRequestModel(
      id: id,
      value: value,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      Notice.send(JHActions.minePageRefresh());
      pop();
      showToast(context, '修改成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 查询律师信息
  Future<ResponseModel> lawyerViewInfo(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LawyerViewInfoRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      /*List data =
          dataModelListFromJson(rep['data'],  LawyerViewInfoModel());*/
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律师类型
  Future<ResponseModel> lawyerLegalField(
    BuildContext context, {
    List<Fields> ids,
  }) async {
    ResponseModel data = await LawyerLegalFieldRequestModel(
      ids: ids,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      Notice.send(JHActions.minePageRefresh());
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 搜索律师
  Future<ResponseModel> lawyerSearch(
    BuildContext context, {
    final String identityCard,
    final String lawyerCard,
    final String realName,
  }) async {
    ResponseModel data = await SearchRequestModel(
      identityCard: identityCard,
      lawyerCard: lawyerCard,
      realName: realName,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '搜索中',
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data'], new LawyerDetailsInfoModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
