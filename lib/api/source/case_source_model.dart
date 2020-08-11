import 'package:jh_legal_affairs/util/tools.dart';

/// 获取案源详细
class SourceCaseDetailRequestModel extends BaseRequest {
  final String sourceCaseId;

  SourceCaseDetailRequestModel({
    this.sourceCaseId,
  });

  @override
  String url() => '/source-case';

  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceCaseId': this.sourceCaseId,
    };
  }
}

///案源删除
class SourceCaseDelRequestModel extends BaseRequest {
  final String id;

  SourceCaseDelRequestModel({
    this.id,
  });

  @override
  String url() => '/source-case/$id';
}

/*
* SourceCaseDTO 分页获取我的案源
*
* @param limit integer($int32) 条数
* @param page integer($int32) 页数（1开始）
* @param type integer($int32) 类型(0.我的全部，1.我发布的，2.我承接的)
* */
class SourceCaseMyRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final int type;
  final String id;

  SourceCaseMyRequestModel({
    this.limit,
    this.page,
    this.type,
    this.id,
  });

  @override
  String url() => '/source-case/my-cases/$type/$page/$limit/$id';
}

/// 获取案源详细
class SourceCaseDetailsRequestModel extends BaseRequest {
  final String id;

  SourceCaseDetailsRequestModel({
    this.id,
  });

  @override
  String url() => '/source-case/detail/$id';
}

/// 承接案源
class SourceCaseUndertakeRequestModel extends BaseRequest {
  final String id;

  SourceCaseUndertakeRequestModel({
    this.id,
  });

  @override
  String url() => '/source-case/undertake/$id';
}

/// 发布者确认完成
class SourceCasePublishConfirmModel extends BaseRequest {
  final String id;

  SourceCasePublishConfirmModel({
    this.id,
  });

  @override
  String url() => '/source-case/confirm/$id';
}

/// 承接确认完成
class SourceCaseCompletedModel extends BaseRequest {
  final String id;

  SourceCaseCompletedModel({
    this.id,
  });

  @override
  String url() => '/source-case/completed/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class SourceCaseDetails {
  final String category;
  final dynamic categoryName;
  final String content;
  final dynamic fee;
  final String id;
  final String lawyerId;
  final dynamic limited;
  final String nickName;
  final dynamic requirement;
  final String status;
  final String title;
  final dynamic underTakes;
  final int value;

  SourceCaseDetails({
    this.category,
    this.categoryName,
    this.content,
    this.fee,
    this.id,
    this.lawyerId,
    this.limited,
    this.nickName,
    this.requirement,
    this.status,
    this.title,
    this.underTakes,
    this.value,
  });

  factory SourceCaseDetails.fromJson(Map<String, dynamic> json) =>
      _$SourceCaseDetailsFromJson(json);

  SourceCaseDetails from(Map<String, dynamic> json) =>
      _$SourceCaseDetailsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['content'] = this.content;
    data['fee'] = this.fee;
    data['id'] = this.id;
    data['lawyerId'] = this.lawyerId;
    data['limited'] = this.limited;
    data['nickName'] = this.nickName;
    data['requirement'] = this.requirement;
    data['status'] = this.status;
    data['title'] = this.title;
    data['underTakes'] = this.underTakes;
    data['value'] = this.value;
    return data;
  }
}

SourceCaseDetails _$SourceCaseDetailsFromJson(Map<String, dynamic> json) {
  return SourceCaseDetails(
    category: json['category'],
    categoryName: json['categoryName'],
    content: json['content'],
    fee: json['fee'],
    id: json['id'],
    lawyerId: json['lawyerId'],
    limited: json['limited'],
    nickName: json['nickName'],
    requirement: json['requirement'],
    status: json['status'],
    title: json['title'],
    underTakes: json['underTakes'],
    value: json['value'],
  );
}

/// 律所获取案源共享
class SourceCaseShareRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  SourceCaseShareRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/source-case/source-case/$id/$page/$limit';
}

/// 发布案源
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 案源数据相关信息
*
* @param category string 类别
* @param content string 案由
* @param fee number 律师费
* @param limited string($date-time) 时限
* @param requirement string 要求
* @param title string 标题
* @param value number 案值
* */
class SourceCaseReleaseRequestModel extends BaseRequest {
  final String category;
  final String content;
  final double fee;
  final int limited;
  final String requirement;
  final String title;
  final double value;

  SourceCaseReleaseRequestModel({
    this.category,
    this.content,
    this.fee,
    this.limited,
    this.requirement,
    this.title,
    this.value,
  });

  @override
  String url() => '/source-case';

  @override
  Map<String, dynamic> toJson() {
    return {
      "category": this.category,
      "content": this.content,
      "fee": this.fee,
      "limited": this.limited,
      "requirement": this.requirement,
      "title": this.title,
      "value": this.value,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class CaseSourceModel {
  final String category;
  final String categoryName;
  final String content;
  final dynamic fee;
  final String id;
  final String lawyerId;
  final dynamic limited;
  final String requirement;
  final String status;
  final String title;
  final String nickName;
  final String underTakes;
  final int value;
  final int createTime;
  bool delCheck;

  CaseSourceModel({
    this.category,
    this.categoryName,
    this.content,
    this.fee,
    this.nickName,
    this.id,
    this.lawyerId,
    this.limited,
    this.requirement,
    this.status,
    this.title,
    this.underTakes,
    this.value,
    this.createTime,
    this.delCheck = false,
  });

  factory CaseSourceModel.fromJson(Map<String, dynamic> json) =>
      _$CaseSourceModelFromJson(json);

  CaseSourceModel from(Map<String, dynamic> json) =>
      _$CaseSourceModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['content'] = this.content;
    data['fee'] = this.fee;
    data['id'] = this.id;
    data['lawyerId'] = this.lawyerId;
    data['limited'] = this.limited;
    data['requirement'] = this.requirement;
    data['status'] = this.status;
    data['title'] = this.title;
    data['underTakes'] = this.underTakes;
    data['value'] = this.value;
    data['createTime'] = this.createTime;
    return data;
  }
}

CaseSourceModel _$CaseSourceModelFromJson(Map<String, dynamic> json) {
  return CaseSourceModel(
    category: json['category'],
    nickName: json['nickName'],
    categoryName: json['categoryName'],
    content: json['content'],
    fee: json['fee'],
    id: json['id'],
    lawyerId: json['lawyerId'],
    limited: json['limited'],
    requirement: json['requirement'],
    status: json['status'],
    title: json['title'],
    underTakes: json['underTakes'],
    value: json['value'],
    createTime: json['createTime'],
  );
}
