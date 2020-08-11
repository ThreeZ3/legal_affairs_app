import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 律师注册-完善律师基本信息
*
* @param city string 所在市
* @param district string 所在区
* @param email string 邮箱
* @param name string 名字
* @param province string 所在省
* */
class BasicInfoRequestModel extends BaseRequest {
  final String city;
  final String district;
  final String email;
  final String name;
  final String province;

  BasicInfoRequestModel({
    this.city,
    this.district,
    this.email,
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
      "name": this.name,
      "province": this.province,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 新增资质证明数据
* 
* @param id string 资质证明id,新增时不传，编辑时必传
* @param title string 文字说明
* @param value string 图片路径
* */
class CertificationRequestModel extends BaseRequest {
  final String id;
  final String title;
  final String value;

  CertificationRequestModel({
    this.id,
    this.title,
    this.value,
  });

  @override
  String url() => '/lawyer/certification';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.id,
      "value": this.value,
    };
  }
}

/// 删除资质证明
class CertificationDeleteRequestModel extends BaseRequest {
  final String id;

  CertificationDeleteRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/certification/$id';
}

/// 添加律师详细资料->微信,电话,邮箱,微博,公众号
class LawyerContactsRequestModel extends BaseRequest {
  final String id;
  final String title;
  final String value;
  final int type;

  LawyerContactsRequestModel({
    this.id,
    this.title,
    this.value,
    this.type,
  });

  @override
  String url() => '/lawyer/contacts';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "value": this.value,
      "type": this.type,
    };
  }
}

/// 删除律师详细资料->微信,电话,邮箱,微博,公众号
class LawyerContactsDeleteRequestModel extends BaseRequest {
  final String id;

  LawyerContactsDeleteRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/contacts/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* LawyerInfoVo
*
* @param accusationCount string 举报总数
* @param avatar string 头像
* @param city string 市
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
class LawyerInfoModel {
  final String accusationCount;
  final String avatar;
  final String city;
  final String commentCount;
  final String complaintCount;
  final String consultCount;
  final String district;
  final String firmId;
  final String firmName;
  final String id;
  final String lawyerInfo;
  final String lawyerValue;
  final List<NewCategoryModel> legalField;
  final String province;
  final String rank;
  final String realName;
  final String workYear;

  LawyerInfoModel({
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

  factory LawyerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerInfoModelFromJson(json);

  LawyerInfoModel from(Map<String, dynamic> json) =>
      _$LawyerInfoModelFromJson(json);

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
    data['province'] = this.province;
    data['rank'] = this.rank;
    data['realName'] = this.realName;
    data['workYear'] = this.workYear;
    return data;
  }
}

LawyerInfoModel _$LawyerInfoModelFromJson(Map<String, dynamic> json) {
  return LawyerInfoModel(
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

/// 获取当前律师信息
class LawyerCurInfoRequestModel extends BaseRequest {
  final String firmId;

  LawyerCurInfoRequestModel({this.firmId});

  @override
  String url() => '/lawyer/cur-info';
}

/// 新增律师社会荣誉
class AddLawyerHonorRequestModel extends BaseRequest {
  final String id;
  final String title;
  final String value;

  AddLawyerHonorRequestModel({
    this.id,
    this.title,
    this.value,
  });

  @override
  String url() => '/lawyer/honor';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "value": this.value,
    };
  }
}

/// 删除律师社会荣誉
class LawyerHonorDeleteRequestModel extends BaseRequest {
  final String id;

  LawyerHonorDeleteRequestModel({
    this.id,
  });

  @override
  String url() => '/lawyer/honor/$id';
}

/// 修改律师简介
class ChangeLawyerInfoRequestModel extends BaseRequest {
  final String id;
  final String info;

