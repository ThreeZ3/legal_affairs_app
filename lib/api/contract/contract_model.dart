import 'package:jh_legal_affairs/util/tools.dart';

/// 新增律师合同
class ContractAddRequestModel extends BaseRequest {
  final String category;
  final String contractReview;
  final String id;
  final String img;
  final String lawyerId;
  final int price;
  final int textLimit;
  final String title;
  final int videoLimit;
  final int voiceLimit;

  ContractAddRequestModel({
    this.category,
    this.contractReview,
    this.id,
    this.img,
    this.lawyerId,
    this.price,
    this.textLimit,
    this.title,
    this.videoLimit,
    this.voiceLimit,
  });

  @override
  String url() => '/contract';

  @override
  Map<String, dynamic> toJson() {
    return {
      "category": this.category,
      "contractReview": this.contractReview,
      "id": this.id,
      "img": this.img,
      "lawyerId": this.lawyerId,
      "price": this.price,
      "textLimit": this.textLimit,
      "title": this.title,
      "videoLimit": this.videoLimit,
      "voiceLimit": this.voiceLimit,
    };
  }
}

/// 律师合同列表
class ContractsListRequestModel extends BaseRequest {
  final String lawyerId;

  ContractsListRequestModel({
    this.lawyerId,
  });

  @override
  String url() => '/contract/contracts/$lawyerId';
}

/// 通过用户id获取用户购买的合同列表
class ByContractsRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  ByContractsRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/contract/ordered/$page/$limit/$id';
}

/// 通过律所id获取律所顾问合同
class ContractFirmRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  ContractFirmRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/contract/firm/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class ContractFirmModel {
  final String categoryName;
  final int createTime;
  final String id;
  final String img;
  final String lawyerName;
  final String lawyerAvatar;
  final double price;
  final String status;
  final String title;
  bool delCheck;

  ContractFirmModel({
    this.categoryName,
    this.createTime,
    this.lawyerAvatar,
    this.lawyerName,
    this.id,
    this.img,
    this.price,
    this.status,
    this.title,
    this.delCheck = false,
  });

  factory ContractFirmModel.fromJson(Map<String, dynamic> json) =>
      _$ContractFirmModelFromJson(json);

