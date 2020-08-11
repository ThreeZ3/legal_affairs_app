import 'package:jh_legal_affairs/util/tools.dart';

///修改律师事务所名称
class ChangeFirmNameRequestModel extends BaseRequest {
  final String firmName;

  ChangeFirmNameRequestModel({this.firmName});

  @override
  String url() => '/firm/firmName';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firmName": this.firmName,
    };
  }
}

///修改律师事务所类型
class ChangeFirmFieldRequestModel extends BaseRequest {
  final List legalFieldIds;

  ChangeFirmFieldRequestModel({this.legalFieldIds});

  @override
  String url() => '/firm/legalField';

  @override
  Map<String, dynamic> toJson() {
    return {
      "legalFieldIds": this.legalFieldIds,
    };
  }
}

///查看我的律所信息
class ViewMyFirmRequestModel extends BaseRequest {
  @override
  String url() => '/firm/cur';
}

///查看我的律所信息详情
class ViewMyFirmDetailsRequestModel extends BaseRequest {
  final String id;

  ViewMyFirmDetailsRequestModel({this.id});

  @override
  String url() => '/firm/all-detail/$id';
}

///修改当前律所头像
class FirmAvatarsRequestModel extends BaseRequest {
  final String avatarUrl;

  FirmAvatarsRequestModel({this.avatarUrl});

  @override
  String url() => '/firm/update/avatar';

  @override
  Map<String, dynamic> toJson() {
    return {
      'url': this.avatarUrl,
    };
  }
}

///查看律所成员
class ViewFirmNumberRequestModel extends BaseRequest {
  @override
  String url() => '/firm/members';
}

///律所获取任务列表
class MissionFirmListRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  MissionFirmListRequestModel({this.id, this.limit, this.page});

  @override
  String url() => '/mission/firm/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class MissionFirmModel {
  final String ask;
  final String category;
  final String categoryId;
  final String content;
  final String issuerNickName;
  final String issuerAvatar;
  final dynamic expirationTime;
  final String id;
  final int limit;
  final int createTime;
  final bool own;
  final dynamic require;
  final String status;
  final String title;
  bool isDel;

  MissionFirmModel({
    this.ask,
    this.issuerNickName,
    this.issuerAvatar,
    this.category,
    this.categoryId,
    this.content,
    this.expirationTime,
    this.id,
    this.limit,
    this.own,
    this.require,
    this.status,
    this.title,
    this.createTime,
    this.isDel = false,
  });

  factory MissionFirmModel.fromJson(Map<String, dynamic> json) =>
      _$MissionFirmModelFromJson(json);

  MissionFirmModel from(Map<String, dynamic> json) =>
      _$MissionFirmModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['issuerAvatar'] = this.issuerAvatar;
    data['expirationTime'] = this.expirationTime;
    data['id'] = this.id;
    data['limit'] = this.limit;
    data['own'] = this.own;
    data['require'] = this.require;
    data['status'] = this.status;
    data['issuerNickName'] = this.issuerNickName;
    data['title'] = this.title;
    data['createTime'] = this.createTime;
    return data;
  }
}

