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

/// 通过用户id获取全部案例列表
class CaseListRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  CaseListRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/case/cases/$page/$limit/$id';
}

/// 律所获取案例列表
class CaseFirmRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  CaseFirmRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/case/firm/$id/$page/$limit';
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
  final String synopsis;
  final double value;
  final String categoryName;
  bool delCheck;

  ConsultListModel({
    this.category,
    this.createTime,
    this.detail,
    this.id,
    this.no,
    this.title,
    this.synopsis,
    this.trialStage,
    this.url,
    this.value,
    this.categoryName,
    this.delCheck = false,
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
    data['categoryName'] = this.value;
    data['synopsis'] = this.synopsis;
    return data;
  }
}

ConsultListModel _$ConsultListModelFromJson(Map<String, dynamic> json) {
  return ConsultListModel(
    category: json['category'],
    createTime: json['createTime'],
    detail: json['detail'],
    synopsis: json['synopsis'],
    id: json['id'],
    no: json['no'],
    title: json['title'],
    trialStage: json['trialStage'],
    url: json['url'],
    value: json['value'],
    categoryName: json['categoryName'],
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
  final String synopsis;

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
    this.synopsis,
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
      'synopsis': this.synopsis,
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
  final String content;
  final String targetId;
  final int type;

  CaseCommentRequestModel({
    this.content,
    this.targetId,
    this.type,
  });

  @override
  String url() => '/comment-like-record/comment';

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": this.content,
      "targetId": this.targetId,
      "type": this.type,
    };
  }
}

/// 取消点赞
class CancelCommentAgreeRequestModel extends BaseRequest {
  final String typeId;

  CancelCommentAgreeRequestModel({
    this.typeId,
  });

  @override
  String url() => '/comment-like-record/cancel-agreement-comments';

  @override
  Map<String, dynamic> toJson() {
    return {
      "typeId": this.typeId,
    };
  }
}

///案例新增评论 	integer($int32)
//example: 1
//评论类型0 课件评论，1 律师评论, 2 图文评论，3 案例评论
//
//}
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
* [获取案例详情
*
* @param description:  案例详情的VO
* @param category string 类别id
* @param categoryName string 类别名称
* @param commentCount string 评论数
* @param court string 经办法院
* @param createTime string($date-time) 创建时间
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
  final String categoryName;
  final String realName;
  final dynamic commentCount;
  final String court;
  final int createTime;
  final String detail;
  int dislikeCount;
  final String id;
  final String judge;
  int likeCount;
  final String no;
  final String title;
  final String trialStage;
  final String url;
  final String userId;
  final double value;
  final String userNae;
  final String avatar;
  final int likeStatus;

  CaseDetailsModel({
    this.category,
    this.categoryName,
    this.realName,
    this.commentCount,
    this.court,
    this.createTime,
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
    this.userNae,
    this.likeStatus,
    this.avatar,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CaseDetailsModelFromJson(json);

  CaseDetailsModel from(Map<String, dynamic> json) =>
      _$CaseDetailsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['commentCount'] = this.commentCount;
    data['court'] = this.court;
    data['createTime'] = this.createTime;
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
    data['userNae'] = this.userNae;
    data['likeStatus'] = this.likeStatus;
    return data;
  }
}

CaseDetailsModel _$CaseDetailsModelFromJson(Map<String, dynamic> json) {
  return CaseDetailsModel(
    category: json['category'],
    realName: json['realName'],
    avatar: json['avatar'],
    categoryName: json['categoryName'],
    commentCount: json['commentCount'],
    court: json['court'],
    createTime: json['createTime'],
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
    userNae: json['userNae'],
    likeStatus: json['likeStatus'],
  );
}

/// 获取案源列表
class SourceCaseListRequestModel extends BaseRequest {
  @override
  String url() => '/index/sourceCase';
}

/// 分页获取所有安源列表（不包括待审核和审核失败的）
class SourceCaseAllListRequestModel extends BaseRequest {
  final int page;
  final int limit;

  SourceCaseAllListRequestModel({
    this.page,
    this.limit,
  });

  @override
  String url() => '/source-case/list-all/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class SourceCaseModel {
  final String category;
  final String categoryName;
  final String content;
  final int createTime;
  final dynamic deleted;
  final dynamic fee;
  final String id;
  final String lawyerId;
  final int limited;
  final String requirement;
  final String status;
  final String title;
  final String underTakes;
  final int updateTime;
  final int value;
  final bool own;

  SourceCaseModel({
    this.own,
    this.category,
    this.categoryName,
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
    data['categoryName'] = this.categoryName;
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
    data['own'] = this.own;
    return data;
  }
}

SourceCaseModel _$SourceCaseModelFromJson(Map<String, dynamic> json) {
  return SourceCaseModel(
    category: json['category'],
    content: json['content'],
    createTime: json['createTime'],
    deleted: json['deleted'],
    categoryName: json['categoryName'],
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
    own: json['own'],
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

///给评论点赞
class AgreementCommentsRequestModel extends BaseRequest {
  final String typeId;

  AgreementCommentsRequestModel({this.typeId});

  @override
  String url() => '/comment-like-record/agreement-comments';

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': this.typeId,
    };
  }
}

///给图文点赞
class PraiseArticleRequestModel extends BaseRequest {
  final String sketchId;
  final int status;

  PraiseArticleRequestModel({this.sketchId, this.status});

  @override
  String url() => '/sketch/comment';

  @override
  Map<String, dynamic> toJson() {
    return {"sketchId": this.sketchId, "status": this.status};
  }
}

///分页获取（课件评论，律师评论,图文评论，案例评论） 这是响应回来的数据，以此为准
///接口文档未更新
/*
* 分页获取（课件评论，律师评论,图文评论，案例评论）
*
* @param avatar string 头像
* @param content String 评论内容
* @param likeCount string 点赞数
* @param nickName string 昵称
* @param userId string 用户id
* @param isThumbsUp bool 是否已点赞
* @param id String id
* */
class CaseCommentListModel {
  final String avatar;
  final String content;
  final String id;
  bool isThumbsUp;
  final int likeCount;
  final String nickName;
  final String userId;
  final int createTime;

  CaseCommentListModel({
    this.avatar,
    this.content,
    this.id,
    this.isThumbsUp,
    this.likeCount,
    this.nickName,
    this.userId,
    this.createTime,
  });

  factory CaseCommentListModel.fromJson(Map<String, dynamic> json) =>
      _$CaseCommentListModelFromJson(json);

  CaseCommentListModel from(Map<String, dynamic> json) =>
      _$CaseCommentListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['id'] = this.id;
    data['isThumbsUp'] = this.isThumbsUp;
    data['likeCount'] = this.likeCount;
    data['nickName'] = this.nickName;
    data['userId'] = this.userId;
    data['createTime'] = this.createTime;
    return data;
  }
}

CaseCommentListModel _$CaseCommentListModelFromJson(Map<String, dynamic> json) {
  return CaseCommentListModel(
    avatar: json['avatar'],
    createTime: json['createTime'],
    content: json['content'],
    id: json['id'],
    isThumbsUp: json['isThumbsUp'],
    likeCount: json['likeCount'],
    nickName: json['nickName'],
    userId: json['userId'],
  );
}

/// comment-like-record/comment-del/{id} 删除评论 (post)
class CommentDelRequestModel extends BaseRequest {
  final String id;

  CommentDelRequestModel(this.id);

  @override
  String url() => '/comment-like-record/comment-del/$id';

  @override
  Map<String, dynamic> toJson() {
    return {"id": this.id};
  }
}
