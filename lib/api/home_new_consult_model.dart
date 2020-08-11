import 'package:jh_legal_affairs/http/base_request.dart';

class GetNewRequestModel extends BaseRequest {
  @override
  String url() => '/index/new-consult';
}

///分页获取所有咨询
class GetAllNewRequestModel extends BaseRequest {
  final int page;
  final int limit;

  GetAllNewRequestModel({
    this.page,
    this.limit,
  });

  @override
  String url() => '/consult/publishingPage/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class ConsultAllModel {
  final String province;
  final String city;
  final String district;
  final String category;
  final String categoryId;
  final String content;
  final int createTime;
  final dynamic expirationTime;
  final String id;
  final int limit;
  final bool own;
  final String status;
  final String title;
  final String totalAsk;

  ConsultAllModel({
    this.province,
    this.city,
    this.createTime,
    this.district,
    this.category,
    this.categoryId,
    this.content,
    this.expirationTime,
    this.id,
    this.limit,
    this.own,
    this.status,
    this.title,
    this.totalAsk,
  });

  factory ConsultAllModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultAllModelFromJson(json);

  ConsultAllModel from(Map<String, dynamic> json) =>
      _$ConsultAllModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['id'] = this.id;
    data['limit'] = this.limit;
    data['own'] = this.own;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['title'] = this.title;
    data['totalAsk'] = this.totalAsk;
    return data;
  }
}

ConsultAllModel _$ConsultAllModelFromJson(Map<String, dynamic> json) {
  return ConsultAllModel(
    province: json['province'],
    city: json['city'],
    district: json['district'],
    category: json['category'],
    createTime: json['createTime'],
    categoryId: json['categoryId'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    id: json['id'],
    limit: json['limit'],
    own: json['own'],
    status: json['status'],
    title: json['title'],
    totalAsk: json['totalAsk'],
  );
}


///最新资讯
class GetNewsModel extends BaseRequest {
  final int code;
  final GetNewsDataModel data;
  final String msg;

  GetNewsModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetNewsModel.fromJson(Map<String, dynamic> json) =>
      _$GetNewsModelFromJson(json);

  GetNewsModel from(Map<String, dynamic> json) => _$GetNewsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

GetNewsModel _$GetNewsModelFromJson(Map<String, dynamic> json) {
  return GetNewsModel(
    code: json['code'],
    data: json['data'] != null
        ? new GetNewsDataModel.fromJson(json['data'])
        : null,
    msg: json['msg'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [#/definitions/最新资讯最新资讯
*
* @param detail string 图文详情
* @param title string 标题]
* */
class NewConsultModel {
  final String detail;
  final String title;

  NewConsultModel({
    this.detail,
    this.title,
  });

  factory NewConsultModel.fromJson(Map<String, dynamic> json) =>
      _$NewConsultModelFromJson(json);

  NewConsultModel from(Map<String, dynamic> json) =>
      _$NewConsultModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['title'] = this.title;
    return data;
  }
}

NewConsultModel _$NewConsultModelFromJson(Map<String, dynamic> json) {
  return NewConsultModel(
    detail: json['detail'],
    title: json['title'],
  );
}

class GetNewsDataModel {
  final Null category;
  final int current;
  final Null detail;
  final Null lawyerId;
  final int pages;
  final List<GetNewsDataRecordsModel> records;
  final int size;
  final Null title;
  final int total;

  GetNewsDataModel({
    this.category,
    this.current,
    this.detail,
    this.lawyerId,
    this.pages,
    this.records,
    this.size,
    this.title,
    this.total,
  });

  factory GetNewsDataModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  GetNewsDataModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['current'] = this.current;
    data['detail'] = this.detail;
    data['lawyerId'] = this.lawyerId;
    data['pages'] = this.pages;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['title'] = this.title;
    data['total'] = this.total;
    return data;
  }
}

GetNewsDataModel _$DataFromJson(Map<String, dynamic> json) {
  return GetNewsDataModel(
    category: json['category'],
    current: json['current'],
    detail: json['detail'],
    lawyerId: json['lawyerId'],
    pages: json['pages'],
    records: json['records'].map((item) {
      return new GetNewsDataRecordsModel.fromJson(item);
    }).toList(),
    size: json['size'],
    title: json['title'],
    total: json['total'],
  );
}

class GetNewsDataRecordsModel extends BaseRequest {
  @override
  String url() => '/index/new-consult';
  final String detail;
  final String title;

  GetNewsDataRecordsModel({
    this.detail,
    this.title,
  });

  factory GetNewsDataRecordsModel.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  GetNewsDataRecordsModel from(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['title'] = this.title;
    return data;
  }
}

GetNewsDataRecordsModel _$RecordsFromJson(Map<String, dynamic> json) {
  return GetNewsDataRecordsModel(
    detail: json['detail'],
    title: json['title'],
  );
}