MissionFirmModel _$MissionFirmModelFromJson(Map<String, dynamic> json) {
  return MissionFirmModel(
    ask: json['ask'],
    category: json['category'],
    categoryId: json['categoryId'],
    issuerAvatar: json['issuerAvatar'],
    issuerNickName: json['issuerNickName'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    id: json['id'],
    createTime: json['createTime'],
    limit: json['limit'],
    own: json['own'],
    require: json['require'],
    status: json['status'],
    title: json['title'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* accusationCount string 举报总数
* @param address string 详细地址
* @param city string 事务所所属城市
* @param complaintCount string 投诉总数
* @param district string 事务所所属区
* @param firmAvatar string 事务所图标
* @param firmInfo string 律师所简介
* @param firmName string 事务所名称
* @param firmValue string 律师所理念
* @param id string
* @param legalField [ 业务范围
* @param LegalFieldRankVO
*
* @param description:  律所律师业务及排名
* @param legalId string 名称
* @param name string 名称
* @param rank string 排名]
* @param province string 事务所所属省份
* @param rank integer($int32) 排名：可为空，运营字段
* @param score integer($int32) 总评分
* @param town string 事务所所属镇
* */
class MyFirmModel {
  final String accusationCount;
  final String address;
  final String city;
  final String complaintCount;
  final String district;
  String firmAvatar;
  final String firmInfo;
  final String firmName;
  final String firmValue;
  final String id;
  final List<LegalField> legalField;
  final String province;
  final int rank;
  final int score;
  final String town;

  MyFirmModel({
    this.accusationCount,
    this.address,
    this.city,
    this.complaintCount,
    this.district,
    this.firmAvatar,
    this.firmInfo,
    this.firmName,
    this.firmValue,
    this.id,
    this.legalField,
    this.province,
    this.rank,
    this.score,
    this.town,
  });

  factory MyFirmModel.fromJson(Map<String, dynamic> json) =>
      _$MyFirmModelFromJson(json);

  MyFirmModel from(Map<String, dynamic> json) => _$MyFirmModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accusationCount'] = this.accusationCount;
    data['address'] = this.address;
    data['city'] = this.city;
    data['complaintCount'] = this.complaintCount;
    data['district'] = this.district;
    data['firmAvatar'] = this.firmAvatar;
    data['firmInfo'] = this.firmInfo;
    data['firmName'] = this.firmName;
    data['firmValue'] = this.firmValue;
    data['id'] = this.id;
    data['province'] = this.province;
    data['rank'] = this.rank;
    data['score'] = this.score;
    data['town'] = this.town;
    return data;
  }
}

MyFirmModel _$MyFirmModelFromJson(Map<String, dynamic> json) {
  return MyFirmModel(
    accusationCount: json['accusationCount'],
    address: json['address'],
    city: json['city'],
    complaintCount: json['complaintCount'],
    district: json['district'],
    firmAvatar: json['firmAvatar'],
    firmInfo: json['firmInfo'],
    firmName: json['firmName'],
    firmValue: json['firmValue'],
    id: json['id'],
    legalField: List.from(json['legalField']).map((item) {
      return LegalField.fromJson(item);
    }).toList(),
    province: json['province'],
    rank: json['rank'],
    score: json['score'],
    town: json['town'],
  );
}

class LegalField {
  final String legalId;
  final String name;
  final String rank;
  double weight;
  bool isType;

  LegalField({
    this.legalId,
    this.name,
    this.rank,
    this.weight,
    this.isType = false,
  });

  factory LegalField.fromJson(Map<String, dynamic> json) =>
      _$LegalFieldFromJson(json);

  LegalField from(Map<String, dynamic> json) => _$LegalFieldFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['legalId'] = this.legalId;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['weight'] = this.weight;
    return data;
  }
}

LegalField _$LegalFieldFromJson(Map<String, dynamic> json) {
  return LegalField(
      legalId: json['legalId'],
      name: json['name'],
      rank: json['rank'],
      weight: json['weight']);
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [律所成员信息
* @param avatar string 用户头像
* @param firmId string 律所id
* @param id string 律所成员关系id
* @param realName string 用户姓名
* @param type FirmAdminEnum
* @param code integer($int32)
* @param descp string
* @param userId string 用户id]
* */
class FirmNumberModel {
  final String avatar;
  final String firmId;
  final String id;
  final String realName;
  final String type;
  final String userId;

  FirmNumberModel({
    this.avatar,
    this.firmId,
    this.id,
    this.realName,
    this.type,
    this.userId,
  });

  factory FirmNumberModel.fromJson(Map<String, dynamic> json) =>
      _$FirmNumberModelFromJson(json);

  FirmNumberModel from(Map<String, dynamic> json) =>
      _$FirmNumberModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['firmId'] = this.firmId;
    data['id'] = this.id;
    data['realName'] = this.realName;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}

FirmNumberModel _$FirmNumberModelFromJson(Map<String, dynamic> json) {
  return FirmNumberModel(
    avatar: json['avatar'],
    firmId: json['firmId'],
    id: json['id'],
    realName: json['realName'],
    type: json['type'],
    userId: json['userId'],
  );
}

///// **************************************************************************
///// 来自金慧科技Json转Dart工具
///// **************************************************************************
//
//*
//* [LawSetting对象  查看我的律所各属性详细信息
//* @param title string 标题或类型
//* @param type LawSettingEnum
//* @param code integer($int32)
//* @param descp string
//* @param value string 电话，邮箱，或图片地址]
//* */
//class ViewMyFirmDetailModel {
//  final String title;
//  final String type;
//  final String value;
//
//  ViewMyFirmDetailModel({
//    this.title,
//    this.type,
//    this.value,
//  });
//
//  factory ViewMyFirmDetailModel.fromJson(Map<String, dynamic> json) =>
//      _$ViewMyFirmDetailModelFromJson(json);
//
//  ViewMyFirmDetailModel from(Map<String, dynamic> json) =>
//      _$ViewMyFirmDetailModelFromJson(json);
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['title'] = this.title;
//    data['type'] = this.type;
//    data['value'] = this.value;
//    return data;
//  }
//}
//
//ViewMyFirmDetailModel _$ViewMyFirmDetailModelFromJson(
//    Map<String, dynamic> json) {
//  return ViewMyFirmDetailModel(
//    title: json['title'],
//    type: json['type'],
//    value: json['value'],
//  );
//}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [ConsultVO对象  -律所获取任务列表
*
* @param category string 业务类别
* @param categoryId string 业务类别Id
* @param content string 简介
* @param expirationTime string($date-time) 过期时间
* @param firstAsk string 首个答案价格
* @param id string 咨询id
* @param issuerName string 咨询者
* @param limit integer($int32) 时限
* @param optimumAsk string 最佳答案价格
* @param own boolean 是否自己发布的
* @param require string 要求
* @param similarAsk string 相似答案价格
* @param status ConsultStatusEnum
* ...}
* @param title string 标题
* @param totalAsk string 总报价价]
* */
class MissionFirmListResponseModel {
  final String category;
  final String categoryId;
  final String content;
  final String expirationTime;
  final String firstAsk;
  final String id;
  final String issuerName;
  final int limit;
  final String optimumAsk;
  final bool own;
  final String require;
  final String similarAsk;
  final Status status;
  final String title;
  final String totalAsk;

  MissionFirmListResponseModel({
    this.category,
    this.categoryId,
    this.content,
    this.expirationTime,
    this.firstAsk,
    this.id,
    this.issuerName,
    this.limit,
    this.optimumAsk,
    this.own,
    this.require,
    this.similarAsk,
    this.status,
    this.title,
    this.totalAsk,
  });

  factory MissionFirmListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MissionFirmListResponseModelFromJson(json);

  MissionFirmListResponseModel from(Map<String, dynamic> json) =>
      _$MissionFirmListResponseModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['firstAsk'] = this.firstAsk;
    data['id'] = this.id;
    data['issuerName'] = this.issuerName;
    data['limit'] = this.limit;
    data['optimumAsk'] = this.optimumAsk;
    data['own'] = this.own;
    data['require'] = this.require;
    data['similarAsk'] = this.similarAsk;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['title'] = this.title;
    data['totalAsk'] = this.totalAsk;
    return data;
  }
}

