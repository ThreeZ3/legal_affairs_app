import 'package:jh_legal_affairs/util/tools.dart';

/// 首页律师推荐列表
class LawyerListRequestModel extends BaseRequest {
  @override
  String url() => '/index/indexLawyer-List';
}

/// 搜索获取律师列表
class LawyerSearchRequestModel extends BaseRequest {
  final String lat;
  final String lng;
  final int page;
  final int limit;
  final String name;
  final String typeId;
  final String city;
  final String district;
  final String province;

  // 排序类型:1.人气,2.距离
  final int orderType;
  final int maxRank;
  final int maxRange;

  LawyerSearchRequestModel({
    this.lat,
    this.lng,
    this.page,
    this.limit,
    this.name,
    this.typeId,
    this.province,
    this.city,
    this.district,
    this.orderType,
    this.maxRange,
    this.maxRank,
  });

  @override
  String url() => '/lawyer/list/search';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "lng": this.lng,
      "page": this.page,
      "limit": this.limit,
      "name": this.name,
      "typeId": this.typeId,
      "city": this.city,
      "province": this.province,
      "district": this.district,
      "orderType": this.orderType,
      "maxRange": this.maxRange,
      "maxRank": this.maxRank,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [#/definitions/首页推荐的律师首页推荐的律师
*
* @param avatar string 头像
* @param city string 城市
* @param createTime string($date-time) 记录创建时间
* @param deleted integer($int32) 删除标记,0表示没有被删除，1表示主动删除，2表示被动删除
* @param id string 用户ID
* @param legalField string 擅长领域
* @param nickName string 昵称
* @param province string 省份
* @param updateTime string($date-time) 记录更新时间
* @param workYear string 执业年龄]
* */
class LawyerListModel {
  final String firmName;
  final String avatar;
  final String city;
  final String createTime;
  final int deleted;
  final String id;
  final List<NewCategoryModel> legalField;
  final String nickName;
  final String province;
  final String updateTime;
  final String workYear;
  final String realName;
  final String range;
  final dynamic rank;

  LawyerListModel(
      {this.range,
      this.avatar,
      this.city,
      this.createTime,
      this.deleted,
      this.id,
      this.legalField,
      this.nickName,
      this.province,
      this.updateTime,
      this.workYear,
      this.realName,
      this.rank,
      this.firmName});

  factory LawyerListModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerListModelFromJson(json);

  LawyerListModel from(Map<String, dynamic> json) =>
      _$LawyerListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['range'] = this.range;
    data['city'] = this.city;
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['province'] = this.province;
    data['updateTime'] = this.updateTime;
    data['workYear'] = this.workYear;
    data['realName'] = this.realName;
    data['rank'] = this.rank;
    data['firmName'] = this.firmName;
    return data;
  }
}

LawyerListModel _$LawyerListModelFromJson(Map<String, dynamic> json) {
  return LawyerListModel(
      avatar: json['avatar'],
      range: json['range'],
      city: json['city'],
      createTime: json['createTime'],
      deleted: json['deleted'],
      id: json['id'],
      legalField: List.from(json['legalField']).map((item) {
        return NewCategoryModel.fromJson(item);
      }).toList(),
      nickName: json['nickName'],
      province: json['province'],
      updateTime: json['updateTime'],
      workYear: json['workYear'],
      realName: json['realName'],
      rank: json['rank'],
      firmName: json["firmName"]);
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class NewCategoryModel {
  final String legalId;
  final String name;
  final String rank;
  final double weight;

  NewCategoryModel({
    this.legalId,
    this.name,
    this.rank,
    this.weight,
  });

  factory NewCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$NewCategoryModelFromJson(json);

  NewCategoryModel from(Map<String, dynamic> json) =>
      _$NewCategoryModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['legalId'] = this.legalId;
    data['name'] = this.name;
    data['rank'] = this.rank;
    return data;
  }
}

