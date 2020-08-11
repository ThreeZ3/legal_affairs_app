import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 插入律所地址
class FirmInsertAddressRequestModel extends BaseRequest {
  final String address;
  final String city;
  final String district;
  final String id;
  final String lat;
  final String lng;
  final String province;
  final String town;

  FirmInsertAddressRequestModel({
    this.address,
    this.city,
    this.district,
    this.id,
    this.lat,
    this.lng,
    this.province,
    this.town,
  });

  @override
  String url() => '/firm/address';

  @override
  Map<String, dynamic> toJson() {
    return {
      "address": this.address,
      "city": this.city,
      "district": this.district,
      "id": this.id,
      "lat": this.lat,
      "lng": this.lng,
      "province": this.province,
      "town": this.town,
    };
  }
}

/// 新增律所管理员
class AddAdminRequestModel extends BaseRequest {
  final String firmId;
  final int type;
  final String userId;

  AddAdminRequestModel({
    this.firmId,
    this.type,
    this.userId,
  });

  @override
  String url() => '/firm/admin';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firmId": this.firmId,
      "type": this.type,
      "userId": this.userId,
    };
  }
}

/// deleteAdmin 删除管理员
class DeleteAdminRequestModel extends BaseRequest {
  final String id;

  DeleteAdminRequestModel(this.id);

  @override
  String url() => '/firm/admin/$id';
}

/// 修改律所电话、微信、邮箱、微博、公众号
class ChangeContactsRequestModel extends BaseRequest {
  final String id;
  final String value;

  ChangeContactsRequestModel({
    this.id,
    this.value,
  });

  @override
  String url() => '/firm/contacts';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "value": this.value,
    };
  }
}

/// 新增律所荣誉
class AddHonorRequestModel extends BaseRequest {
  final String title;
  final String value;

  AddHonorRequestModel({
    this.title,
    this.value,
  });

  @override
  String url() => '/firm/honor';

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "type": {
        "code": 0,
        "descp": "string",
      },
      "value": this.value,
    };
  }
}

/// 根据id修改荣誉
class ChangeHonorRequestModel extends BaseRequest {
  final String title;
  final String value;
  final String id;

  ChangeHonorRequestModel({
    this.title,
    this.value,
    this.id,
  });

  @override
  String url() => '/firm/honor/$id';

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "type": {
        "code": 0,
        "descp": "string",
      },
      "value": this.value,
    };
  }
}

/// 修改律所简介
class ChangeInfoRequestModel extends BaseRequest {
  final String content;

  ChangeInfoRequestModel({
    this.content,
  });

  @override
  String url() => '/firm/info';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
    };
  }
}

/// 邀请加入律所
class FirmInvitedRequestModel extends BaseRequest {
  final String userId;

  FirmInvitedRequestModel({
    this.userId,
  });

  @override
  String url() => '/firm/invited';

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
    };
  }
}

/// 律所列表
class FirmListRequestModel extends BaseRequest {
  @override
  String url() => '/firm/list';
}

/// 新增律所照片
class AddPhotoRequestModel extends BaseRequest {
  final String value;

  AddPhotoRequestModel({
    this.value,
  });

  @override
  String url() => '/firm/photo';

  @override
  Map<String, dynamic> toJson() {
    return {
      "value": this.value,
    };
  }
}

/// 根据id修改荣誉[照片]
class ChangePhotoRequestModel extends BaseRequest {
  final String value;
  final String id;

  ChangePhotoRequestModel({
    this.id,
    this.value,
  });

  @override
  String url() => '/firm/photo/$id';

  @override
  Map<String, dynamic> toJson() {
    return {
      "value": this.value,
    };
  }
}

/// 新增律所资质证明
class QualificationRequestModel extends BaseRequest {
  final String firmType;
  final String firmValue;
  final String lawId;

  QualificationRequestModel({
    this.firmType,
    this.firmValue,
    this.lawId,
  });

  @override
  String url() => '/firm/qualification';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firmType": this.firmType,
      "firmValue": this.firmValue,
      "lawId": this.lawId,
    };
  }
}

/// 修改律所理念
class ChangeFirmValueRequestModel extends BaseRequest {
  final String content;

  ChangeFirmValueRequestModel({
    this.content,
  });

