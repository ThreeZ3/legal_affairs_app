import 'package:jh_legal_affairs/http/base_request.dart';

class LawyerMyCaseCommentsRequestModel extends BaseRequest{
  @override
  String url() => '/case/comments';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class LawyerMyCaseCommentsModel {
  final int code;
  final List<dynamic> data;
  final String msg;

  LawyerMyCaseCommentsModel({
    this.code,
    this.data,
    this.msg,
  });

  factory LawyerMyCaseCommentsModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerMyCaseCommentsModelFromJson(json);

  LawyerMyCaseCommentsModel from(Map<String, dynamic> json) =>
      _$LawyerMyCaseCommentsModelFromJson(json);

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

LawyerMyCaseCommentsModel _$LawyerMyCaseCommentsModelFromJson(
    Map<String, dynamic> json) {
  return LawyerMyCaseCommentsModel(
    code: json['code'],
    data: json['data'].map((item) {
      return new CaseCommentsModel.fromJson(item);
    }).toList(),
    msg: json['msg'],
  );
}

class CaseCommentsModel {
  final String caseId;
  final String comment;
  final String thumbDown;
  final String thumbUp;
  final String userId;

  CaseCommentsModel({
    this.caseId,
    this.comment,
    this.thumbDown,
    this.thumbUp,
    this.userId,
  });

  factory CaseCommentsModel.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  CaseCommentsModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseId'] = this.caseId;
    data['comment'] = this.comment;
    data['thumbDown'] = this.thumbDown;
    data['thumbUp'] = this.thumbUp;
    data['userId'] = this.userId;
    return data;
  }
}

CaseCommentsModel _$DataFromJson(Map<String, dynamic> json) {
  return CaseCommentsModel(
    caseId: json['caseId'],
    comment: json['comment'],
    thumbDown: json['thumbDown'],
    thumbUp: json['thumbUp'],
    userId: json['userId'],
  );
}
