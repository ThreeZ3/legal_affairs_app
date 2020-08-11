import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/http/base_request.dart';

/// 分页搜索获取律所列表
class FirmListRequestModel extends BaseRequest {
  final int page;
  final int limit;
  final String name;
  final String typeId;
  final String lat;
  final String lng;
  final String city;
  final String district;
  final String province;

  // 排序类型:1.人气,2.距离
  final int orderType;
  final int maxRank;
  final int maxRange;

  FirmListRequestModel({
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
  String url() => '/firm/list/search';

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
* Firm对象
*
* description:  首页事务所推荐列表
* @param city string 事务所所属城市
* @param district string 事务所所属区
* @param firmAvatar string 事务所图标
* @param firmInfo string 事务所简介
* @param firmName string 事务所名称
* @param rank integer($int32) 排名：可为空，运营字段
* */

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class FirmListModel {
  final String district;
  final String firmAvatar;
  final String firmName;
  final String id;
  final int lawyers;
  final List<NewCategoryModel> legalField;
  final int rank;
  final String town;
  final dynamic range;

  FirmListModel({
    this.district,
    this.firmAvatar,
    this.firmName,
    this.id,
    this.lawyers,
    this.legalField,
    this.rank,
    this.town,
    this.range,
  });

  factory FirmListModel.fromJson(Map<String, dynamic> json) =>
      _$FirmListModelFromJson(json);

  FirmListModel from(Map<String, dynamic> json) =>
      _$FirmListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['firmAvatar'] = this.firmAvatar;
    data['firmName'] = this.firmName;
    data['id'] = this.id;
    data['lawyers'] = this.lawyers;
    data['rank'] = this.rank;
    data['town'] = this.town;
    data['range'] = this.range;
    return data;
  }
}

FirmListModel _$FirmListModelFromJson(Map<String, dynamic> json) {
  return FirmListModel(
    district: json['district'],
    firmAvatar: json['firmAvatar'],
    firmName: json['firmName'],
    id: json['id'],
    lawyers: json['lawyers'],
    legalField: List.from(json['legalField']).map((item) {
      return NewCategoryModel.fromJson(item);
    }).toList(),
    rank: json['rank'],
    town: json['town'],
    range: json['range'],
  );
}
