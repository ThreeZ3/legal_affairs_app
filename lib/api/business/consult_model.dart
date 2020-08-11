import 'package:jh_legal_affairs/util/tools.dart';

/// 案例赞成
class CaseAgreeRequestModel extends BaseRequest {
  final String userId;
  final String caseId;

  CaseAgreeRequestModel({
    this.userId,
    this.caseId,
  });

  @override
  String url() => '/case/agreement';

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'caseId': this.caseId,
    };
  }
}

/// 获取我的全部案例列表
class CaseListRequestModel extends BaseRequest {
  final String lawyerId;
  final int limit;
  final int page;

  CaseListRequestModel({
    this.lawyerId,
    this.limit,
    this.page,
  });

  @override
  String url() => '/case/cases/$page/$limit';

  @override
  Map<String, dynamic> toJson() {
    return {
      'lawyerId': this.lawyerId,
    };
  }
}

/*
* 获取我的全部案例列表
*
* @param description:  案例列表的VO
* @param category string 类别
* @param createTime string($date-time) 案例发布时间
* @param detail string 图文详情
* @param id string
* @param no string 按例编号
* @param title string 标题
* @param trialStage CaseApprovalTypeEnum
* ...}
* @param url string 按例网址
* @param value number 案值]
* */
class ConsultListModel {
  final String category;
  final int createTime;
  final String detail;
  final String id;
  final String no;
  final String title;
  final String trialStage;
  final String url;
  final double value;

  ConsultListModel({
    this.category,
    this.createTime,
    this.detail,
    this.id,
    this.no,
    this.title,
    this.trialStage,
    this.url,
    this.value,
  });

  factory ConsultListModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultListModelFromJson(json);

  ConsultListModel from(Map<String, dynamic> json) =>
      _$ConsultListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['createTime'] = this.createTime;
    data['detail'] = this.detail;
    data['id'] = this.id;
    data['no'] = this.no;
    data['title'] = this.title;
    data['trialStage'] = this.trialStage;
    data['url'] = this.url;
    data['value'] = this.value;
    return data;
  }
}

ConsultListModel _$ConsultListModelFromJson(Map<String, dynamic> json) {
  return ConsultListModel(
    category: json['category'],
    createTime: json['createTime'],
    detail: json['detail'],
    id: json['id'],
    no: json['no'],
    title: json['title'],
    trialStage: json['trialStage'],
    url: json['url'],
    value: json['value'],
  );
}

/*
* 新增案例数据
*
* @param category string 业务类别id
* @param court string 经办法院
* @param detail string 图文详情
* @param id string 案例id(发布时不传，修改时必传)
* @param judge string 审判长
* @param no string 按例编号
* @param title string 标题
* @param trialStage integer($int32) 审批阶段:0 未审批，1 审判中，2 已结束
* @param url string 按例网址
* @param value number 案值
* */

class CaseAddRequestModel extends BaseRequest {
  final String category;
  final String court;
  final String detail;
  final String id;
  final String judge;
  final String lawyerId;
  final String title;
  final int trialStage;
  final String value;
  final String caseUrl;
  final String caseNo;

  CaseAddRequestModel({
    this.category,
    this.court,
    this.detail,
    this.id,
    this.judge,
    this.lawyerId,
    this.title,
    this.trialStage,
    this.value,
    this.caseUrl,
    this.caseNo,
  });

  @override
  String url() => '/case';

  @override
  Map<String, dynamic> toJson() {
    return {
      'category': this.category,
      'court': this.court,
      'detail': this.detail,
      'id': this.id,
      'judge': this.judge,
      'lawyerId': this.lawyerId,
      'title': this.title,
      'trialStage': this.trialStage,
      'value': this.value,
      'url': this.caseUrl,
      'no': this.caseNo,
    };
  }
}

/*
* 案例用户反馈表
*
* @param caseId string 案例id
* @param comment string 评论
* @param createTime string($date-time) 记录创建时间
* @param deleted integer($int32) 删除标记,0表示没有被删除，1表示主动删除，2表示被动删除
* @param id string
* @param updateTime string($date-time) 记录更新时间
* @param userId string 用户id
* */
class CaseCommentRequestModel extends BaseRequest {
  final String caseId;
  final String comment;
  final String createTime;
  final int deleted;
  final String id;
  final String updateTime;
  final String userId;

