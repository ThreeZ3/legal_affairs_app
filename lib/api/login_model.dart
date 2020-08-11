import 'package:jh_legal_affairs/http/base_request.dart';

class VerifyCodeRequestModel extends BaseRequest {
  final String mobile;

  VerifyCodeRequestModel(this.mobile);

  @override
  String url() => '/verify-code';

  @override
  Map<String, dynamic> toJson() {
    return {
      'mobile': this.mobile,
    };
  }
}

class VerifyCodeCheckRequestModel extends BaseRequest {
  final String verifyCode;
  final String mobile;

  VerifyCodeCheckRequestModel({
    this.verifyCode,
    this.mobile,
  });

  @override
  String url() => '/verify-code/check-code?code=$verifyCode&mobile=$mobile';

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': this.verifyCode,
      'mobile': this.mobile,
    };
  }
}

class LoginRequestModel extends BaseRequest {
  final String username;
  final String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  @override
  String url() => '/login';

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }
}

class PasswordRequestModel extends BaseRequest {
  final String firstPassword;
  final String secondPassword;
  final String mobile;

  PasswordRequestModel({
    this.firstPassword,
    this.secondPassword,
    this.mobile,
  });

  @override
  String url() => '/user/password';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firstPassword": this.firstPassword,
      "mobile": this.mobile,
      "secondPassword": this.secondPassword,
    };
  }
}

class RegisterRequestModel extends BaseRequest {
  final String firstPassword;
  final String secondPassword;
  final String mobile;

  RegisterRequestModel({
    this.firstPassword,
    this.secondPassword,
    this.mobile,
  });

  @override
  String url() => '/user/register';

  @override
  Map<String, dynamic> toJson() {
    return {
      'mobile': this.mobile,
      'firstPassword': this.firstPassword,
      'secondPassword': this.secondPassword,
    };
  }
}

/// 获取用户信息
class GetInfoRequestModel extends BaseRequest {
  @override
  String url() => '/user/info';
}

/// 更新用户信息
/// sex : 0=男 1=女
class UpdateInfoRequestModel extends BaseRequest {
  final String avatar;
  final String city;
  final String province;
  final String district;
  final String sex;
  final String nickName;

  UpdateInfoRequestModel({
    this.avatar,
    this.city,
    this.province,
    this.district,
    this.sex,
    this.nickName,
  });

  @override
  String url() => '/user/info';

  @override
  Map<String, dynamic> toJson() {
    return {
      "avatar": this.avatar,
      "nickName": this.nickName,
      "city": this.city,
      "district": this.district,
      "province": this.province,
      "sex": this.sex,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* User对象
*
* @param avatar string 头像
* @param email string 电子邮箱
* @param id string
* @param identityCard string 身份证
* @param inviteCode string 邀请码
* @param loginPassword string 密码
* @param mobile string 手机号
* @param nickName string 昵称
* @param payPassword string 支付密码
* @param realName string 真实姓名
* @param sex string 性别 0 男 1 女
* */
class UserInfoModel {
  final String avatar;
  final String email;
  final String id;
  final String identityCard;
  final String inviteCode;
  final String loginPassword;
  final String mobile;
  final String nickName;
  final String payPassword;
  final String realName;
  final String city;
  final String province;
  final String district;
  final String sex;
  final String type;
  final bool isFirmUser;

  //是否为管理员 0.是  1.否
  final int firmAdminType;

  //律师 -1.审核失败  0.待审核 1.正常  2.状态异常
  final int status;

  UserInfoModel({
    this.status,
    this.city,
    this.district,
    this.province,
    this.avatar,
    this.email,
    this.id,
    this.identityCard,
    this.inviteCode,
    this.loginPassword,
    this.mobile,
    this.nickName,
    this.payPassword,
    this.realName,
    this.sex,
    this.type,
    this.isFirmUser,
    this.firmAdminType,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  UserInfoModel from(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['id'] = this.id;
    data['city'] = this.city;
    data['district'] = this.district;
    data['province'] = this.province;
    data['identityCard'] = this.identityCard;
    data['inviteCode'] = this.inviteCode;
    data['loginPassword'] = this.loginPassword;
    data['mobile'] = this.mobile;
    data['nickName'] = this.nickName;
    data['payPassword'] = this.payPassword;
    data['realName'] = this.realName;
    data['sex'] = this.sex;
    data['type'] = this.type;
    data['isFirmUser'] = this.isFirmUser;
    data['firmAdminType'] = this.firmAdminType;
    return data;
  }
}

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    avatar: json['avatar'],
    city: json['city'],
    status: json['status'],
    district: json['district'],
    province: json['province'],
    email: json['email'],
    id: json['id'],
    identityCard: json['identityCard'],
    inviteCode: json['inviteCode'],
    loginPassword: json['loginPassword'],
    mobile: json['mobile'],
    nickName: json['nickName'],
    payPassword: json['payPassword'],
    realName: json['realName'],
    sex: json['sex'],
    type: json['type'],
    isFirmUser: json['isFirmUser'],
    firmAdminType: json['firmAdminType'],
  );
}

class OauthTokenRequestModel extends BaseRequest {
  final String refreshToken;

  OauthTokenRequestModel({
    this.refreshToken,
  });

  @override
  String url() => '/oauth/token';

  @override
  Map<String, dynamic> toJson() {
    return {
      "grant_type": "refresh_token",
      "refresh_token": this.refreshToken,
    };
  }
}

/// 更新当前用户经纬度
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 设置当前用户所在经纬度
*
* @param lat string 纬度
* @param lng string 经度
* */
class UserPositionRequestModel extends BaseRequest {
  final String lat;
  final String lng;
  final String city;
  final String district;
  final String province;

  UserPositionRequestModel({
    this.lat,
    this.lng,
    this.city,
    this.province,
    this.district,
  });

  @override
  String url() => '/user/position';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "lng": this.lng,
      "city": this.city,
      "province": this.province,
      "district": this.district,
    };
  }
}