MissionFirmListResponseModel _$MissionFirmListResponseModelFromJson(
    Map<String, dynamic> json) {
  return MissionFirmListResponseModel(
    category: json['category'],
    categoryId: json['categoryId'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    firstAsk: json['firstAsk'],
    id: json['id'],
    issuerName: json['issuerName'],
    limit: json['limit'],
    optimumAsk: json['optimumAsk'],
    own: json['own'],
    require: json['require'],
    similarAsk: json['similarAsk'],
    status: json['status'] != null ? new Status.fromJson(json['status']) : null,
    title: json['title'],
    totalAsk: json['totalAsk'],
  );
}

class Status {
  final int code;
  final String descp;

  Status({
    this.code,
    this.descp,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Status from(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['descp'] = this.descp;
    return data;
  }
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    code: json['code'],
    descp: json['descp'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* FirmSettingDetailVo 查看律所所有信息详情
*
* @param email [ 电邮
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param id string
* @param id
* @param mobile [ 电话
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param officialAccounts [ 公众号
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param photo [ 照片
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param qualification [ 资质证明
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param spocialhonor [ 社会荣誉
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param wechat [ 微信
* @param LawSetting对象
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* @param weibo [ 微博
* @param LawSetting对象
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
*
* @param code integer($int32)
* @param descp string
* @param value string 电话，邮箱，或图片地址]
* */
class ViewMyFirmDetailModel {
  final String address;
  final List<dynamic> email;
  final String id;
  final List<dynamic> missive;
  final List<dynamic> mobile;
  final List<dynamic> officialAccounts;
  final List<dynamic> photo;
  final List<dynamic> qualification;
  final List<dynamic> spocialhonor;
  final List<dynamic> website;
  final List<dynamic> wechat;

  ViewMyFirmDetailModel({
    this.address,
    this.email,
    this.id,
    this.missive,
    this.mobile,
    this.officialAccounts,
    this.photo,
    this.qualification,
    this.spocialhonor,
    this.website,
    this.wechat,
  });

  factory ViewMyFirmDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ViewMyFirmDetailModelFromJson(json);

  ViewMyFirmDetailModel from(Map<String, dynamic> json) =>
      _$ViewMyFirmDetailModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.email != null) {
      data['email'] = this.email.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    if (this.missive != null) {
      data['missive'] = this.missive.map((v) => v.toJson()).toList();
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile.map((v) => v.toJson()).toList();
    }
    if (this.officialAccounts != null) {
      data['officialAccounts'] =
          this.officialAccounts.map((v) => v.toJson()).toList();
    }
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    if (this.qualification != null) {
      data['qualification'] =
          this.qualification.map((v) => v.toJson()).toList();
    }
    if (this.spocialhonor != null) {
      data['spocialhonor'] = this.spocialhonor.map((v) => v.toJson()).toList();
    }
    if (this.website != null) {
      data['website'] = this.website.map((v) => v.toJson()).toList();
    }
    if (this.wechat != null) {
      data['wechat'] = this.wechat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

ViewMyFirmDetailModel _$ViewMyFirmDetailModelFromJson(
    Map<String, dynamic> json) {
  return ViewMyFirmDetailModel(
    address: json['address'],
    email: json['email'].map((item) {
      return new Email.fromJson(item);
    }).toList(),
    id: json['id'],
    missive: json['missive'].map((item) {
      return new Missive.fromJson(item);
    }).toList(),
    mobile: json['mobile'].map((item) {
      return new Mobile.fromJson(item);
    }).toList(),
    officialAccounts: json['officialAccounts'].map((item) {
      return new OfficialAccounts.fromJson(item);
    }).toList(),
    photo: json['photo'].map((item) {
      return new Photo.fromJson(item);
    }).toList(),
    qualification: json['qualification'].map((item) {
      return new Qualification.fromJson(item);
    }).toList(),
    spocialhonor: json['spocialhonor'].map((item) {
      return new Spocialhonor.fromJson(item);
    }).toList(),
    website: json['website'].map((item) {
      return new Website.fromJson(item);
    }).toList(),
    wechat: json['wechat'].map((item) {
      return new Wechat.fromJson(item);
    }).toList(),
  );
}

class Email {
  final String id;
  final String title;
  final String type;
  final String value;

  Email({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  Email from(Map<String, dynamic> json) => _$EmailFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Missive {
  final String id;
  final String title;
  final String type;
  final String value;

  Missive({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Missive.fromJson(Map<String, dynamic> json) =>
      _$MissiveFromJson(json);

  Missive from(Map<String, dynamic> json) => _$MissiveFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Missive _$MissiveFromJson(Map<String, dynamic> json) {
  return Missive(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Mobile {
  final String id;
  final String title;
  final String type;
  final String value;

  Mobile({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);

  Mobile from(Map<String, dynamic> json) => _$MobileFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Mobile _$MobileFromJson(Map<String, dynamic> json) {
  return Mobile(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class OfficialAccounts {
  final String id;
  final String title;
  final String type;
  final String value;

  OfficialAccounts({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory OfficialAccounts.fromJson(Map<String, dynamic> json) =>
      _$OfficialAccountsFromJson(json);

  OfficialAccounts from(Map<String, dynamic> json) =>
      _$OfficialAccountsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

OfficialAccounts _$OfficialAccountsFromJson(Map<String, dynamic> json) {
  return OfficialAccounts(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Photo {
  final String id;
  final String title;
  final String type;
  final String value;

  Photo({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Photo from(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Qualification {
  final String id;
  final String title;
  final String type;
  final String value;

  Qualification({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) =>
      _$QualificationFromJson(json);

  Qualification from(Map<String, dynamic> json) =>
      _$QualificationFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Qualification _$QualificationFromJson(Map<String, dynamic> json) {
  return Qualification(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Spocialhonor {
  final String id;
  final String title;
  final String type;
  final String value;

  Spocialhonor({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Spocialhonor.fromJson(Map<String, dynamic> json) =>
      _$SpocialhonorFromJson(json);

  Spocialhonor from(Map<String, dynamic> json) => _$SpocialhonorFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Spocialhonor _$SpocialhonorFromJson(Map<String, dynamic> json) {
  return Spocialhonor(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Website {
  final String id;
  final String title;
  final String type;
  final String value;

  Website({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Website.fromJson(Map<String, dynamic> json) =>
      _$WebsiteFromJson(json);

  Website from(Map<String, dynamic> json) => _$WebsiteFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Website _$WebsiteFromJson(Map<String, dynamic> json) {
  return Website(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

class Wechat {
  final String id;
  final String title;
  final String type;
  final String value;

  Wechat({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Wechat.fromJson(Map<String, dynamic> json) => _$WechatFromJson(json);

  Wechat from(Map<String, dynamic> json) => _$WechatFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Wechat _$WechatFromJson(Map<String, dynamic> json) {
  return Wechat(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

/// firm/apply-list 获取申请列表(get)

/*
* avatar string 申请人头像
* @param create_time string($date-time) 申请时间
* @param id string 申请id
* @param realName string 申请人名称
* @param userId string 申请人id
* */
class FirmApplyListModel extends BaseRequest {
  final String avatar;
  final String createTime;
  final String id;
  final String realName;
  final String userId;
  bool delCheck;

  FirmApplyListModel({
    this.avatar,
    this.createTime,
    this.id,
    this.realName,
    this.userId,
    this.delCheck = false,
  });

  @override
  String url() => '/firm/apply-list';

  factory FirmApplyListModel.fromJson(Map<String, dynamic> json) =>
      _$FirmApplyListModelFromJson(json);

  FirmApplyListModel from(Map<String, dynamic> json) =>
      _$FirmApplyListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['create_time'] = this.createTime;
    data['id'] = this.id;
    data['realName'] = this.realName;
    data['userId'] = this.userId;
    return data;
  }
}

FirmApplyListModel _$FirmApplyListModelFromJson(Map<String, dynamic> json) {
  return FirmApplyListModel(
    avatar: json['avatar'],
    createTime: json['create_time'],
    id: json['id'],
    realName: json['realName'],
    userId: json['userId'],
  );
}

///审核律所申请
class FirmExamineRequestModel extends BaseRequest {
  final String id;
  final int status;

  FirmExamineRequestModel({this.id, this.status});

  @override
  String url() => '/firm/examine';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "status": this.status,
    };
  }
}
