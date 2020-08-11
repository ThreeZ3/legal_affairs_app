import 'package:jh_legal_affairs/util/tools.dart';

/// ad/incomes/{id}/{page}/{limit} 根据用户ID查询广告收入列表 (Get)

class AdIncomesRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  AdIncomesRequestModel({this.id, this.page, this.limit});

  @override
  String url() => '/ad/incomes/$id/$page/$limit';
}

/*
* avatar string 头像
* @param bidPrice string 用户报价
* @param city string 市
* @param district string 区
* @param province string 省
* @param realName string
* */
class AdIncomesModel {
  final String avatar;
  final String bidPrice;
  final String city;
  final String district;
  final String province;
  final String realName;

  AdIncomesModel({
    this.avatar,
    this.bidPrice,
    this.city,
    this.district,
    this.province,
    this.realName,
  });

  factory AdIncomesModel.fromJson(Map<String, dynamic> json) =>
      _$AdIncomesModelFromJson(json);

  AdIncomesModel from(Map<String, dynamic> json) =>
      _$AdIncomesModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['bidPrice'] = this.bidPrice;
    data['city'] = this.city;
    data['district'] = this.district;
    data['province'] = this.province;
    data['realName'] = this.realName;
    return data;
  }
}

AdIncomesModel _$AdIncomesModelFromJson(Map<String, dynamic> json) {
  return AdIncomesModel(
    avatar: json['avatar'],
    bidPrice: json['bidPrice'],
    city: json['city'],
    district: json['district'],
    province: json['province'],
    realName: json['realName'],
  );
}

/// ad/sys-ad-bid/bidding 广告位竞价 (Post)

/*
* bidPrice string
* @param example: 2000 用户报价
* @param contentUrl string
* @param example: ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png 广告内容url
* @param day integer($int32)
* @param example: 5 竞价天数
* @param id string
* @param id
* @param sysAdId string
* @param example: ec25293c814611eab5ed00163e02fs21 系统推送位置id
* */
class AdSysBiddingRequestModel extends BaseRequest {
  final String bidPrice;
  final String contentUrl;
  final int day;
  final String id;
  final String sysAdId;

  AdSysBiddingRequestModel({
    this.bidPrice,
    this.contentUrl,
    this.day,
    this.id,
    this.sysAdId,
  });

  @override
  String url() => '/ad/sys-ad-bid/bidding';

  factory AdSysBiddingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AdSysBiddingRequestModelFromJson(json);

  AdSysBiddingRequestModel from(Map<String, dynamic> json) =>
      _$AdSysBiddingRequestModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bidPrice'] = this.bidPrice;
    data['contentUrl'] = this.contentUrl;
    data['day'] = this.day;
    data['id'] = this.id;
    data['sysAdId'] = this.sysAdId;
    return data;
  }
}

AdSysBiddingRequestModel _$AdSysBiddingRequestModelFromJson(
    Map<String, dynamic> json) {
  return AdSysBiddingRequestModel(
    bidPrice: json['bidPrice'],
    contentUrl: json['contentUrl'],
    day: json['day'],
    id: json['id'],
    sysAdId: json['sysAdId'],
  );
}

///ad/bulk-Missions/{ids} 删除广告（Del）

class DeleteAdRequestModel extends BaseRequest {
  final String ids;

  DeleteAdRequestModel(this.ids);

  @override
  String url() => '/ad/bulk-Missions/$ids';
}

/// ad/sys-ad-bid/click/{id} 浏览广告 (Put)

class AdSysClickRequestModel extends BaseRequest {
  final String id;

  AdSysClickRequestModel(this.id);

  @override
  String url() => '/ad/sys-ad-bid/click/$id';
}

/// ad/sys-ad-bid/{id}/{page}/{limit} 获取我的广告 (Get)

class AdSysBidRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  AdSysBidRequestModel(this.id, this.page, this.limit);

  @override
  String url() => '/ad/sys-ad-bid/$id/$page/$limit';
}

/*
* bidPrice string 用户报价
* @param clickCount integer($int32) 查看次数
* @param contentUrl string 广告内容url
* @param day integer($int32) 竞价天数
* @param endTime string($date-time) 推送结束时间
* @param id string
* @param position AdPositionEnum
*
* @param code integer($int32)
* @param descp string
* @param startTime string($date-time) 推送开始时间
* @param status AdBidStatusEnum
*
* @param code integer($int32)
* @param descp string
* @param urls string 跳转地址
* @param userId string 用户id
* */
class AdSysBidModel {
  final String bidPrice;
  final int clickCount;
  final String contentUrl;
  final int day;
  final int endTime;
  final String id;
  final String position;
  final int startTime;
  final String status;
  final String urls;
  final String userId;
  bool delCheck;

  AdSysBidModel({
    this.bidPrice,
    this.clickCount,
    this.contentUrl,
    this.day,
    this.endTime,
    this.id,
    this.position,
    this.startTime,
    this.status,
    this.urls,
    this.userId,
    this.delCheck = false,
  });

  factory AdSysBidModel.fromJson(Map<String, dynamic> json) =>
      _$AdSysBidModelFromJson(json);

  AdSysBidModel from(Map<String, dynamic> json) =>
      _$AdSysBidModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bidPrice'] = this.bidPrice;
    data['clickCount'] = this.clickCount;
    data['contentUrl'] = this.contentUrl;
    data['day'] = this.day;
    data['endTime'] = this.endTime;
    data['id'] = this.id;
    data['position'] = this.position;
    data['startTime'] = this.startTime;
    data['status'] = this.status;
    data['urls'] = this.urls;
    data['userId'] = this.userId;
    return data;
  }
}

