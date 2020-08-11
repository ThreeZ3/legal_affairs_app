import 'package:jh_legal_affairs/http/base_request.dart';



/// 我的案源-RequestModel
class SourceCasesRequestModel extends BaseRequest {
  /// 请求参数的定义
  final String lawyerId;
  final int status;

  /// 请求参数的构造
  SourceCasesRequestModel({
    this.lawyerId,
    this.status,
  });

  /// 请求的Url，也就是路径
  @override
  String url() => '/source-case/my-cases';

  /// 请求参数json
  @override
  Map<String, dynamic> toJson() {
    return {
      'lawyerId': this.lawyerId,
      'status': this.status,
    };
  }
}

class SourceCasesModel {
  final int code;
  final List<dynamic> data;
  final String msg;

  SourceCasesModel({
    this.code,
    this.data,
    this.msg,
  });

  factory SourceCasesModel.fromJson(Map<String, dynamic> json) =>
      _$SourceCasesModelFromJson(json);

  SourceCasesModel from(Map<String, dynamic> json) => _$SourceCasesModelFromJson(json);

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

SourceCasesModel _$SourceCasesModelFromJson(Map<String, dynamic> json) {
  return SourceCasesModel(
    code: json['code'],
    data: json['data'].map((item) {
      return new DataModel.fromJson(item);
    }).toList(),
    msg: json['msg'],
  );
}

class DataModel{
  final String category;
  final String content;
  final int createTime;
  final int deleted;
  final int fee;
  final String id;
  final String lawyerId;
  final int limited;
  final String requirement;
  final int status;
  final String title;
  final String underTakes;
  final int updateTime;
  final int value;

  DataModel({
    this.category,
    this.content,
    this.createTime,
    this.deleted,
    this.fee,
    this.id,
    this.lawyerId,
    this.limited,
    this.requirement,
    this.status,
    this.title,
    this.underTakes,
    this.updateTime,
    this.value,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  DataModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['fee'] = this.fee;
    data['id'] = this.id;
    data['lawyerId'] = this.lawyerId;
    data['limited'] = this.limited;
    data['requirement'] = this.requirement;
    data['status'] = this.status;
    data['title'] = this.title;
    data['underTakes'] = this.underTakes;
    data['updateTime'] = this.updateTime;
    data['value'] = this.value;
    return data;
  }
}

DataModel _$DataFromJson(Map<String, dynamic> json) {
  return DataModel(
    category: json['category'],
    content: json['content'],
    createTime: json['createTime'],
    deleted: json['deleted'],
    fee: json['fee'],
    id: json['id'],
    lawyerId: json['lawyerId'],
    limited: json['limited'],
    requirement: json['requirement'],
    status: json['status'],
    title: json['title'],
    underTakes: json['underTakes'],
    updateTime: json['updateTime'],
    value: json['value'],
  );
}