  CaseCommentRequestModel({
    this.caseId,
    this.comment,
    this.createTime,
    this.deleted,
    this.id,
    this.userId,
    this.updateTime,
  });

  @override
  String url() => '/case/comment';

  @override
  Map<String, dynamic> toJson() {
    return {
      "caseId": this.userId,
      "comment": this.comment,
      "createTime": this.createTime,
      "deleted": this.deleted,
      "id": this.id,
      "updateTime": this.updateTime,
      "userId": this.userId,
    };
  }
}

///案例新增评论 相关内容评论（课件评论，律师评论,图文评论，案例评论）
class CaseNewCommentRequestModel extends BaseRequest {
  final String targetId;
  final String content;
  final int type;

  CaseNewCommentRequestModel({
    this.targetId,
    this.content,
    this.type,
  });

  @override
  String url() => '/comment-like-record/comment';

  @override
  Map<String, dynamic> toJson() {
    return {
      "targetId": this.targetId,
      "content": this.content,
      "type": this.type,
    };
  }
}

/// 案例评论列表
class CaseCommentListRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  CaseCommentListRequestModel({this.id, this.limit, this.page});

  @override
  String url() => '/comment-like-record/comment/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 案例评论列表
*
* @param caseId string 案例id
* @param comment string 评论
* @param thumbDown string 反对
* @param thumbUp string 支持
* @param userId string 用户id
* */
class CaseCommentListModel {
  final String caseId;
  final String comment;
  final String thumbDown;
  final String thumbUp;
  final String userId;

  CaseCommentListModel({
    this.caseId,
    this.comment,
    this.thumbDown,
    this.thumbUp,
    this.userId,
  });

  factory CaseCommentListModel.fromJson(Map<String, dynamic> json) =>
      _$CaseCommentListModelFromJson(json);

  CaseCommentListModel from(Map<String, dynamic> json) =>
      _$CaseCommentListModelFromJson(json);

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

CaseCommentListModel _$CaseCommentListModelFromJson(Map<String, dynamic> json) {
  return CaseCommentListModel(
    caseId: json['caseId'],
    comment: json['comment'],
    thumbDown: json['thumbDown'],
    thumbUp: json['thumbUp'],
    userId: json['userId'],
  );
}

/// 案例反对
class CaseOppositionRequestModel extends BaseRequest {
  final String userId;
  final String caseId;

  CaseOppositionRequestModel({
    this.userId,
    this.caseId,
  });

  @override
  String url() => '/case/opposition';

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'caseId': this.caseId,
    };
  }
}

/// 获取律师视频列表
class CaseVideoRequestModel extends BaseRequest {
  final String lawyerId;

  CaseVideoRequestModel({
    this.lawyerId,
  });

  @override
  String url() => '/case/video/$lawyerId';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [律师视频列表Model
*
* @param description:  案例列表的VO
* @param category string 类别
* @param count string 观看数
* @param createTime string($date-time) 案例发布时间
* @param dataUrl string 数据地址
* @param detail string 图文详情
* @param lawyerId string 律师id
* @param tital string 标题
* @param title string 标题
* @param trialStage integer($int32) 审判阶段
* @param value number 案值]
* */
class CaseVideoModel {
  final String category;
  final String count;
  final String createTime;
  final String dataUrl;
  final String detail;
  final String lawyerId;
  final String tital;
  final String title;
  final int trialStage;
  final int value;

  CaseVideoModel({
    this.category,
    this.count,
    this.createTime,
    this.dataUrl,
    this.detail,
    this.lawyerId,
    this.tital,
    this.title,
    this.trialStage,
    this.value,
  });

  factory CaseVideoModel.fromJson(Map<String, dynamic> json) =>
      _$CaseVideoModelFromJson(json);

  CaseVideoModel from(Map<String, dynamic> json) =>
      _$CaseVideoModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['count'] = this.count;
    data['createTime'] = this.createTime;
    data['dataUrl'] = this.dataUrl;
    data['detail'] = this.detail;
    data['lawyerId'] = this.lawyerId;
    data['tital'] = this.tital;
    data['title'] = this.title;
    data['trialStage'] = this.trialStage;
    data['value'] = this.value;
    return data;
  }
}

