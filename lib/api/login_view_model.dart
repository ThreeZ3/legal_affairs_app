import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_model.dart';
import 'package:jh_legal_affairs/api/login_model.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/page/register/login_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

import '../common/check.dart';
import '../data/data.dart';
import '../widget_common/view/show_toast.dart';

LoginViewModel loginViewModel = new LoginViewModel();

class LoginViewModel extends BaseViewModel {
  Future<ResponseModel> sendCode(
    BuildContext context,
    String mobile,
  ) async {
    if (!strNoEmpty(mobile)) {
      throw ResponseModel.fromParamError('请输入手机号');
    } else if (!isMobilePhoneNumber(mobile)) {
      throw ResponseModel.fromParamError('请输入正确的手机号');
    }
    ResponseModel data = await VerifyCodeRequestModel(mobile)
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '发送中',
    )
        .then((rep) {
      showToast(context, '发送成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> checkCode(
    BuildContext context, {
    String verifyCode,
    String mobile,
  }) async {
    if (!strNoEmpty(verifyCode)) {
      throw ResponseModel.fromParamError('验证码不能为空');
    } else if (!isValidateCaptcha(verifyCode)) {
      throw ResponseModel.fromParamError('请输入正确的验证码');
    }
    ResponseModel data = await VerifyCodeCheckRequestModel(
      verifyCode: verifyCode,
      mobile: mobile,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, '验证成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> register(
    BuildContext context, {
    String mobile,
    String firstPassword,
    String secondPassword,
  }) async {
    if (!strNoEmpty(firstPassword) && !strNoEmpty(secondPassword)) {
      throw ResponseModel.fromParamError('密码不能为空');
    }
    ResponseModel data = await RegisterRequestModel(
      mobile: mobile,
      firstPassword: firstPassword,
      secondPassword: secondPassword,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
//      hud: '注册中',
    )
        .then((rep) {
      showToast(context, '注册成功请登录');
      popUntil(ModalRoute.withName(LoginPage().toStringShort()));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> login(
    BuildContext context, {
    String username,
    String password,
  }) async {
    if (!strNoEmpty(username) || !strNoEmpty(password)) {
      throw ResponseModel.fromParamError('参数不能为空');
    }
    if (JHData.isMockLogin()) {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxNzM5MDMyNjA2MCIsInNjb3BlIjpbImFsbCIsInJlYWQiLCJ3cml0ZSJdLCJwcm9qZWN0IjoibGVnYWwiLCJjb21wYW55Ijoid3p1YmkiLCJleHAiOjE1ODkzNTY5MzEsImF1dGhvcml0aWVzIjpbImU2YmI2N2Q3MTg4YjEzOTRmODhhM2E1NmVjZWYyNzBiIl0sImp0aSI6IjBlYTk3ZjE5LTc4MDEtNDk4Ni1hYjgxLWYzNzExMWYwYjY3MyIsImNsaWVudF9pZCI6ImxlZ2FsIn0.zcFHV_fay0yF-sNeC7eoBnmMCWVpRoBpAYkymaYBJHM';
      Store(JHActions.token()).value = "Bearer " + token;
      storeString(JHActions.token(), 'Bearer ' + token);

      ResponseModel responseModel = await getInfo(context);
      storeInfo(jsonEncode(responseModel.data));
      return null;
    }
    String basicAuthPath =
        'Basic ' + base64Encode(utf8.encode('legal:legal@WZ'));
    storeString(JHActions.token(), basicAuthPath);
    Store(JHActions.token()).value = basicAuthPath;

    ResponseModel data = await LoginRequestModel(
      username: username,
      password: password,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) async {
      String token = rep['data']['access_token'];
      String refreshToken = rep['data']['refresh_token'];
      Store(JHActions.token()).value = "Bearer " + token;
      storeString(JHActions.token(), 'Bearer ' + token);
      Store(JHActions.refreshToken()).value = "Bearer " + refreshToken;
      storeString(JHActions.refreshToken(), 'Bearer ' + refreshToken);

      ResponseModel responseModel = await getInfo(context);
      storeInfo(jsonEncode(responseModel.data));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  void storeInfo(String result) {
    storeString(JHActions.loginResult(), result);
    JHData.initStore();
    popToRootPage();
  }

  Future<ResponseModel> resetPw(
    BuildContext context, {
    String firstPassword,
    String secondPassword,
    String mobile,
  }) async {
    if (!strNoEmpty(firstPassword) ||
        !strNoEmpty(secondPassword) ||
        !strNoEmpty(mobile)) {
      throw ResponseModel.fromParamError('参数不能为空');
    }
    ResponseModel data = await PasswordRequestModel(
      firstPassword: firstPassword,
      secondPassword: secondPassword,
      mobile: mobile,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '修改中',
    )
        .then((rep) {
      showToast(context, '修改成功');
      popUntil(ModalRoute.withName(LoginPage().toStringShort()));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> getInfo(
    BuildContext context, {
    bool isUpdateStatus = false,
  }) async {
    ResponseModel data = await GetInfoRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      UserInfoModel model = UserInfoModel.fromJson(rep['data']);

      if (!strNoEmpty(model?.type)) {
        JHData.clean();
        throw ResponseModel.fromError('账号非法，请联系管理员。', 999);
//      } else if (model.type == '2') {
//        lawyerCurInfo(context);
      } else if (isUpdateStatus) {
        Store(JHActions.status()).value = model.status;
        Store(JHActions.isFirmUser()).value = model.isFirmUser;
        Store(JHActions.firmAdminType()).value = model.firmAdminType;
      }
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 更新用户信息
  Future<ResponseModel> updateInfo(
    BuildContext context, {
    final String avatar,
    final String city,
    final String province,
    final String district,
    final String sex,
    final String nickName,
  }) async {
    if (!strNoEmpty(nickName)) {
      throw ResponseModel.fromParamError('昵称不能为空');
    }
    ResponseModel data = await UpdateInfoRequestModel(
      avatar: avatar,
      city: city,
      province: province,
      district: district,
      sex: sex,
      nickName: nickName,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '修改信息成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取当前律师信息
  Future<ResponseModel> lawyerCurInfo(BuildContext context) async {
    ResponseModel data = await LawyerCurInfoRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      LawyerInfoModel lawyerInfoModel = LawyerInfoModel.fromJson(rep['data']);
      /*Store(JHActions.firmId()).value = lawyerInfoModel.firmId;*/
      return ResponseModel.fromSuccess(lawyerInfoModel);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> oauthToken(
    BuildContext context,
  ) async {
    String basicAuthPath =
        'Basic ' + base64Encode(utf8.encode('legal:legal@WZ'));
    storeString(JHActions.token(), basicAuthPath);
    String refreshToken = await getStoreValue(JHActions.refreshToken());
    Store(JHActions.token()).value = basicAuthPath;
    ResponseModel data = await OauthTokenRequestModel(
      refreshToken: refreshToken,
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

  /// 更新当前用户经纬度
  Future<ResponseModel> userPosition(
    BuildContext context, {
    String lat,
    String lng,
    String city,
    String district,
    String province,
  }) async {
    if (location == null) {
      return null;
    }
    print("JHData.isLogin()=${JHData.isLogin()}");
    ResponseModel data = await UserPositionRequestModel(
      lat: '${location?.latitude ?? 0}',
      lng: '${location?.longitude ?? 0}',
      city: '${strNoEmpty(location?.city) ? location?.city : '未知市'}',
      district:
          '${strNoEmpty(location?.district) ? strNoEmpty(location?.district) : '未知区'}',
      province:
          '${strNoEmpty(location?.province) ? location?.province : '未知省'}',
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
