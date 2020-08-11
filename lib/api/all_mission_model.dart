import 'package:jh_legal_affairs/http/base_request.dart';

/// 用户全部任务-RequestModel  当前用户全部任务列表
class AllMissionRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  AllMissionRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/mission/missions/$page/$limit/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [MissionsVO数据信息
*
* @param ask string 要价
* @param category string 业务类别
* @param categoryId string 业务类别Id
* @param categoryName string 业务类别
* @param content string 简介
* @param expirationTime string($date-time) 过期时间
* @param id string 任务id
* @param issuerAvatar string 发布者头像
* @param issuerId string 发布者id
* @param issuerNickName string 发布者名称
* @param limit integer($int32) 时限
* @param own boolean 是否自己发布的
* @param require integer($int32) 要求
* @param status MissionsStatusEnum
*
* @param code integer($int32)
* @param descp string
* @param title string 标题
* @param underTakes string 承接人；lawyer表id
* @param underTakesName string 承接人名称]
* */
class MissionRecords {
  final String ask;
  final String category;
  final String categoryId;
  final String province;
  final String city;
  final String district;
  final String content;
  final dynamic expirationTime;
  final dynamic createTime;
  final String id;
  final String issuerAvatar;
  final String issuerId;
  final String issuerNickName;
  final int limit;
  final bool own;
  final dynamic require;
  final String status;
  final String title;
  bool delCheck;

  MissionRecords(
      {this.province,
      this.city,
      this.district,
      this.ask,
      this.category,
      this.categoryId,
      this.content,
      this.expirationTime,
      this.createTime,
      this.id,
      this.issuerAvatar,
      this.issuerId,
      this.issuerNickName,
      this.limit,
      this.own,
      this.require,
      this.status,
      this.title,
      this.delCheck = false});

  factory MissionRecords.fromJson(Map<String, dynamic> json) =>
      _$MissionRecordsFromJson(json);

  MissionRecords from(Map<String, dynamic> json) =>
      _$MissionRecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['ask'] = this.ask;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['id'] = this.id;
    data['issuerAvatar'] = this.issuerAvatar;
    data['issuerId'] = this.issuerId;
    data['issuerNickName'] = this.issuerNickName;
    data['limit'] = this.limit;
    data['own'] = this.own;
    data['require'] = this.require;
    data['status'] = this.status;
    data['title'] = this.title;
    data['createTime'] = this.createTime;
    return data;
  }
}

MissionRecords _$MissionRecordsFromJson(Map<String, dynamic> json) {
  return MissionRecords(
    province: json['province'],
    city: json['city'],
    district: json['district'],
    ask: json['ask'],
    category: json['category'],
    categoryId: json['categoryId'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    createTime: json['createTime'],
    id: json['id'],
    issuerAvatar: json['issuerAvatar'],
    issuerId: json['issuerId'],
    issuerNickName: json['issuerNickName'],
    limit: json['limit'],
    own: json['own'],
    require: json['require'],
    status: json['status'],
    title: json['title'],
  );
}

class AllMissionModel {
  final int code;
  final List<dynamic> data;
  final String msg;

  AllMissionModel({
    this.code,
    this.data,
    this.msg,
  });

  factory AllMissionModel.fromJson(Map<String, dynamic> json) =>
      _$AllMissionModelFromJson(json);

  AllMissionModel from(Map<String, dynamic> json) =>
      _$AllMissionModelFromJson(json);

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

AllMissionModel _$AllMissionModelFromJson(Map<String, dynamic> json) {
  return AllMissionModel(
    code: json['code'],
    data: json['data'].map((item) {
      return new DataModel.fromJson(item);
    }).toList(),
    msg: json['msg'],
  );
}

class DataModel {
  final String ask;
  final String category;
  final String content;
  final int createTime;
  final int deleted;
  final String id;
  final String lawyerId;
  final int limit;
  final String require;
  final String underTakes;
  final int updateTime;

  DataModel({
    this.ask,
    this.category,
    this.content,
    this.createTime,
    this.deleted,
    this.id,
    this.lawyerId,
    this.limit,
    this.require,
    this.underTakes,
    this.updateTime,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  DataModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['category'] = this.category;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['id'] = this.id;
    data['lawyerId'] = this.lawyerId;
    data['limit'] = this.limit;
    data['require'] = this.require;
    data['underTakes'] = this.underTakes;
    data['updateTime'] = this.updateTime;
    return data;
  }
}

DataModel _$DataFromJson(Map<String, dynamic> json) {
  return DataModel(
    ask: json['ask'],
    category: json['category'],
    content: json['content'],
    createTime: json['createTime'],
    deleted: json['deleted'],
    id: json['id'],
    lawyerId: json['lawyerId'],
    limit: json['limit'],
    require: json['require'],
    underTakes: json['underTakes'],
    updateTime: json['updateTime'],
  );
}