CaseVideoModel _$CaseVideoModelFromJson(Map<String, dynamic> json) {
  return CaseVideoModel(
    category: json['category'],
    count: json['count'],
    createTime: json['createTime'],
    dataUrl: json['dataUrl'],
    detail: json['detail'],
    lawyerId: json['lawyerId'],
    tital: json['tital'],
    title: json['title'],
    trialStage: json['trialStage'],
    value: json['value'],
  );
}

/// 获取案例详情
class CaseDetailsRequestModel extends BaseRequest {
  final String id;

  CaseDetailsRequestModel({
    this.id,
  });

  @override
  String url() => '/case/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [CaseDetailVo
*
* @param description:  案例详情的
* @param category string 类别
* @param comment string 评论
* @param court string 经办法院
* @param detail string 图文详情
* @param dislikeCount integer($int32) 反对数
* @param id string
* @param judge string 审判长
* @param likeCount integer($int32) 支持数
* @param no string 按例编号
* @param title string 标题
* @param trialStage CaseApprovalTypeEnum
* ...}
* @param url string 按例网址
* @param userId string 用户id
* @param value number 案值]
* */

class CaseDetailsModel {
  final String category;
  final String comment;
  final String court;
  final String detail;
  final int dislikeCount;
  final String id;
  final String judge;
  final int likeCount;
  final String no;
  final String title;
  final String trialStage;
  final String url;
  final String userId;
  final double value;