AdSysBidModel _$AdSysBidModelFromJson(Map<String, dynamic> json) {
  return AdSysBidModel(
    bidPrice: json['bidPrice'],
    clickCount: json['clickCount'],
    contentUrl: json['contentUrl'],
    day: json['day'],
    endTime: json['endTime'],
    id: json['id'],
    position: json['position'],
    startTime: json['startTime'],
    status: json['status'],
    urls: json['urls'],
    userId: json['userId'],
  );
}

/// ad/sys-ad/all 获取所有推送位置信息 (Get)
class AdSysAllRequestModel extends BaseRequest {
  @override
  String url() => '/ad/sys-ad/all';
}

/*
* endTime string($date-time) 当前位置的推送开始日期
* @param id string
* @param maxPrice string 当前竞价的最高价格
* @param minPrice string 当前竞价的最低价格
* @param name string 竞价展示推送位置
* @param num string 当前竞价总人数
* @param price string 价格标准
* @param startTime string($date-time) 当前位置的推送开始日期
* */
class AdSysAllModel {
  final int endTime;
  final String id;
  final String maxPrice;
  final String minPrice;
  final String name;
  final String num;
  final String price;
  final int startTime;

  AdSysAllModel({
    this.endTime,
    this.id,
    this.maxPrice,
    this.minPrice,
    this.name,
    this.num,
    this.price,
    this.startTime,
  });

  factory AdSysAllModel.fromJson(Map<String, dynamic> json) =>
      _$AdSysAllModelFromJson(json);

  AdSysAllModel from(Map<String, dynamic> json) =>
      _$AdSysAllModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endTime'] = this.endTime;
    data['id'] = this.id;
    data['maxPrice'] = this.maxPrice;
    data['minPrice'] = this.minPrice;
    data['name'] = this.name;
    data['num'] = this.num;
    data['price'] = this.price;
    data['startTime'] = this.startTime;
    return data;
  }
}

AdSysAllModel _$AdSysAllModelFromJson(Map<String, dynamic> json) {
  return AdSysAllModel(
    endTime: json['endTime'],
    id: json['id'],
    maxPrice: json['maxPrice'],
    minPrice: json['minPrice'],
    name: json['name'],
    num: json['num'],
    price: json['price'],
    startTime: json['startTime'],
  );
}

/// ad/sys-ad/{type} 根据推送位置获取广告列表 （Get）
class AdSysRequestModel extends BaseRequest {
  final int type;

  AdSysRequestModel(this.type);

  @override
  String url() => '/ad/sys-ad/$type';
}

/*
* type *
* @param integer($int32)
(path)  位置：1.首页,2.律所,3.律师,4.业务
* */
class AdSysModel {
  final String contentUrl;
  final String id;
  final String sort;
  final String urls;
  final bool isVideo;

  AdSysModel({
    this.contentUrl,
    this.id = '0',
    this.sort = '0',
    this.urls = 'http://exmaple.com/',
    this.isVideo = false,
  });

  factory AdSysModel.fromJson(Map<String, dynamic> json) =>
      _$AdSysModelFromJson(json);

  AdSysModel from(Map<String, dynamic> json) => _$AdSysModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentUrl'] = this.contentUrl;
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['urls'] = this.urls;
    return data;
  }
}

AdSysModel _$AdSysModelFromJson(Map<String, dynamic> json) {
  return AdSysModel(
    contentUrl: json['contentUrl'],
    id: json['id'],
    sort: json['sort'],
    urls: json['urls'],
  );
}

/// ad/{id}查询广告详情信息 (Get)
class AdDetailRequestModel extends BaseRequest {
  final String id;

  AdDetailRequestModel(this.id);

  @override
  String url() => '/ad/$id';
}

/*
* bidPrice string 用户报价
* @param clickCount integer($int32) 查看次数
* @param contentUrl string 广告内容url
* @param day integer($int32) 竞价天数
* @param endTime string($date-time) 推送结束时间
* @param position string 推送位置
* @param startTime string($date-time) 推送开始时间
* @param status AdBidStatusEnum
*
* @param code integer($int32)
* @param descp string
* @param sysAdId string 系统类型设置表
* @param urls string 跳转地址
* */
class AdDetailsModel {
  final String bidPrice;
  final int clickCount;
  final String contentUrl;
  final int day;
  final int endTime;
  final String position;
  final int startTime;
  final String status;
  final String sysAdId;
  final String urls;

  AdDetailsModel({
    this.bidPrice,
    this.clickCount,
    this.contentUrl,
    this.day,
    this.endTime,
    this.position,
    this.startTime,
    this.status,
    this.sysAdId,
    this.urls,
  });

  factory AdDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AdDetailsModelFromJson(json);

  AdDetailsModel from(Map<String, dynamic> json) =>
      _$AdDetailsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bidPrice'] = this.bidPrice;
    data['clickCount'] = this.clickCount;
    data['contentUrl'] = this.contentUrl;
    data['day'] = this.day;
    data['endTime'] = this.endTime;
    data['position'] = this.position;
    data['startTime'] = this.startTime;
    data['status'] = this.status;
    data['sysAdId'] = this.sysAdId;
    data['urls'] = this.urls;
    return data;
  }
}

AdDetailsModel _$AdDetailsModelFromJson(Map<String, dynamic> json) {
  return AdDetailsModel(
    bidPrice: json['bidPrice'],
    clickCount: json['clickCount'],
    contentUrl: json['contentUrl'],
    day: json['day'],
    endTime: json['endTime'],
    position: json['position'],
    startTime: json['startTime'],
    status: json['status'],
    sysAdId: json['sysAdId'],
    urls: json['urls'],
  );
}