NewCategoryModel _$NewCategoryModelFromJson(Map<String, dynamic> json) {
  return NewCategoryModel(
    legalId: json['legalId'],
    name: json['name'],
    rank: json['rank'],
    weight: json['weight'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 律所注册-完善律师基本信息
*
* @param city string 所在市
* @param district string 所在区
* @param email string 邮箱
* @param id string 插入执业信息接口返回的律师id
* @param name string 名字
* @param province string 所在省
* */
class LawyerRegisterRequestModel extends BaseRequest {
  final String city;
  final String district;
  final String email;
  final String id;
  final String name;
  final String province;

  LawyerRegisterRequestModel({
    this.city,
    this.district,
    this.email,
    this.id,
    this.name,
    this.province,
  });

  @override
  String url() => '/lawyer/basic-information';

  @override
  Map<String, dynamic> toJson() {
    return {
      "city": this.city,
      "district": this.district,
      "email": this.email,
      "id": this.id,
      "name": this.name,
      "province": this.province,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 新增资质证明
*
* @param introductionValue [ 前端传入的律师资质证明照片路径
* @param string]
* @param lawId string 律师id
* @param title string 文字说明
* @param type string 图片类型
* @param value string 最终图片路径
* */
class LawyerCertificationRequestModel extends BaseRequest {
  final List<String> introductionValue;
  final String lawId;
  final String title;
  final String type;
  final String value;

  LawyerCertificationRequestModel({
    this.introductionValue,
    this.lawId,
    this.title,
    this.type,
    this.value,
  });

  @override
  String url() => '/lawyer/certification';

  @override
  Map<String, dynamic> toJson() {
    return {
      "introductionValue": this.introductionValue,
      "lawId": this.lawId,
      "title": this.title,
      "type": this.type,
      "value": this.value,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 修改律师详细资料->微信,电话,邮箱,微博,公众号
*
* @param content string 修改内容
* @param id string 律师id
* @param type string 修改类型->微信,电话,邮箱,微博,公众号
* @param Enum:
[ PHONE, EMAIL, WECHAT, OfficialAccounts, WEIBO ]
* */
class LawyerChangeInfoRequestModel extends BaseRequest {
  final String content;
  final String id;
  final String type;

  LawyerChangeInfoRequestModel({
    this.content,
    this.id,
    this.type,
  });

  @override
  String url() => '/lawyer/contacts';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
      "id": this.id,
      "type": this.type,
    };
  }
}

/// 删除律师社会荣誉
class LawyerDelHonorRequestModel extends BaseRequest {
  final List<String> introductionValue;
  final String lawId;
  final String title;
  final String value;

  LawyerDelHonorRequestModel({
    this.introductionValue,
    this.lawId,
    this.title,
    this.value,
  });

  @override
  String url() => '/lawyer/delete-honor';

  @override
  Map<String, dynamic> toJson() {
    return {
      "introductionValue": this.introductionValue,
      "lawId": this.lawId,
      "title": this.title,
      "value": this.value,
    };
  }
}

/// 律师详情下的详细资料
class LawyerDetailRequestModel extends BaseRequest {
  final String id;

  LawyerDetailRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/detail/$id';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
    };
  }
}

/// 修改律师简介
class LawyerChangeInfoDesRequestModel extends BaseRequest {
  final String id;
  final String info;

  LawyerChangeInfoDesRequestModel({
    this.id,
    this.info,
  });

  @override
  String url() => '/lawyer/info';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "info": this.info,
    };
  }
}

/// 新增律师照片
class LawyerAddPhotoRequestModel extends BaseRequest {
  final List<String> introductionValue;
  final String lawId;
  final String title;
  final String type;
  final String value;

  LawyerAddPhotoRequestModel({
    this.introductionValue,
    this.lawId,
    this.title,
    this.type,
    this.value,
  });

  @override
  String url() => '/lawyer/photo';

  @override
  Map<String, dynamic> toJson() {
    return {
      "introductionValue": this.introductionValue,
      "lawId": this.lawId,
      "title": this.title,
      "type": this.type,
      "value": this.value,
    };
  }
}

/// 律师评分
class LawyerScoreRequestModel extends BaseRequest {
  final String id;
  final int score;

  LawyerScoreRequestModel({
    this.id,
    this.score,
  });

  @override
  String url() => '/lawyer-score';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "score": this.score,
    };
  }
}

/// 查询律师详情
class LawyerDetailsRequestModel extends BaseRequest {
  final String id;

  LawyerDetailsRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/$id';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
*
*
* @param accusationCount string 举报总数
* @param avatar string 头像
* @param city string 城市
* @param commentCount string 评论总数
* @param complaintCount string 投诉总数
* @param consultCount string 咨询总数
* @param district string 区
* @param firmId string 律所id
* @param firmName string 律所名称
* @param id string
* @param id
* @param lawyerInfo string 律师简介
* @param lawyerValue string 律师理念
* @param legalField [ 擅长领域
* @param string]
* @param province string 所在省
* @param rank string 排名
* @param realName string 真实姓名
* @param workYear string 工作年限
* */
class LawyerDetailsInfoModel {
  final String accusationCount;
  final String avatar;
  final String city;
  final String commentCount;
  final dynamic complaintCount;
  final String consultCount;
  final String district;
  final String firmId;
  final String firmName;
  final String id;
  final dynamic lawyerInfo;
  final dynamic lawyerValue;
  final List<NewCategoryModel> legalField;
  final String province;
  final dynamic rank;
  final dynamic realName;
  final String workYear;

  LawyerDetailsInfoModel({
    this.accusationCount,
    this.avatar,
    this.city,
    this.commentCount,
    this.complaintCount,
    this.consultCount,
    this.district,
    this.firmId,
    this.firmName,
    this.id,
    this.lawyerInfo,
    this.lawyerValue,
    this.legalField,
    this.province,
    this.rank,
    this.realName,
    this.workYear,
  });

  factory LawyerDetailsInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerDetailsInfoModelFromJson(json);

  LawyerDetailsInfoModel from(Map<String, dynamic> json) =>
      _$LawyerDetailsInfoModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accusationCount'] = this.accusationCount;
    data['avatar'] = this.avatar;
    data['city'] = this.city;
    data['commentCount'] = this.commentCount;
    data['complaintCount'] = this.complaintCount;
    data['consultCount'] = this.consultCount;
    data['district'] = this.district;
    data['firmId'] = this.firmId;
    data['firmName'] = this.firmName;
    data['id'] = this.id;
    data['lawyerInfo'] = this.lawyerInfo;
    data['lawyerValue'] = this.lawyerValue;
    data['legalField'] = this.legalField;
    data['province'] = this.province;
    data['rank'] = this.rank;
    data['realName'] = this.realName;
    data['workYear'] = this.workYear;
    return data;
  }
}

LawyerDetailsInfoModel _$LawyerDetailsInfoModelFromJson(
    Map<String, dynamic> json) {
  return LawyerDetailsInfoModel(
    accusationCount: json['accusationCount'],
    avatar: json['avatar'],
    city: json['city'],
    commentCount: json['commentCount'],
    complaintCount: json['complaintCount'],
    consultCount: json['consultCount'],
    district: json['district'],
    firmId: json['firmId'],
    firmName: json['firmName'],
    id: json['id'],
    lawyerInfo: json['lawyerInfo'],
    lawyerValue: json['lawyerValue'],
    legalField: List.from(json['legalField']).map((item) {
      return NewCategoryModel.fromJson(item);
    }).toList(),
    province: json['province'],
    rank: json['rank'],
    realName: json['realName'],
    workYear: json['workYear'],
  );
}

/// 律师投诉
class LawyerComplaintRequestModel extends BaseRequest {
  final String content;
  final String img;
  final String lawId;
  final int type;

  LawyerComplaintRequestModel({
    this.content,
    this.img,
    this.lawId,
    this.type,
  });

  @override
  String url() => '/complaints-report/complaint';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
      "img": this.img,
      "lawId": this.lawId,
      "type": this.type,
    };
  }
}