  CaseDetailsModel({
    this.category,
    this.comment,
    this.court,
    this.detail,
    this.dislikeCount,
    this.id,
    this.judge,
    this.likeCount,
    this.no,
    this.title,
    this.trialStage,
    this.url,
    this.userId,
    this.value,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  CaseDetailsModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['comment'] = this.comment;
    data['court'] = this.court;
    data['detail'] = this.detail;
    data['dislikeCount'] = this.dislikeCount;
    data['id'] = this.id;
    data['judge'] = this.judge;
    data['likeCount'] = this.likeCount;
    data['no'] = this.no;
    data['title'] = this.title;
    data['trialStage'] = this.trialStage;
    data['url'] = this.url;
    data['userId'] = this.userId;
    data['value'] = this.value;
    return data;
  }
}

CaseDetailsModel _$DataFromJson(Map<String, dynamic> json) {
  return CaseDetailsModel(
    category: json['category'],
    comment: json['comment'],
    court: json['court'],
    detail: json['detail'],
    dislikeCount: json['dislikeCount'],
    id: json['id'],
    judge: json['judge'],
    likeCount: json['likeCount'],
    no: json['no'],
    title: json['title'],
    trialStage: json['trialStage'],
    url: json['url'],
    userId: json['userId'],
    value: json['value'],
  );
}

/// 获取案源列表
class SourceCaseListRequestModel extends BaseRequest {
  @override
  String url() => '/index/sourceCase';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class SourceCaseModel {
  final String category;
  final String content;
  final int createTime;
  final dynamic deleted;
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

  SourceCaseModel({
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

  factory SourceCaseModel.fromJson(Map<String, dynamic> json) =>
      _$SourceCaseModelFromJson(json);

  SourceCaseModel from(Map<String, dynamic> json) =>
      _$SourceCaseModelFromJson(json);

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

SourceCaseModel _$SourceCaseModelFromJson(Map<String, dynamic> json) {
  return SourceCaseModel(
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

/// 多选删除我的案例 [多个]
class DeletesCaseRequestModel extends BaseRequest {
  final String ids;

  DeletesCaseRequestModel(this.ids);

  @override
  String url() => '/case/ids/$ids';
}

/// 删除案例
class DeleteCaseRequestModel extends BaseRequest {
  final String id;

  DeleteCaseRequestModel(this.id);

  @override
  String url() => '/case/$id';
}

///案例评论（点赞/反对）
class CaseOpinionModel extends BaseRequest {
  final String caseId;
  final int status;

  CaseOpinionModel({this.caseId, this.status});

  @override
  String url() => '/case/opinion';

  @override
  Map<String, dynamic> toJson() {
    return {
      'caseId': this.caseId,
      'status': this.status,
    };
  }
}

///案例评论列表
class CaseTalkModel {
  final String avatar;
  final dynamic content;
  final String id;
  final int likeCount;
  final String nickName;
  final String userId;

  CaseTalkModel({
    this.avatar,
    this.content,
    this.id,
    this.likeCount,
    this.nickName,
    this.userId,
  });

  factory CaseTalkModel.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  CaseTalkModel from(Map<String, dynamic> json) => _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['id'] = this.id;
    data['likeCount'] = this.likeCount;
    data['nickName'] = this.nickName;
    data['userId'] = this.userId;
    return data;
  }
}

CaseTalkModel _$RecordsFromJson(Map<String, dynamic> json) {
  return CaseTalkModel(
    avatar: json['avatar'],
    content: json['content'],
    id: json['id'],
    likeCount: json['likeCount'],
    nickName: json['nickName'],
    userId: json['userId'],
  );
}

///案例评论（点赞/反对）
class CaseOpinionRequestModel extends BaseRequest {
  final String caseId;
  final int status;

  CaseOpinionRequestModel({this.caseId, this.status});

  @override
  String url() => '/case/opinion';

  @override
  Map<String, dynamic> toJson() {
    return {
      'caseId': this.caseId,
      'status': this.status,
    };
  }
}

class Status {
  final int code;
  final String descp;

  Status({
    this.code,
    this.descp,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Status from(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['descp'] = this.descp;
    return data;
  }
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    code: json['code'],
    descp: json['descp'],
  );
}

/// **************************************************************************
/// 获取咨询详情响应
/// **************************************************************************

class ConsultDetailsModel {
  final String category;
  final String categoryId;
  final List<dynamic> consultAnswerVos;
  final String content;
  final int createTime;
  final dynamic expirationTime;
  final String firstAsk;
  final String id;
  final String issuerName;
  final String issuerId;
  final int limit;
  final String optimumAsk;
  final String similarAsk;
  final String status;
  final String title;
  final String totalAsk;
  final String require;

  ConsultDetailsModel({
    this.category,
    this.categoryId,
    this.consultAnswerVos = const [],
    this.content,
    this.createTime,
    this.expirationTime,
    this.firstAsk,
    this.id,
    this.issuerName,
    this.issuerId,
    this.limit,
    this.optimumAsk,
    this.similarAsk,
    this.status,
    this.title,
    this.totalAsk,
    this.require,
  });

  factory ConsultDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultDetailsModelFromJson(json);

  ConsultDetailsModel from(Map<String, dynamic> json) =>
      _$ConsultDetailsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['firstAsk'] = this.firstAsk;
    data['id'] = this.id;
    data['issuerName'] = this.issuerName;
    data['issuerId'] = this.issuerId;
    data['createTime'] = this.createTime;
    data['limit'] = this.limit;
    data['optimumAsk'] = this.optimumAsk;
    data['similarAsk'] = this.similarAsk;
    data['status'] = this.status;
    data['title'] = this.title;
    data['totalAsk'] = this.totalAsk;
    return data;
  }
}

ConsultDetailsModel _$ConsultDetailsModelFromJson(Map<String, dynamic> json) {
  return ConsultDetailsModel(
    category: json['category'],
    categoryId: json['categoryId'],
    content: json['content'],
    createTime: json['createTime'],
    require: json['require'],
    expirationTime: json['expirationTime'],
    firstAsk: json['firstAsk'],
    id: json['id'],
    issuerName: json['issuerName'],
    issuerId: json['issuerId'],
    limit: json['limit'],
    optimumAsk: json['optimumAsk'],
    similarAsk: json['similarAsk'],
    status: json['status'],
    title: json['title'],
    totalAsk: json['totalAsk'],
  );
}

/// 可咨询列表  当前用户全部咨询列表
class ConsultListRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  ConsultListRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/consult/consult/$page/$limit/$id';
}

/// 律所获取咨询列表
class ConsultFirmRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  ConsultFirmRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/consult/firm/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
*  [#/definitions/ConsultVO对象ConsultVO对象
*
* @param ask string 要价
* @param category string 业务类别
* @param categoryId string 业务类别Id
* @param consultAnswerVos
*  [ 咨询回复
* @param ConsultAnswerVo对象
*
* @param consultId string 咨询表id
* @param content string 回复内容
* @param respondentAvatar string 回复人头像
* @param respondentId string 回复人id
* @param respondentName string 回复人名称
* @param score ConsultAnswerScoreEnum
* ...}]
* @param content string 简介
* @param createTime int 创建时间
* @param expirationTime string($date-time) 过期时间
* @param firstAsk string 首个答案价格
* @param issuerName string 咨询者
* @param limit integer($int32) 时限
* @param optimumAsk string 最佳答案价格
* @param own boolean 是否自己发布的
* @param similarAsk string 相似答案价格
* @param status ConsultStatusEnum
* @param title string 标题
* @param totalAsk string 总报价价]
* */
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class ConsultViewListModel {
  final String category;
  final String categoryId;
  final String content;
  final dynamic expirationTime;
  final int createTime;
  final String id;
  final int limit;
  final dynamic own;
  final String status;
  final String title;
  final String totalAsk;
  final String synopsis;
  bool isDel;

  ConsultViewListModel({
    this.category,
    this.categoryId,
    this.content,
    this.expirationTime,
    this.createTime,
    this.id,
    this.limit,
    this.own,
    this.status,
    this.title,
    this.totalAsk,
    this.isDel = false,
    this.synopsis,
  });

  factory ConsultViewListModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultViewListModelFromJson(json);

  ConsultViewListModel from(Map<String, dynamic> json) =>
      _$ConsultViewListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    data['expirationTime'] = this.expirationTime;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['limit'] = this.limit;
    data['own'] = this.own;
    data['synopsis'] = this.synopsis;
    data['status'] = this.status;
    data['title'] = this.title;
    data['totalAsk'] = this.totalAsk;
    return data;
  }
}

ConsultViewListModel _$ConsultViewListModelFromJson(Map<String, dynamic> json) {
  return ConsultViewListModel(
    category: json['category'],
    categoryId: json['categoryId'],
    content: json['content'],
    expirationTime: json['expirationTime'],
    createTime: json['createTime'],
    id: json['id'],
    limit: json['limit'],
    synopsis: json['synopsis'],
    own: json['own'],
    status: json['status'],
    title: json['title'],
    totalAsk: json['totalAsk'],
  );
}

///多选删除我的咨询 【多个】
class DeletesConsultRequestModel extends BaseRequest {
  final String ids;

  DeletesConsultRequestModel(this.ids);

  @override
  String url() => '/consult/bulk-Consult/$ids';
}

///删除咨询 【单个】 文档上是错误的，此地正确
class DeleteConsultRequestModel extends BaseRequest {
  final String id;

  DeleteConsultRequestModel(this.id);

  @override
  String url() => '/consult/$id';
}

/// 分页获取所有咨询
class ConsultPublishingPageRequestModel extends BaseRequest {
  final int limit;
  final int page;

  ConsultPublishingPageRequestModel({
    this.limit,
    this.page,
  });

  @override
  String url() => '/consult/publishingPage/$page/$limit';
}

/// 咨询回复
class ConsultAnswerRequestModel extends BaseRequest {
  final String consultId;
  final String content;

  ConsultAnswerRequestModel({
    this.consultId,
    this.content,
  });

  @override
  String url() => '/consult-answer';

  @override
  Map<String, dynamic> toJson() {
    return {
      "consultId": this.consultId,
      "content": this.content,
    };
  }
}

class ConsultAnswerLimitRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  ConsultAnswerLimitRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/consult-answer/$id/$page/$limit';

//  @override
//  Map<String, dynamic> toJson() {
//    return {
//      "consultId": this.consultId,
//      "content": this.content,
//    };
//  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 咨询回复标记
*
* @param id string 咨询回复id
* @param score integer($int32) 标记:答案标记：0.无标记，1.最佳答案，2.相似答案，3.首个答案
* */
class ConsultAnswerMarkRequestModel extends BaseRequest {
  final String id;
  final int score;

  ConsultAnswerMarkRequestModel({
    this.id,
    this.score,
  });

  @override
  String url() => '/consult-answer';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "score": this.score,
    };
  }
}

/// 发布的咨询列表  获取当前用户发布的咨询列表
class ConsultReleaseRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  ConsultReleaseRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/consult/cur-list/$page/$limit/$id';
}

