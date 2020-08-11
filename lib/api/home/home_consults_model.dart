import 'package:jh_legal_affairs/util/tools.dart';

///首页资讯
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class HomeInformationModel extends BaseRequest {
  final int code;
  final HomeInformationDataModel data;
  final String msg;

  HomeInformationModel({
    this.code,
    this.data,
    this.msg,
  });

  @override
  String url() => '/index/consults';

  factory HomeInformationModel.fromJson(Map<String, dynamic> json) =>
      _$HomeInformationModelFromJson(json);

  HomeInformationModel from(Map<String, dynamic> json) =>
      _$HomeInformationModelFromJson(json);

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

HomeInformationModel _$HomeInformationModelFromJson(Map<String, dynamic> json) {
  return HomeInformationModel(
    code: json['code'],
    data: json['data'] != null
        ? new HomeInformationDataModel.fromJson(json['data'])
        : null,
    msg: json['msg'],
  );
}

class HomeInformationDataModel {
  final String category;
  final int current;
  final String detail;
  final String lawyerId;
  final int pages;
  final List<HomeInformationRecords> records;
  final int size;
  final String title;
  final int total;

  HomeInformationDataModel({
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

  factory HomeInformationDataModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  HomeInformationDataModel from(Map<String, dynamic> json) =>
      _$DataFromJson(json);

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

HomeInformationDataModel _$DataFromJson(Map<String, dynamic> json) {
  return HomeInformationDataModel(
    category: json['category'],
    current: json['current'],
    detail: json['detail'],
    lawyerId: json['lawyerId'],
    pages: json['pages'],
    records: json['records'].map((item) {
      return new HomeInformationRecords.fromJson(item);
    }).toList(),
    size: json['size'],
    title: json['title'],
    total: json['total'],
  );
}

class HomeInformationRecords {
  final String comment;
  final String content;
  final String dislike;
  final String province;
  final String city;
  final String district;
  final String id;
  final String like;
  final String title;
  final String categoryName;
  final String totalAsk;
  final String issuerAvatar;

  HomeInformationRecords({
    this.comment,
    this.content,
    this.dislike,
    this.id,
    this.like,
    this.title,
    this.categoryName,
    this.totalAsk,
    this.city,
    this.district,
    this.province,
    this.issuerAvatar,
  });

  factory HomeInformationRecords.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  HomeInformationRecords from(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['detail'] = this.content;
    data['dislike'] = this.dislike;
    data['city'] = this.city;
    data['district'] = this.district;
    data['province'] = this.province;
    data['id'] = this.id;
    data['like'] = this.like;
    data['title'] = this.title;
    data['categoryName'] = this.categoryName;
    data['totalAsk'] = this.totalAsk;
    return data;
  }
}

HomeInformationRecords _$RecordsFromJson(Map<String, dynamic> json) {
  return HomeInformationRecords(
    comment: json['comment'],
    content: json['content'],
    province: json['province'],
    city: json['city'],
    district: json['district'],
    dislike: json['dislike'],
    id: json['id'],
    like: json['like'],
    title: json['title'],
    categoryName: json['categoryName'],
    totalAsk: json['totalAsk'],
    issuerAvatar: json['issuerAvatar'],
  );
}