/// 律师举报
class LawyerAccusationRequestModel extends BaseRequest {
  final String content;
  final String img;
  final String lawId;
  final int type;

  LawyerAccusationRequestModel({
    this.content,
    this.img,
    this.lawId,
    this.type,
  });

  @override
  String url() => '/complaints-report/accusation';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
      "img": this.img,
      "lawId": this.lawId,
      "type": this.type,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* email [ 电邮
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param id string
* @param id
* @param mobile [ 电话
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param officialAccounts [ 公众号
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param photo [ 照片
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param qualification [ 资质证明
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param spocialhonor [ 社会荣誉
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param wechat [ 微信
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* @param weibo [ 微博
* @param LawSetting对象
*
* @param id string
* @param title string 标题或类型
* @param type LawSettingEnum
* ...}
* @param value string 电话，邮箱，或图片地址]
* */
class ViewLawyerDetailModel {
  final List<dynamic> email;
  final String id;
  final List<dynamic> mobile;
  final List<dynamic> officialAccounts;
  final List<dynamic> photo;
  final List<dynamic> qualification;
  final List<dynamic> spocialhonor;
  final List<dynamic> wechat;
  final List<dynamic> weibo;

  ViewLawyerDetailModel({
    this.email,
    this.id,
    this.mobile,
    this.officialAccounts,
    this.photo,
    this.qualification,
    this.spocialhonor,
    this.wechat,
    this.weibo,
  });

  factory ViewLawyerDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ViewLawyerDetailModelFromJson(json);

  ViewLawyerDetailModel from(Map<String, dynamic> json) =>
      _$ViewLawyerDetailModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.email != null) {
      data['email'] = this.email.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
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
    if (this.wechat != null) {
      data['wechat'] = this.wechat.map((v) => v.toJson()).toList();
    }
    if (this.weibo != null) {
      data['weibo'] = this.weibo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

ViewLawyerDetailModel _$ViewLawyerDetailModelFromJson(
    Map<String, dynamic> json) {
  return ViewLawyerDetailModel(
    email: json['email'].map((item) {
      return new Email.fromJson(item);
    }).toList(),
    id: json['id'],
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
    wechat: json['wechat'].map((item) {
      return new Wechat.fromJson(item);
    }).toList(),
    weibo: json['weibo'].map((item) {
      return new Weibo.fromJson(item);
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

class Weibo {
  final String id;
  final String title;
  final String type;
  final String value;

  Weibo({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory Weibo.fromJson(Map<String, dynamic> json) => _$WeiboFromJson(json);

  Weibo from(Map<String, dynamic> json) => _$WeiboFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

Weibo _$WeiboFromJson(Map<String, dynamic> json) {
  return Weibo(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}

/// 点击律师
class LawyerClickRequestModel extends BaseRequest {
  final String id;

  LawyerClickRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/click/$id';
}

/// firm/detail/{id}/{type} 通过律所id，属性详情类型获取律所详情

class FirmDetailRequestModel extends BaseRequest {
  final String id;
  final int type;

  FirmDetailRequestModel({this.id, this.type});

  @override
  String url() => '/firm/detail/$id/$type';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* id string
* @param title string 标题或类型
* @param type string 属性
* @param value string 电话，邮箱，或图片地址
* */
class FirmDetailModel {
  final String id;
  final String title;
  final String type;
  final String value;

  FirmDetailModel({
    this.id,
    this.title,
    this.type,
    this.value,
  });

  factory FirmDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FirmDetailModelFromJson(json);

  FirmDetailModel from(Map<String, dynamic> json) =>
      _$FirmDetailModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

FirmDetailModel _$FirmDetailModelFromJson(Map<String, dynamic> json) {
  return FirmDetailModel(
    id: json['id'],
    title: json['title'],
    type: json['type'],
    value: json['value'],
  );
}