  ChangeLawyerInfoRequestModel({
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
class AddLawyerPhotoRequestModel extends BaseRequest {
  final String id;
  final String lawId;
  final String title;
  final String value;

  AddLawyerPhotoRequestModel({
    this.id,
    this.lawId,
    this.title,
    this.value,
  });

  @override
  String url() => '/lawyer/photo';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "lawId": this.lawId,
      "title": this.title,
      "value": this.value,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 律所注册-插入律师执业信息
*
* @param firmName string 执业机构（律师所名字）
* @param idCardBackImg string 身份证背面
* @param idCardImg string 身份证正面
* @param lawyerCard string 律师资格证号
* @param lawyerCardBackImg string 律师资格证背面
* @param lawyerCardImg string 律师资格证图片
* @param legalField string 擅长领域
* */
class LawyerPracticeInfoRequestModel extends BaseRequest {
  final String firmName;
  final String id;
  final String idCardBackImg;
  final String idCardImg;
  final String lawyerCard;
  final String lawyerCardBackImg;
  final String lawyerCardImg;
  final List<String> legalField;

  LawyerPracticeInfoRequestModel({
    this.firmName,
    this.id,
    this.idCardBackImg,
    this.idCardImg,
    this.lawyerCard,
    this.lawyerCardBackImg,
    this.lawyerCardImg,
    this.legalField,
  });

  @override
  String url() => '/lawyer/practice-information';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firmName": this.firmName,
      "id": this.id,
      "idCardBackImg": this.idCardBackImg,
      "idCardImg": this.idCardImg,
      "lawyerCard": this.lawyerCard,
      "lawyerCardBackImg": this.lawyerCardBackImg,
      "lawyerCardImg": this.lawyerCardImg,
      "legalField": legalField,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 律所注册-设置密码
*
* @param firstPassword string 登陆密码，长度在8~20字符之间
* @param id string 完善基本信息接口返回的律师id
* @param mobile string 手机号
* @param secondPassword string 确认密码
* */
class LawyerSetPasswordRequestModel extends BaseRequest {
  final String firstPassword;
  final String id;
  final String mobile;
  final String secondPassword;

  LawyerSetPasswordRequestModel({
    this.firstPassword,
    this.id,
    this.mobile,
    this.secondPassword,
  });

  @override
  String url() => '/lawyer/register';

  @override
  Map<String, dynamic> toJson() {
    return {
      "firstPassword": this.firstPassword,
      "id": this.id,
      "mobile": this.mobile,
      "secondPassword": this.secondPassword,
    };
  }
}

/// 修改律师理念
class LawyerChangeValueRequestModel extends BaseRequest {
  final String id;
  final String value;

  LawyerChangeValueRequestModel({
    this.id,
    this.value,
  });

  @override
  String url() => '/lawyer/value';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "value": this.value,
    };
  }
}

/// 查询律师信息
class LawyerViewInfoRequestModel extends BaseRequest {
  final String id;

  LawyerViewInfoRequestModel({this.id});

  @override
  String url() => '/lawyer/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class LawyerViewInfoModel {
  final String accusationCount;
  final String avatar;
  final String birthday;
  final String city;
  final String commentCount;
  final String complaintCount;
  final String consultCount;
  final String district;
  final String education;
  final String firmId;
  final String firmName;
  final String id;
  final String lawyerInfo;
  final String lawyerValue;
  final List<LegalFieldModel> legalField;
  final String province;
  final String rank;
  final String realName;
  final Sex sex;
  final String workYear;

  LawyerViewInfoModel({
    this.accusationCount,
    this.avatar,
    this.birthday,
    this.city,
    this.commentCount,
    this.complaintCount,
    this.consultCount,
    this.district,
    this.education,
    this.firmId,
    this.firmName,
    this.id,
    this.lawyerInfo,
    this.lawyerValue,
    this.legalField,
    this.province,
    this.rank,
    this.realName,
    this.sex,
    this.workYear,
  });

  factory LawyerViewInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerViewInfoModelFromJson(json);

  LawyerViewInfoModel from(Map<String, dynamic> json) =>
      _$LawyerViewInfoModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accusationCount'] = this.accusationCount;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['city'] = this.city;
    data['commentCount'] = this.commentCount;
    data['complaintCount'] = this.complaintCount;
    data['consultCount'] = this.consultCount;
    data['district'] = this.district;
    data['education'] = this.education;
    data['firmId'] = this.firmId;
    data['firmName'] = this.firmName;
    data['id'] = this.id;
    data['lawyerInfo'] = this.lawyerInfo;
    data['lawyerValue'] = this.lawyerValue;
    if (this.legalField != null) {
      data['legalField'] = this.legalField.map((v) => v.toJson()).toList();
    }
    data['province'] = this.province;
    data['rank'] = this.rank;
    data['realName'] = this.realName;
    if (this.sex != null) {
      data['sex'] = this.sex.toJson();
    }
    data['workYear'] = this.workYear;
    return data;
  }
}

LawyerViewInfoModel _$LawyerViewInfoModelFromJson(Map<String, dynamic> json) {
  return LawyerViewInfoModel(
    accusationCount: json['accusationCount'],
    avatar: json['avatar'],
    birthday: json['birthday'],
    city: json['city'],
    commentCount: json['commentCount'],
    complaintCount: json['complaintCount'],
    consultCount: json['consultCount'],
    district: json['district'],
    education: json['education'],
    firmId: json['firmId'],
    firmName: json['firmName'],
    id: json['id'],
    lawyerInfo: json['lawyerInfo'],
    lawyerValue: json['lawyerValue'],
    legalField: json['legalField'].map((item) {
      return new LegalFieldModel.fromJson(item);
    }).toList(),
    province: json['province'],
    rank: json['rank'],
    realName: json['realName'],
    sex: json['sex'] != null ? new Sex.fromJson(json['sex']) : null,
    workYear: json['workYear'],
  );
}

class LegalFieldModel {
  final String legalId;
  final String name;
  final String rank;
  final int weight;

  LegalFieldModel({
    this.legalId,
    this.name,
    this.rank,
    this.weight,
  });

  factory LegalFieldModel.fromJson(Map<String, dynamic> json) =>
      _$LegalFieldModelFromJson(json);

  LegalFieldModel from(Map<String, dynamic> json) =>
      _$LegalFieldModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['legalId'] = this.legalId;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['weight'] = this.weight;
    return data;
  }
}

LegalFieldModel _$LegalFieldModelFromJson(Map<String, dynamic> json) {
  return LegalFieldModel(
    legalId: json['legalId'],
    name: json['name'],
    rank: json['rank'],
    weight: json['weight'],
  );
}

class Sex {
  final int code;
  final String descp;

