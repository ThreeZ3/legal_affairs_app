import 'package:jh_legal_affairs/http/base_request.dart';

class CourseWareRequestModel extends BaseRequest {
  final int limit;
  final int page;

  CourseWareRequestModel({
    this.limit,
    this.page,
  });

  @override
  String url() => '/index/lectures_list/$page/$limit';
}
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class LecturesModel {
  final int code;
  final LecturesDataMdoel data;
  final String msg;

  LecturesModel({
    this.code,
    this.data,
    this.msg,
  });

  factory LecturesModel.fromJson(Map<String, dynamic> json) =>
      _$LecturesModelFromJson(json);

  LecturesModel from(Map<String, dynamic> json) =>
      _$LecturesModelFromJson(json);

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

LecturesModel _$LecturesModelFromJson(Map<String, dynamic> json) {
  return LecturesModel(
    code: json['code'],
    data: json['data'] != null ? new LecturesDataMdoel.fromJson(json['data']) : null,
    msg: json['msg'],
  );
}

class LecturesDataMdoel {
  final int current;
  final int pages;
  final List<HomeLecturesModel> records;
  final bool searchCount;
  final int size;
  final int total;

  LecturesDataMdoel({
    this.current,
    this.pages,
    this.records,
    this.searchCount,
    this.size,
    this.total,
  });

  factory LecturesDataMdoel.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  LecturesDataMdoel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['pages'] = this.pages;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['searchCount'] = this.searchCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

LecturesDataMdoel _$DataFromJson(Map<String, dynamic> json) {
  return LecturesDataMdoel(
    current: json['current'],
    pages: json['pages'],
    records: json['records'].map((item) {
      return new HomeLecturesModel.fromJson(item);
    }).toList(),
    searchCount: json['searchCount'],
    size: json['size'],
    total: json['total'],
  );
}

class HomeLecturesModel {
  final String category;
  final String categoryName;
  final double charges;
  final int isCharge;
  final String createTime;
  final String status;
  final String cover;
  final String lawyerAvatar;
  final String title;
  final String id;
  final String content;

  HomeLecturesModel({
    this.isCharge,
    this.category,
    this.categoryName,
    this.charges,
    this.createTime,
    this.status,
    this.title,
    this.id,
    this.cover,
    this.lawyerAvatar,
    this.content,
  });

  factory HomeLecturesModel.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  HomeLecturesModel from(Map<String, dynamic> json) => _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['charges'] = this.charges;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['title'] = this.title;
    data['id'] = this.id;
    data['lawyerAvatar'] = this.lawyerAvatar;
    data['cover'] = this.cover;
    return data;
  }
}

HomeLecturesModel _$RecordsFromJson(Map<String, dynamic> json) {
  return HomeLecturesModel(
    category: json['category'],
    categoryName: json['categoryName'],
    charges: json['charges'],
    createTime: json['createTime'],
    status: json['status'],
    title: json['title'],
    lawyerAvatar: json['lawyerAvatar'],
    id: json['id'],
    cover: json['cover'],
    content: json['content'],
    isCharge: json['isCharge'],
  );
}
