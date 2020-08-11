import 'package:jh_legal_affairs/http/base_request.dart';

/// 竞价案源
class SourceCaseBiddingRequestModel extends BaseRequest {
  final String advantage;
  final String sourceId;
  final int limit;
  final int offer;

  SourceCaseBiddingRequestModel({
    this.advantage,
    this.sourceId,
    this.limit,
    this.offer,
  });

  @override
  String url() => '/source-case-bidding';

  @override
  Map<String, dynamic> toJson() {
    return {
      "advantage": this.advantage,
      "limit": this.limit,
      "offer": this.offer,
      "sourceId": this.sourceId,
    };
  }
}

/// 通过案源id获取竞价列表
class SourceCaseBiddingListRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  SourceCaseBiddingListRequestModel({
    this.id,
    this.page,
    this.limit,
  });

  @override
  String url() => '/source-case-bidding/source-case/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [案源竞价
*
* @param avatar string 头像
* @param city string 所在市
* @param firmName string 律所名
* @param id string 案源竞价id
* @param offer integer($int64) 竞价金额, 以分为单位，如100 = 1.00元
* @param province string 所在省
* @param realName string 真实姓名]
* */
class SourceCaseBidModel {
  final String advantage;
  final String avatar;
  final String city;
  final String firmName;
  final String nickName;
  final String id;
  final List<String> legalField;
  final int offer;
  final int rank;
  final String province;
  final String realName;
  final String userId;

  SourceCaseBidModel({
    this.advantage,
    this.avatar,
    this.city,
    this.firmName,
    this.id,
    this.legalField,
    this.offer,
    this.province,
    this.nickName,
    this.rank,
    this.realName,
    this.userId,
  });

  factory SourceCaseBidModel.fromJson(Map<String, dynamic> json) =>
      _$SourceCaseBidModelFromJson(json);

  SourceCaseBidModel from(Map<String, dynamic> json) =>
      _$SourceCaseBidModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advantage'] = this.advantage;
    data['avatar'] = this.avatar;
    data['city'] = this.city;
    data['firmName'] = this.firmName;
    data['id'] = this.id;
    data['legalField'] = this.legalField;
    data['offer'] = this.offer;
    data['province'] = this.province;
    data['realName'] = this.realName;
    data['userId'] = this.userId;
    data['nickName'] = this.nickName;
    data['rank'] = this.rank;
    return data;
  }
}

SourceCaseBidModel _$SourceCaseBidModelFromJson(Map<String, dynamic> json) {
  return SourceCaseBidModel(
    advantage: json['advantage'],
    rank: int.parse(json['rank'].toString()),
    nickName: json['nickName'],
    avatar: json['avatar'],
    city: json['city'],
    firmName: json['firmName'],
    id: json['id'],
    legalField: json['legalField'].cast<String>(),
    offer: int.parse(json['offer'].toString() ?? '0'),
    province: json['province'],
    realName: json['realName'],
    userId: json['userId'],
  );
}

/// 选用竞价
class SourceCaseBidSelectRequestModel extends BaseRequest {
  final String id;

  SourceCaseBidSelectRequestModel({
    this.id,
  });

  @override
  String url() => '/source-case-bidding/$id';
}

/// ==============任务竞价
///
/// 新增任务竞价
class MissionsBiddingRequestModel extends BaseRequest {
  final String advantage;
  final String missionsId;
  final int limit;
  final int offer;

  MissionsBiddingRequestModel({
    this.advantage,
    this.missionsId,
    this.limit,
    this.offer,
  });

  @override
  String url() => '/missionsBidding';

  @override
  Map<String, dynamic> toJson() {
    return {
      "advantage": this.advantage,
      "limit": this.limit,
      "missionsId": this.missionsId,
      "offer": this.offer,
    };
  }
}

/// 通过案源id获取任务竞价列表
class MissionsBidListRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  MissionsBidListRequestModel({
    this.id,
    this.page,
    this.limit,
  });

  @override
  String url() => '/missionsBidding/missionsBidding-list/$id/$page/$limit';
}

/// 选用竞价-任务
class MissionsBidSelectRequestModel extends BaseRequest {
  final String id;

  MissionsBidSelectRequestModel({
    this.id,
  });

  @override
  String url() => '/missionsBidding/chooseMissionsBidding/$id';
}