  @override
  String url() => '/firm/value';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
    };
  }
}

/// 查看律所详情  查看律所所有信息详情
class ViewFirmDetailsRequestModel extends BaseRequest {
  final String id;

  ViewFirmDetailsRequestModel({
    this.id,
  });

  @override
  String url() => '/firm/all-detail/$id';
}

/// 查看律所信息
class ViewFirmInfoRequestModel extends BaseRequest {
  final String id;

  ViewFirmInfoRequestModel({
    this.id,
  });

  @override
  String url() => '/firm/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
*
*
* @param accusationCount string 举报总数
* @param address string 详细地址
* @param city string 事务所所属城市
* @param complaintCount string 投诉总数
* @param district string 事务所所属区
* @param firmAvatar string 事务所图标
* @param firmInfo string 律师所简介
* @param firmName string 事务所名称
* @param firmValue string 律师所理念
* @param id string
* @param legalField [...]
* @param province string 事务所所属省份
* @param rank integer($int32) 排名：可为空，运营字段
* @param score integer($int32) 总评分
* @param town string 事务所所属镇
* */
class FirmDetailsInfoModel {
  final String accusationCount;
  final dynamic address;
  final dynamic city;
  final String complaintCount;
  final dynamic district;
  final String firmAvatar;
  final dynamic firmInfo;
  final String firmName;
  final dynamic firmValue;
  final String id;
  final List<NewCategoryModel> legalField;
  final dynamic province;
  final int rank;
  final dynamic score;
  final dynamic town;

  FirmDetailsInfoModel({
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

  factory FirmDetailsInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FirmDetailsInfoModelFromJson(json);

  FirmDetailsInfoModel from(Map<String, dynamic> json) =>
      _$FirmDetailsInfoModelFromJson(json);

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

FirmDetailsInfoModel _$FirmDetailsInfoModelFromJson(Map<String, dynamic> json) {
  return FirmDetailsInfoModel(
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
      return NewCategoryModel.fromJson(item);
    }).toList(),
    province: json['province'],
    rank: json['rank'],
    score: json['score'],
    town: json['town'],
  );
}

/// 获取律所成员
class ViewFirmMembersRequestModel extends BaseRequest {
  final String id;

  ViewFirmMembersRequestModel({
    this.id,
  });

  @override
  String url() => '/firm/members/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [律所成员信息
*
* @param avatar string 用户头像
* @param city string 市
* @param district string 区
* @param firmId string 律所id
* @param id string 律所成员关系id
* @param legalField [ 擅长领域
* @param string]
* @param province string 省
* @param rank integer($int32) 排名：可为空，运营字段
* @param realName string 用户姓名
* @param type FirmAdminEnum
*
* @param code integer($int32)
* @param descp string
* @param userId string 用户id
* @param workYear string 工资年限]
* */
class FirmMemberModel {
  final String avatar;
  final String city;
  final String district;
  final String firmId;
  final String id;
  final List<NewCategoryModel> legalField;
  final String province;
  final int rank;
  final String realName;
  final String type;
  final String userId;
  final String workYear;

  FirmMemberModel({
    this.avatar,
    this.city,
    this.district,
    this.firmId,
    this.id,
    this.legalField,
    this.province,
    this.rank,
    this.realName,
    this.type,
    this.userId,
    this.workYear,
  });

  factory FirmMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FirmMemberModelFromJson(json);

  FirmMemberModel from(Map<String, dynamic> json) =>
      _$FirmMemberModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['city'] = this.city;
    data['district'] = this.district;
    data['firmId'] = this.firmId;
    data['id'] = this.id;
    data['province'] = this.province;
    data['rank'] = this.rank;
    data['realName'] = this.realName;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['workYear'] = this.workYear;
    return data;
  }
}

FirmMemberModel _$FirmMemberModelFromJson(Map<String, dynamic> json) {
  return FirmMemberModel(
    avatar: json['avatar'],
    city: json['city'],
    district: json['district'],
    firmId: json['firmId'],
    id: json['id'],
    legalField: List.from(json['legalField']).map((item) {
      return NewCategoryModel.fromJson(item);
    }).toList(),
    province: json['province'],
    rank: json['rank'],
    realName: json['realName'],
    type: json['type'],
    userId: json['userId'],
    workYear: json['workYear'],
  );
}

/// 创建律所
class CreateFirmRequestModel extends BaseRequest {
  final String address;
  final String city;
  final String district;
  final String firmAvatar;
  final String firmInfo;
  final String firmName;
  final String lawId;
  final String firmValue;
  final String lat;
  final List<Field> legalField;
  final String lng;
  final String province;
  final String town;
  final List<Setting> firmSettingDTOS;