  ContractFirmModel from(Map<String, dynamic> json) =>
      _$ContractFirmModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['img'] = this.img;
    data['price'] = this.price;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

ContractFirmModel _$ContractFirmModelFromJson(Map<String, dynamic> json) {
  return ContractFirmModel(
    categoryName: json['categoryName'],
    lawyerName: json['lawyerName'],
    lawyerAvatar: json['lawyerAvatar'],
    createTime: json['createTime'],
    id: json['id'],
    img: json['img'],
    price: json['price'],
    status: json['status'],
    title: json['title'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [contracts对象
*
* @param description:  合同表
* @param category string 合同类别
* @param contractReview string 合同审查次数
* @param createTime string($date-time) 记录创建时间
* @param deleted integer($int32) 删除标记,0表示没有被删除，1表示主动删除，2表示被动删除
* @param id string
* @param img string 合同配图
* @param lawyerId string 律师id
* @param price number 合同价格
* @param textLimit string 文字时长 单位秒
* @param title string 合同名称
* @param updateTime string($date-time) 记录更新时间
* @param videoLimit string 视频时长 单位秒
* @param voiceLimit string 语音时长 单位秒]
* */
class ContractListModel {
  final String category;
  final String contractReview;
  final String createTime;
  final int deleted;
  final String id;
  final String img;
  final String lawyerId;
  final int price;
  final String textLimit;
  final String title;
  final String updateTime;
  final String videoLimit;
  final String voiceLimit;

  ContractListModel({
    this.category,
    this.contractReview,
    this.createTime,
    this.deleted,
    this.id,
    this.img,
    this.lawyerId,
    this.price,
    this.textLimit,
    this.title,
    this.updateTime,
    this.videoLimit,
    this.voiceLimit,
  });

  factory ContractListModel.fromJson(Map<String, dynamic> json) =>
      _$ContractListModelFromJson(json);

  ContractListModel from(Map<String, dynamic> json) =>
      _$ContractListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['contractReview'] = this.contractReview;
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['id'] = this.id;
    data['img'] = this.img;
    data['lawyerId'] = this.lawyerId;
    data['price'] = this.price;
    data['textLimit'] = this.textLimit;
    data['title'] = this.title;
    data['updateTime'] = this.updateTime;
    data['videoLimit'] = this.videoLimit;
    data['voiceLimit'] = this.voiceLimit;
    return data;
  }
}

ContractListModel _$ContractListModelFromJson(Map<String, dynamic> json) {
  return ContractListModel(
    category: json['category'],
    contractReview: json['contractReview'],
    createTime: json['createTime'],
    deleted: json['deleted'],
    id: json['id'],
    img: json['img'],
    lawyerId: json['lawyerId'],
    price: json['price'],
    textLimit: json['textLimit'],
    title: json['title'],
    updateTime: json['updateTime'],
    videoLimit: json['videoLimit'],
    voiceLimit: json['voiceLimit'],
  );
}

/// 律师合同详情
class ContractsDetailRequestModel extends BaseRequest {
  final String id;

  ContractsDetailRequestModel({
    this.id,
  });

  @override
  String url() => '/contract/$id';
}

///获取当前律师合同列表
class ContractsCurrentListRequestModel extends BaseRequest {
  final int limit;

  final int page;
  final String id;

  ContractsCurrentListRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/contract/$page/$limit/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************
///获取当前律师合同列表 模型
/*
* description:  合同表
* @param categoryName string 合同类别
* @param contractReview string 合同审查次数
* @param id string 合同id
* @param img string 合同配图
* @param price number 合同价格
* @param status ContractsStatusEnum
* ...}
* @param textLimit string 文字时长 单位秒
* @param title string 合同名称
* @param videoLimit string 视频时长 单位秒
* @param voiceLimit string 语音时长 单位秒
* */
class ContractsRecordsData {
  final String categoryName;
  final String id;
  final String img;
  final double price;
  final String status;
  final String title;

  ContractsRecordsData({
    this.categoryName,
    this.id,
    this.img,
    this.price,
    this.status,
    this.title,
  });

  factory ContractsRecordsData.fromJson(Map<String, dynamic> json) =>
      _$ContractsRecordsDataFromJson(json);

  ContractsRecordsData from(Map<String, dynamic> json) =>
      _$ContractsRecordsDataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    data['img'] = this.img;
    data['price'] = this.price;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

ContractsRecordsData _$ContractsRecordsDataFromJson(Map<String, dynamic> json) {
  return ContractsRecordsData(
    categoryName: json['categoryName'],
    id: json['id'],
    img: json['img'],
    price: json['price'],
    status: json['status'],
    title: json['title'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* description:  合同表
* @param categoryName string 合同类别
* @param contractReview string 合同审查次数
* @param id string 合同id
* @param img string 合同配图
* @param price number 合同价格
* @param status ContractsStatusEnum
* ...}
* @param textLimit string 文字时长 单位秒
* @param title string 合同名称
* @param videoLimit string 视频时长 单位秒
* @param voiceLimit string 语音时长 单位秒
* */
class ContractsRecordsDataModel {
  final String categoryName;
  final String lawyerName;
  final String lawyerAvatar;
  final String id;
  final String img;
  final double price;
  final String status;
  final String title;
  final int createTime;
  bool delCheck;

  ContractsRecordsDataModel(
      {this.categoryName,
      this.lawyerName,
      this.lawyerAvatar,
      this.id,
      this.img,
      this.price,
      this.status,
      this.createTime,
      this.title,
      this.delCheck = false});

  factory ContractsRecordsDataModel.fromJson(Map<String, dynamic> json) =>
      _$ContractsRecordsDataModelFromJson(json);

  ContractsRecordsDataModel from(Map<String, dynamic> json) =>
      _$ContractsRecordsDataModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    data['img'] = this.img;
    data['price'] = this.price;
    data['status'] = this.status;
    data['title'] = this.title;
    data['createTime'] = this.createTime;
    return data;
  }
}

ContractsRecordsDataModel _$ContractsRecordsDataModelFromJson(
    Map<String, dynamic> json) {
  return ContractsRecordsDataModel(
    categoryName: json['categoryName'],
    lawyerAvatar: json['lawyerAvatar'],
    lawyerName: json['lawyerName'],
    id: json['id'],
    img: json['img'],
    createTime: json['createTime'],
    price: json['price'],
    status: json['status'],
    title: json['title'],
  );
}