/// 承接的咨询列表  当前用户承载的咨询列表
class ConsultByUnderRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  ConsultByUnderRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/consult/under-take/$page/$limit/$id';
}

/// 获取用户咨询列表
class ConsultUserRequestModel extends BaseRequest {
  final String userId;

  ConsultUserRequestModel(this.userId);

  @override
  String url() => '/consult/getConsultByUserId/$userId';
}

/// 获取咨询详情
class ConsultDetailsRequestModel extends BaseRequest {
  final String id;

  ConsultDetailsRequestModel(this.id);

  @override
  String url() => '/consult/details/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 新增咨询数据  发布咨询
*
* @param categoryId string 业务类别
* @param content string 问题
* @param firstAsk string 首个答案价格
* @param id string 质询id(新增不传，修改时必传)
* @param limit integer($int32) 时限
* @param optimumAsk string 最佳答案价格
* @param require string 要求
* @param similarAsk string 相似答案价格
* @param title string 标题
* @param totalAsk string 总报价
* */
class ConsultAddRequestModel extends BaseRequest {
  final String categoryId;
  final String content;
  final String firstAsk;
  final String id;
  final int limit;
  final String optimumAsk;
  final String require;
  final String similarAsk;
  final String title;
  final String totalAsk;
  final String synopsis;

