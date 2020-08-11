import 'package:jh_legal_affairs/http/base_request.dart';

class FirmListRequestModel extends BaseRequest {
  @override
  String url() => '/firm/list';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* Firm对象
*
* @param description:  首页事务所推荐列表
* @param city string 事务所所属城市
* @param district string 事务所所属区
* @param firmAvatar string 事务所图标
* @param firmInfo string 事务所简介
* @param firmName string 事务所名称
* @param rank integer($int32) 排名：可为空，运营字段]
* */
class FirmListModel {
  final String city;
  final String district;
  final String firmAvatar;
  final String firmInfo;
  final String firmName;
  final int rank;

  FirmListModel({
    this.city,
    this.district,
    this.firmAvatar,
    this.firmInfo,
    this.firmName,
    this.rank,
  });

  factory FirmListModel.fromJson(Map<String, dynamic> json) =>
      _$FirmListModelFromJson(json);

  FirmListModel from(Map<String, dynamic> json) =>
      _$FirmListModelFromJson(json);

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

FirmListModel _$FirmListModelFromJson(Map<String, dynamic> json) {
  return FirmListModel(
    city: json['city'],
    district: json['district'],
    firmAvatar: json['firmAvatar'],
    firmInfo: json['firmInfo'],
    firmName: json['firmName'],
    rank: json['rank'],
  );
}