  Sex({
    this.code,
    this.descp,
  });

  factory Sex.fromJson(Map<String, dynamic> json) => _$SexFromJson(json);

  Sex from(Map<String, dynamic> json) => _$SexFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['descp'] = this.descp;
    return data;
  }
}

Sex _$SexFromJson(Map<String, dynamic> json) {
  return Sex(
    code: json['code'],
    descp: json['descp'],
  );
}

/// 修改律师类型
class LawyerLegalFieldRequestModel extends BaseRequest {
  final List<Fields> ids;

  LawyerLegalFieldRequestModel({
    this.ids,
  });

  @override
  String url() => '/lawyer/legalField';

  @override
  Map<String, dynamic> toJson() {
    return {
      'legalFieldIds': ids.map((item) => item.toJson()).toList(),
    };
  }
}

/// 搜索律师
class SearchRequestModel extends BaseRequest {
  final String identityCard;
  final String lawyerCard;
  final String realName;

  SearchRequestModel({
    this.identityCard,
    this.lawyerCard,
    this.realName,
  });

  @override
  String url() => '/lawyer/info/search';

  @override
  Map<String, dynamic> toJson() {
    return {
      "identityCard": this.identityCard,
      "lawyerCard": this.lawyerCard,
      "realName": this.realName,
    };
  }
}
