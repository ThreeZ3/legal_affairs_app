import 'package:jh_legal_affairs/util/tools.dart';

/// lawyer/practice-information 律所注册-插入律师执业信息(put)

/*
* 律师执业信息
*
* @param firmName string
* @param example: 金慧律师事务所 执业机构（律师所名字）
* @param id string 插入执业信息接口返回的律师id
* @param idCardBackImg string
* @param example: http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png 身份证背面
* @param idCardImg string
* @param example: http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png 身份证正面
* @param lawyerCard string
* @param example: 454545-121 律师资格证号
* @param lawyerCardBackImg string
* @param example: http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png 律师资格证背面
* @param lawyerCardImg string
* @param example: http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png 律师资格证图片
* @param legalField [...]
* */
class PracticeInformationRequestModel extends BaseRequest {
  final String firmName;
  final String id;
  final String idCardBackImg;
  final String idCardImg;
  final String lawyerCard;
  final String lawyerCardBackImg;
  final String lawyerCardImg;
  final List<Fields> legalField;

  PracticeInformationRequestModel({
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

  Map<String, dynamic> toJson() {
    return {
      'firmName': this.firmName,
      'id': this.id,
      'idCardBackImg': this.idCardBackImg,
      'idCardImg': this.idCardImg,
      'lawyerCard': this.lawyerCard,
      'lawyerCardBackImg': this.lawyerCardBackImg,
      'lawyerCardImg': this.lawyerCardImg,
      'legalField': this.legalField,
    };
  }
}

class Fields extends BaseRequest {
  final String id;
  final double weight;

  Fields({this.id, this.weight});
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "weight": this.weight,
    };
  }
}

/// lawyer/basic-information 律师注册-完善律师基本信息(post)

/*
* 律师基本信息
*
* @param birthday string($date-time) 生日
* @param city string
* @param example: 珠海市 所在市
* @param district string
* @param example: 香洲区 所在区
* @param education string 学历
* @param email string
* @param example: 110@qq.com 邮箱
* @param lat string
* @param example: 1214.21 纬度
* @param lng string
* @param example: 1214.21 经度
* @param name string
* @param example: 张三 名字
* @param province string
* @param example: 广东省 所在省
* @param sex integer($int32)
* @param example: 1 性别:1.男,2.女
* */

class BasicInformationRequestModel extends BaseRequest {
  final String birthday;
  final String city;
  final String district;
  final String education;
  final String email;
  final double lat;
  final double lng;
  final String name;
  final String province;
  final String identityCard;
  final String code;
  final String mobile;
  final String workYear;
  final int sex;

  BasicInformationRequestModel({
    this.identityCard,
    this.birthday,
    this.city,
    this.district,
    this.education,
    this.email,
    this.lat,
    this.lng,
    this.name,
    this.province,
    this.sex,
    this.code,
    this.mobile,
    this.workYear
  });

  @override
  String url() => '/lawyer/basic-information';

  Map<String, dynamic> toJson() {
    return {
      'identityCard': this.identityCard,
      'code': this.code,
      'mobile': this.mobile,
      'workYear': this.workYear,
      'birthday': this.birthday,
      'city': this.city,
      'district': this.district,
      'education': this.education,
      'email': this.email,
      'lat': this.lat,
      'lng': this.lng,
      'name': this.name,
      'province': this.province,
      'sex': this.sex,
    };
  }
}
