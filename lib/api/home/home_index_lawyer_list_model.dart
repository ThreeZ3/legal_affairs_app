import 'package:jh_legal_affairs/util/tools.dart';

///首页律师推荐列表

class HomeLawyerRequestModel extends BaseRequest {
    @override
  String url() {
    // TODO: implement url
    return super.url();
  }
}
  /// **************************************************************************
  /// 来自金慧科技Json转Dart工具
  /// **************************************************************************

  class HomeLawyersModel {
  final int code;
  final List<HomeLawyerDataModel> data;
  final String msg;

  HomeLawyersModel({
  this.code,
  this.data,
  this.msg,
  });

  factory HomeLawyersModel.fromJson(Map<String, dynamic> json) =>
  _$HomeLawyerModelFromJson(json);

  HomeLawyersModel from(Map<String, dynamic> json) =>
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

HomeLawyersModel _$HomeLawyerModelFromJson(Map<String, dynamic> json) {
  return HomeLawyersModel(
  code: json['code'],
  data: json['data'].map((item) {
  return new HomeLawyerDataModel.fromJson(item);
  }).toList(),
  msg: json['msg'],
  );
  }

  class HomeLawyerDataModel {
  final String city;
  final String district;
  final Null firmAvatar;
  final String firmInfo;
  final String firmName;
  final int rank;

  HomeLawyerDataModel({
  this.city,
  this.district,
  this.firmAvatar,
  this.firmInfo,
  this.firmName,
  this.rank,
  });

  factory HomeLawyerDataModel.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  HomeLawyerDataModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['city'] = this.city;
  data['district'] = this.district;
  data['firmAvatar'] = this.firmAvatar;
  data['firmInfo'] = this.firmInfo;
  data['firmName'] = this.firmName;
  data['rank'] = this.rank;
  return data;
  }
  }

HomeLawyerDataModel _$DataFromJson(Map<String, dynamic> json) {
  return HomeLawyerDataModel(
  city: json['city'],
  district: json['district'],
  firmAvatar: json['firmAvatar'],
  firmInfo: json['firmInfo'],
  firmName: json['firmName'],
  rank: json['rank'],
  );
  }
