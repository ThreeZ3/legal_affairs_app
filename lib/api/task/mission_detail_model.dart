import 'package:jh_legal_affairs/http/base_request.dart';

/// 任务详情
class MissionDetailRequestModel extends BaseRequest {
  final String id;

  MissionDetailRequestModel(this.id);

  @override
  String url() => '/mission/detail/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* ask string 要价
* @param category string 业务类别
* @param categoryId string 业务类别Id
* @param categoryName string 业务类别
* @param content string 简介
* @param expirationTime string($date-time) 过期时间
* @param id string 任务id
* @param limit integer($int32) 时限
* @param own boolean 是否自己发布的
* @param require integer($int32) 要求
* @param status MissionsStatusEnum
* ...}
* @param title string 标题
* @param underTakes string 承接人；lawyer表id
* @param underTakesName string 承接人名称
* */
class MissionDetailModel {
  final String ask;
  final String category;
  final String categoryId;
  final String categoryName;
  final String content;
  final String city;
  final String province;
  final String district;
  final String expirationTime;
  final String id;
  final int limit;
  final bool own;
  final String require;
  final String status;
  final String title;
  final String underTakes;
  final String underTakesName;
  final String issuerNickName;
  final String issuerId;

  MissionDetailModel({
    this.issuerId,
    this.ask,
    this.category,
    this.city,
    this.province,
    this.district,
    this.categoryId,
    this.categoryName,
    this.content,
    this.expirationTime,
    this.id,
    this.limit,
    this.own,
    this.require,
    this.status,
    this.title,
    this.underTakes,
    this.underTakesName,
    this.issuerNickName,
  });

  factory MissionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MissionDetailModelFromJson(json);

  MissionDetailModel from(Map<String, dynamic> json) =>
      _$MissionDetailModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['issuerId'] = this.issuerId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['id'] = this.id;
    data['limit'] = this.limit;
    data['own'] = this.own;
    data['city'] = this.city;
    data['province'] = this.province;
    data['district'] = this.district;
    data['require'] = this.require;
    data['status'] = this.status;
    data['title'] = this.title;
    data['underTakes'] = this.underTakes;
    data['underTakesName'] = this.underTakesName;
    data['issuerNickName'] = this.issuerNickName;
    return data;
  }
}

MissionDetailModel _$MissionDetailModelFromJson(Map<String, dynamic> json) {
  return MissionDetailModel(
    ask: json['ask'],
    city: json['city'],
    province: json['province'],
    issuerId: json['issuerId'],
    district: json['district'],
    category: json['category'],
    categoryId: json['categoryId'],
    categoryName: json['categoryName'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    id: json['id'],
    limit: json['limit'],
    own: json['own'],
    require: json['require'],
    status: json['status'],
    title: json['title'],
    underTakes: json['underTakes'],
    underTakesName: json['underTakesName'],
    issuerNickName: json['issuerNickName'],
  );
}

/// 发布者确认完成
class MissionPublishConfirmModel extends BaseRequest {
  final String id;

  MissionPublishConfirmModel({
    this.id,
  });

  @override
  String url() => '/mission/confirm/$id';
}

/// 承接者确认完成
class MissionCompletedModel extends BaseRequest {
  final String id;

  MissionCompletedModel({
    this.id,
  });

  @override
  String url() => '/mission/completed/$id';
}