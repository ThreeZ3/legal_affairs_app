import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///首页推荐事务所列表-Model
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************
class HomeLawyerFirmRequestModel extends BaseRequest {
  @override
  String url() => '/index/firms';
}

class HomeFirmsModel {
  int code;
  List<HomeLawFirmRequestModel> data;
  String msg;

  HomeFirmsModel({
    this.code,
    this.data,
    this.msg,
  });

  HomeFirmsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<HomeLawFirmRequestModel>();
      json['data'].forEach((v) {
        data.add(new HomeLawFirmRequestModel.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  HomeFirmsModel from(Map<String, dynamic> json) =>
      _$HomeLawyerModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

HomeFirmsModel _$HomeLawyerModelFromJson(Map<String, dynamic> json) {
  return HomeFirmsModel(
    code: json['code'],
    data: json['data'].map((item) {
      return new HomeLawFirmRequestModel.fromJson(item);
    }).toList(),
    msg: json['msg'],
  );
}

class HomeLawFirmRequestModel {
  final String city;
  final String district;
  final String firmAvatar;
  final String firmInfo;
  final String firmName;
  final String id;
  final List<NewCategoryModel> legalField;
  final int rank;

  HomeLawFirmRequestModel(
      {this.city,
      this.district,
      this.firmAvatar,
      this.firmInfo,
      this.firmName,
      this.rank,
      this.id,
      this.legalField});

  factory HomeLawFirmRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  HomeLawFirmRequestModel from(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['district'] = this.district;
    data['firmAvatar'] = this.firmAvatar;
    data['firmInfo'] = this.firmInfo;
    data['firmName'] = this.firmName;
    data['rank'] = this.rank;
    data['id'] = this.id;
    return data;
  }
}

HomeLawFirmRequestModel _$DataFromJson(Map<String, dynamic> json) {
  return HomeLawFirmRequestModel(
    city: json['city'],
    district: json['district'],
    firmAvatar: json['firmAvatar'],
    firmInfo: json['firmInfo'],
    firmName: json['firmName'],
    rank: json['rank'],
    id: json['id'],
    legalField: List.from(json['legalField']).map((item) {
      return NewCategoryModel.fromJson(item);
    }).toList(),
  );
}