  ConsultAddRequestModel({
    this.categoryId,
    this.content,
    this.firstAsk,
    this.id,
    this.limit,
    this.optimumAsk,
    this.require,
    this.similarAsk,
    this.title,
    this.totalAsk,
    this.synopsis,
  });

  @override
  String url() => '/consult';

  @override
  Map<String, dynamic> toJson() {
    return {
      "categoryId": this.categoryId,
      "content": this.content,
      "firstAsk": this.firstAsk,
      "id": this.id,
      "limit": this.limit,
      "optimumAsk": this.optimumAsk,
      "require": this.require,
      "similarAsk": this.similarAsk,
      "title": this.title,
      "totalAsk": this.totalAsk,
      "synopsis": this.synopsis,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* IPage«ConsultAnswerVo对象»
*
* @param current integer($int64)
* @param pages integer($int64)
* @param records [ConsultAnswerVo对象
*
* @param consultId string 咨询表id
* @param content string 回复内容
* @param id string 咨询回复id
* @param respondentAvatar string 回复人头像
* @param respondentId string 回复人id
* @param respondentName string 回复人名称
* @param score ConsultAnswerScoreEnum
* @param createTime	string($date-time)回复时间
* @param code integer($int32)
* @param descp string]
* @param searchCount boolean
* @param size integer($int64)
* @param total integer($int64)
* */
class consultAnswerLimitModel {
  final int current;
  final int pages;
  final List<Recordss> records;
  final bool searchCount;
  final int size;
  final int total;

  consultAnswerLimitModel({
    this.current,
    this.pages,
    this.records,
    this.searchCount,
    this.size,
    this.total,
  });

  factory consultAnswerLimitModel.fromJson(Map<String, dynamic> json) =>
      _$consultAnswerLimitModelFromJson(json);

  consultAnswerLimitModel from(Map<String, dynamic> json) =>
      _$consultAnswerLimitModelFromJson(json);

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

consultAnswerLimitModel _$consultAnswerLimitModelFromJson(
    Map<String, dynamic> json) {
  return consultAnswerLimitModel(
    current: json['current'],
    pages: json['pages'],
    records: json['records'].map((item) {
      return new Recordss.fromJson(item);
    }).toList(),
    searchCount: json['searchCount'],
    size: json['size'],
    total: json['total'],
  );
}

class Recordss {
  final String consultId;
  final String content;
  final String id;
  final int createTime;
  final String respondentAvatar;
  final String respondentId;
  final String respondentName;
  final String score;

  Recordss({
    this.consultId,
    this.content,
    this.id,
    this.createTime,
    this.respondentAvatar,
    this.respondentId,
    this.respondentName,
    this.score,
  });

  factory Recordss.fromJson(Map<String, dynamic> json) =>
      _$RecordssFromJson(json);

  Recordss from(Map<String, dynamic> json) => _$RecordssFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultId'] = this.consultId;
    data['content'] = this.content;
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['respondentAvatar'] = this.respondentAvatar;
    data['respondentId'] = this.respondentId;
    data['respondentName'] = this.respondentName;
    data['score'] = this.score;
    return data;
  }
}

Recordss _$RecordssFromJson(Map<String, dynamic> json) {
  return Recordss(
    consultId: json['consultId'],
    content: json['content'],
    id: json['id'],
    createTime: json['createTime'],
    respondentAvatar: json['respondentAvatar'],
    respondentId: json['respondentId'],
    respondentName: json['respondentName'],
    score: json['score'],
  );
}

/// consult-answer/del/{id} 删除回复
class ConsultAnswerDelRequestModel extends BaseRequest {
  final String id;

  ConsultAnswerDelRequestModel(this.id);

  @override
  String url() => '/consult-answer/del/$id';
}