  CreateFirmRequestModel({
    this.address,
    this.city,
    this.district,
    this.firmAvatar,
    this.firmInfo,
    this.firmName,
    this.lawId,
    this.firmValue,
    this.lat,
    this.legalField,
    this.lng,
    this.province,
    this.town,
    this.firmSettingDTOS,
  });

  @override
  String url() => '/firm/create';

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': this.address,
      "city": this.city,
      "district": this.district,
      "firmAvatar": this.firmAvatar,
      "firmInfo": this.firmInfo,
      "firmName": this.firmName,
      "firmSettingDTOS": this.firmSettingDTOS,
      "firmValue": this.firmValue,
      "legalField": this.legalField,
      'lat': this.lat,
      "lng": this.lng,
      "province": this.province,
      "town": this.town,
    };
  }
}

class Field extends BaseRequest {
  final String id;
  final double weight;

  Field({this.id, this.weight});

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "weight": this.weight,
    };
  }
}

class Setting extends BaseRequest {
  final String title;
  final int type;
  final String value;

  Setting({this.title, this.type, this.value});

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "type": this.type,
      "value": this.value,
    };
  }
}

///申请加入律所
class ApplyFirmRequestModel extends BaseRequest {
  final String id;

  ApplyFirmRequestModel({this.id});

  @override
  String url() => '/firm/apply';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
    };
  }
}

///接受或拒绝律所邀请
class FirmInviteHandleRequestModel extends BaseRequest {
  final String id;

//  mode	integer($int32) 处理方式:1.接受邀请，-1.拒绝邀请
  final int mode;

  FirmInviteHandleRequestModel({
    this.id,
    this.mode,
  });

  @override
  String url() => '/index/firm-invited/handle';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'mode': this.mode,
    };
  }
}

/// 修改律所各项属性信息
class ChangeFirmSettingRequestModel extends BaseRequest {
  final String id;
  final String title;
  final String value;

  ChangeFirmSettingRequestModel({
    this.id,
    this.title,
    this.value,
  });

  @override
  String url() => '/firm/setting';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "value": this.value,
    };
  }
}

/// 新增律所各项属性信息
class AddFirmSettingRequestModel extends BaseRequest {
  final String lawId;
  final String title;
  final int type;
  final String value;

  AddFirmSettingRequestModel({
    this.lawId,
    this.title,
    this.type,
    this.value,
  });

  @override
  String url() => '/firm/setting';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lawId": this.lawId,
      "title": this.title,
      "type": this.type,
      "value": this.value,
    };
  }
}

/// 删除律所各项属性信息
class DelFirmSettingRequestModel extends BaseRequest {
  final String id;

  DelFirmSettingRequestModel(
    this.id,
  );

  @override
  String url() => '/firm/setting/$id';
}

/// 点击律所
class FirmClickRequestModel extends BaseRequest {
  final String id;

  FirmClickRequestModel({
    this.id,
  });

  @override
  String url() => '/firm/click/$id';
}

///修改律所成员权限
class PutFirmAdminRequestModel extends BaseRequest {
  final int type;
  final String userId;

  PutFirmAdminRequestModel({
    this.type,
    this.userId,
  });

  @override
  String url() => '/firm/admin';

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "userid": this.userId,
    };
  }
}

///获取所有律所名称
class FirmAllNameRequestModel extends BaseRequest {
  @override
  String url() => '/firm/all-name';
}

/// firm/all-short-info 获取所有律所简略信息
class FirmAllShortInfoRequestModel extends BaseRequest {
  final String firmName;
  final String id;

  FirmAllShortInfoRequestModel({this.firmName, this.id});

  @override
  String url() => '/firm/all-short-info';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firmName": this.firmName,
      "id": this.id,
    };
  }
}
