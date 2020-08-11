import 'package:jh_legal_affairs/util/tools.dart';

class HomeNewMissionRequest extends BaseRequest {
  @override
  String url() => '/index/new-mission';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class HomeMissionModel {
  final String ask;
  final String category;
  final String categoryId;
  final String content;
  final dynamic expirationTime;
  final String id;
  final String issuerAvatar;
  final String issuerId;
  final String issuerNickName;
  final int limit;
  final dynamic own;
  final dynamic require;
  final String status;
  final String title;
  final String city;
  final String district;
  final String province;

  HomeMissionModel({
    this.ask,
    this.category,
    this.categoryId,
    this.content,
    this.expirationTime,
    this.id,
    this.issuerAvatar,
    this.issuerId,
    this.issuerNickName,
    this.limit,
    this.own,
    this.require,
    this.status,
    this.title,
    this.city,
    this.district,
    this.province,
  });

  factory HomeMissionModel.fromJson(Map<String, dynamic> json) =>
      _$HomeMissionModelFromJson(json);

  HomeMissionModel from(Map<String, dynamic> json) =>
      _$HomeMissionModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['city'] = this.city;
    data['district'] = this.district;
    data['province'] = this.province;
    return data;
  }
}

HomeMissionModel _$HomeMissionModelFromJson(Map<String, dynamic> json) {
  return HomeMissionModel(
    ask: json['ask'],
    category: json['category'],
    categoryId: json['categoryId'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    id: json['id'],
    issuerAvatar: json['issuerAvatar'],
    issuerId: json['issuerId'],
    issuerNickName: json['issuerNickName'],
    limit: json['limit'],
    own: json['own'],
    require: json['require'],
    status: json['status'],
    title: json['title'],
    city: json['city'],
    district: json['district'],
    province: json['province'],
  );
}

/// 获取律所邀请
class FirmInviteRequest extends BaseRequest {
  @override
  String url() => '/index/firm-invited';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class InviteFirmModel {
  final String firmId;
  final String firmName;
  final String id;
  final String invitedId;
  final String invitedName;
  final String status;
  final String userId;

  InviteFirmModel({
    this.firmId,
    this.firmName,
    this.id,
    this.invitedId,
    this.invitedName,
    this.status,
    this.userId,
  });

  factory InviteFirmModel.fromJson(Map<String, dynamic> json) =>
      _$InviteFirmModelFromJson(json);

  InviteFirmModel from(Map<String, dynamic> json) =>
      _$InviteFirmModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firmId'] = this.firmId;
    data['firmName'] = this.firmName;
    data['id'] = this.id;
    data['invitedId'] = this.invitedId;
    data['invitedName'] = this.invitedName;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }
}

InviteFirmModel _$InviteFirmModelFromJson(Map<String, dynamic> json) {
  return InviteFirmModel(
    firmId: json['firmId'],
    firmName: json['firmName'],
    id: json['id'],
    invitedId: json['invitedId'],
    invitedName: json['invitedName'],
    status: json['status'],
    userId: json['userId'],
  );
}
