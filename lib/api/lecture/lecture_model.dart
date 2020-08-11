import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/http/base_request.dart';

///免费课件订阅

class LectureFreeSubRequest extends BaseRequest {
  final String id;

  LectureFreeSubRequest({this.id});

  @override
  String url() => '/subscribe/lecture/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 新增案例
*
* @param category string
* @param example: f5fa7307deac4a638afcd873b2d093d6
(sys_legal_field表)课件类别id
* @param charges number 收费标准
* @param content string 内容
* @param cover string 封面
* @param id string
* @param isCharge integer($int32) 是否收费
* @param title string 标题
* */

///新增课件
class LectureAddRequestModel extends BaseRequest {
  final String category;
  final double charges;
  final String content;
  final String cover;
  final String id;
  final int isCharge;
  final String title;
  final String videoUrl;

  LectureAddRequestModel({
    this.category,
    this.charges,
    this.content,
    this.id,
    this.isCharge,
    this.title,
    this.cover,
    this.videoUrl,
  });

  @override
  String url() => '/lecture';

  @override
  Map<String, dynamic> toJson() {
    return {
      "category": this.category,
      "charges": this.charges,
      "content": this.content,
      "id": this.id,
      "isCharge": this.isCharge,
      "title": this.title,
      'cover': this.cover,
      'videoUrl': this.videoUrl,
    };
  }
}

/// 课件赞成
class LectureAgreeRequestModel extends BaseRequest {
  final String lecturesId;
  final String userId;

  LectureAgreeRequestModel({
    this.lecturesId,
    this.userId,
  });

  @override
  String url() => '/lecture/agreement';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lecturesId": this.lecturesId,
      "userId": this.userId,
    };
  }
}

/// 课件反对
class LectureOppositionRequestModel extends BaseRequest {
  final String lecturesId;
  final String userId;

  LectureOppositionRequestModel({
    this.lecturesId,
    this.userId,
  });

  @override
  String url() => '/lecture/opposition';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lecturesId": this.lecturesId,
      "userId": this.userId,
    };
  }
}

/*
* 课件点评操作
*
* @param lectureId string 课件id
* @param status integer($int32) 操作类型:1.支持，2.反对
* */
//课件评论评论（点赞/反对）
class LectureAttitudeRequestModel extends BaseRequest {
  final String lectureId;
  final int status;

  LectureAttitudeRequestModel({
    @required this.lectureId,
    @required this.status,
  });

  @override
  String url() => '/lecture/opinion';

  @override
  Map<String, dynamic> toJson() {
    return {
      "lectureId": this.lectureId,
      "status": this.status,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 课件用户反馈表DTO  新增课件评论
*
* @param comment string 评论
* @param id string
* @param lectureId string 课件id
* @param userId string 用户id
* */
class LectureCommentRequestModel extends BaseRequest {
  final String comment;
  final String id;
  final String lectureId;
  final String userId;

  LectureCommentRequestModel({
    this.comment,
    this.id,
    this.lectureId,
    this.userId,
  });

  @override
  String url() => '/lecture/comment';

  @override
  Map<String, dynamic> toJson() {
    return {
      "comment": "string",
      "id": "string",
      "lectureId": "string",
      "userId": "string"
    };
  }
}

/// 课件评论列表 分页获取（课件评论，律师评论,图文评论，案例评论）
class LectureCommentsListRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  LectureCommentsListRequestModel({this.id, this.page, this.limit});

  @override
  String url() => '/comment-like-record/comment/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 课件评论列表
*
* @param comment string 评论
* @param lectureId string 课件id
* @param thumbDown string 反对
* @param thumbUp string 支持
* @param userId string 用户id
* */
class LectureCommentListModel {
  final String comment;
  final String lectureId;
  final String thumbDown;
  final String thumbUp;
  final String userId;
  final String avatar;
  final String content;
  final String nickName;
  final String id;
  final int createTime;
  final bool isThumbsUp;
  final int likeCount;

  LectureCommentListModel({
    this.comment,
    this.lectureId,
    this.thumbDown,
    this.thumbUp,
    this.userId,
    this.avatar,
    this.content,
    this.createTime,
    this.isThumbsUp,
    this.likeCount,
    this.nickName,
    this.id,
  });

  factory LectureCommentListModel.fromJson(Map<String, dynamic> json) =>
      _$LectureCommentListModelFromJson(json);

  LectureCommentListModel from(Map<String, dynamic> json) =>
      _$LectureCommentListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['lectureId'] = this.lectureId;
    data['thumbDown'] = this.thumbDown;
    data['thumbUp'] = this.thumbUp;
    data['userId'] = this.userId;
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['isThumbsUp'] = this.isThumbsUp;
    data['likeCount'] = this.likeCount;
    data['nickName'] = this.nickName;
    data['id'] = this.id;
    return data;
  }
}

LectureCommentListModel _$LectureCommentListModelFromJson(
    Map<String, dynamic> json) {
  return LectureCommentListModel(
    comment: json['comment'],
    lectureId: json['lectureId'],
    thumbDown: json['thumbDown'],
    thumbUp: json['thumbUp'],
    userId: json['userId'],
    content: json['content'],
    avatar: json['avatar'],
    createTime: json['createTime'],
    isThumbsUp: json['isThumbsUp'],
    likeCount: json['likeCount'],
    nickName: json['nickName'],
    id: json['id'],
  );
}

/// 获取课件列表
class LectureListRequestModel extends BaseRequest {
  final int page;
  final int limit;

  LectureListRequestModel({@required this.page, @required this.limit});

  @override
  String url() => '/lecture/lectures-List/$page/$limit';
}

/// 律所获取课件列表
class LectureFirmRequestModel extends BaseRequest {
  final String id;
  final int page;
  final int limit;

  LectureFirmRequestModel({
    @required this.page,
    @required this.limit,
    this.id,
  });

  @override
  String url() => '/lecture/firm/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 获取课件列表
*
* @param category string 业务类别id
* @param categoryName string 业务类别名称
* @param charges number 收费标准
* @param content string 课件内容
* @param createTime string 创建时间
* @param id string 课件id
* @param status LecturesStatusEnum
*
* @param code integer($int32)
* @param message string
* @param msg string
* @param title string 标题]
* */

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class LectureListModel {
  final String category;
  final String categoryName;
  final dynamic charges;
  final dynamic isCharge;
  final String content;
  final dynamic cover;
  final String createTime;
  final String id;
  final String lawyerAvatar;
  final String lawyerId;
  final dynamic lawyerName;
  final String status;
  final dynamic subscribeCount;
  final String title;
  final String videoUrl;
  bool delCheck;

  LectureListModel({
    this.isCharge,
    this.category,
    this.categoryName,
    this.charges,
    this.content,
    this.cover,
    this.createTime,
    this.id,
    this.lawyerAvatar,
    this.lawyerId,
    this.lawyerName,
    this.status,
    this.subscribeCount,
    this.title,
    this.videoUrl,
    this.delCheck = false,
  });

  factory LectureListModel.fromJson(Map<String, dynamic> json) =>
      _$LectureListModelFromJson(json);

  LectureListModel from(Map<String, dynamic> json) =>
      _$LectureListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['charges'] = this.charges;
    data['content'] = this.content;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['lawyerAvatar'] = this.lawyerAvatar;
    data['lawyerId'] = this.lawyerId;
    data['lawyerName'] = this.lawyerName;
    data['status'] = this.status;
    data['subscribeCount'] = this.subscribeCount;
    data['title'] = this.title;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

LectureListModel _$LectureListModelFromJson(Map<String, dynamic> json) {
  return LectureListModel(
    category: json['category'],
    isCharge: json['isCharge'],
    categoryName: json['categoryName'],
    charges: json['charges'],
    content: json['content'],
    cover: json['cover'],
    createTime: json['createTime'],
    id: json['id'],
    lawyerAvatar: json['lawyerAvatar'],
    lawyerId: json['lawyerId'],
    lawyerName: json['lawyerName'],
    status: json['status'],
    subscribeCount: json['subscribeCount'],
    title: json['title'],
    videoUrl: json['videoUrl'],
  );
}

/// 其他课件列表
class LectureOtherRequestModel extends BaseRequest {
  final int currentPage;
  final int size;

  LectureOtherRequestModel({@required this.currentPage, @required this.size});

  @override
  String url() => '/lecture/other-lectures/$currentPage/$size';
}

/// 按律师获取课件列表
class LectureLawyerListRequestModel extends BaseRequest {
  final String lawyerId;
  final int limit;
  final int page;

  LectureLawyerListRequestModel({this.lawyerId, this.limit, this.page});

  @override
  String url() => '/lecture/lectures-List/$lawyerId/$page/$limit';
}

/// 获取课件订阅列表（用户订阅情况列表） 我的订阅列表
class LectureSubListRequestModel extends BaseRequest {
  final int limit;
  final int page;

  LectureSubListRequestModel({this.limit, this.page});

  @override
  String url() => '/subscribe/my-lecture/$page/$limit';
}

/*
*  按律师获取课件列表
*
* @param description:  返回课件列表VO
* @param category string 业务类别id
* @param categoryName string 业务类别名称
* @param charges number 收费标准
* @param content string 课件内容
* @param createTime string 创建时间
* @param status status
*
* @param title string 标题]
* */
class LectureLawyerListModel {
  final String category;
  final String categoryName;
  final double charges;
  final String content;
  final String createTime;
  final String status;
  final String title;

  LectureLawyerListModel({
    this.category,
    this.categoryName,
    this.charges,
    this.content,
    this.createTime,
    this.status,
    this.title,
  });

  factory LectureLawyerListModel.fromJson(Map<String, dynamic> json) =>
      _$LectureLawyerListModelFromJson(json);

  LectureLawyerListModel from(Map<String, dynamic> json) =>
      _$LectureLawyerListModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['charges'] = this.charges;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

LectureLawyerListModel _$LectureLawyerListModelFromJson(
    Map<String, dynamic> json) {
  return LectureLawyerListModel(
    category: json['category'],
    categoryName: json['categoryName'],
    charges: json['charges'],
    content: json['content'],
    createTime: json['createTime'],
    status: json['status'],
    title: json['title'],
  );
}

/// 获取课件订阅列表
class LectureSubscriptionRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  LectureSubscriptionRequestModel({this.id, this.limit, this.page});

  @override
  String url() => '/lecture/lecturesSubscription-List/$id/$page/$limit';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 获取课件订阅列表
*
* @param avatar string 头像
* @param charges number 收费标准
* @param createTime string 创建时间
* @param nickName string 昵称]
* */
class LectureSubscriptionModel {
  final String avatar;
  final double charges;
  final String createTime;
  final String nickName;

  LectureSubscriptionModel({
    this.avatar,
    this.charges,
    this.createTime,
    this.nickName,
  });

  factory LectureSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$LectureSubscriptionModelFromJson(json);

  LectureSubscriptionModel from(Map<String, dynamic> json) =>
      _$LectureSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['charges'] = this.charges;
    data['createTime'] = this.createTime;
    data['nickName'] = this.nickName;
    return data;
  }
}

LectureSubscriptionModel _$LectureSubscriptionModelFromJson(
    Map<String, dynamic> json) {
  return LectureSubscriptionModel(
    avatar: json['avatar'],
    charges: json['charges'],
    createTime: json['createTime'],
    nickName: json['nickName'],
  );
}

///获取课件总收入
class LectureGetIncomeRequestModel extends BaseRequest {
  final String id;

  LectureGetIncomeRequestModel({this.id});

  @override
  String url() => '/lecture/get-income/$id';
}

/// 查找付费观看课件
class LectureNotFreeRequestModel extends BaseRequest {
  final String id;

  LectureNotFreeRequestModel(this.id);

  @override
  String url() => '/lecture/notFree/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
*
* @param OK
* @param Example Value
* @param Model 课件详情-律师部分
*
* @param category string 业务类别Id
* @param categoryName string 业务类别
* @param content string 内容
* @param cover string 内容
* @param createTime string 创建时间
* @param dislikeCount integer($int32) 反对数
* @param id string
* @param isCharge integer($int32) 是否收费 0-不收费，1-收费
* @param likeCount integer($int32) 支持数
* @param likeStatus integer($int32) 反对支持状态:0.未点评，1.已支持,2.已反对
* @param nickName string 律师昵称
* @param readCount integer($int32) 阅读量
* @param title string 标题
* */
class LectureDetailsModel {
  final String category;
  final String categoryName;
  final String content;
  final String cover;
  final String createTime;
  int dislikeCount;
  final String id;
  final int isCharge;
  int likeCount;
  int likeStatus;
  final String nickName;
  final String realName;
  final int readCount;
  final String title;
  final String videoUrl;
  bool subscribeStatus;

  LectureDetailsModel({
    this.category,
    this.categoryName,
    this.realName,
    this.content = '',
    this.cover,
    this.createTime,
    this.dislikeCount,
    this.id,
    this.isCharge,
    this.likeCount,
    this.likeStatus,
    this.nickName,
    this.readCount,
    this.title,
    this.videoUrl,
    this.subscribeStatus = false,
  });

  factory LectureDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LectureDetailsModelFromJson(json);

  LectureDetailsModel from(Map<String, dynamic> json) =>
      _$LectureDetailsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['content'] = this.content;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    data['dislikeCount'] = this.dislikeCount;
    data['id'] = this.id;
    data['isCharge'] = this.isCharge;
    data['likeCount'] = this.likeCount;
    data['likeStatus'] = this.likeStatus;
    data['nickName'] = this.nickName;
    data['realName'] = this.realName;
    data['readCount'] = this.readCount;
    data['subscribeStatus'] = this.subscribeStatus;
    data['title'] = this.title;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

LectureDetailsModel _$LectureDetailsModelFromJson(Map<String, dynamic> json) {
  return LectureDetailsModel(
    category: json['category'],
    categoryName: json['categoryName'],
    realName: json['realName'],
    subscribeStatus: json['subscribeStatus'],
    content: json['content'],
    cover: json['cover'],
    createTime: json['createTime'],
    dislikeCount: json['dislikeCount'],
    id: json['id'],
    isCharge: json['isCharge'],
    likeCount: json['likeCount'],
    likeStatus: json['likeStatus'],
    nickName: json['nickName'],
    readCount: json['readCount'],
    title: json['title'],
    videoUrl: json['videoUrl'],
  );
}

///删除课件
class LectureDelRequestModel extends BaseRequest {
  final String id;

  LectureDelRequestModel({
    this.id,
  });

  @override
  String url() => '/lecture/$id';
}

/// 获取课件详情
class LectureDetailsRequestModel extends BaseRequest {
  final String id;

  LectureDetailsRequestModel(this.id);

  @override
  String url() => '/lecture/getDetailLawyer/$id';
}

///获取其他课件列表
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
*  [LecturesChargeVO对象
*
* @param description:  返回的其他付费课件列表VO
* @param charges number 收费标准
* @param content string 内容
* @param title string 标题]
* */
class LecturesOtherModel {
  final double charges;
  final String content;
  final String cover;
  final String title;
  final String id;

  LecturesOtherModel({
    this.charges,
    this.id,
    this.cover,
    this.content,
    this.title,
  });

  factory LecturesOtherModel.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  LecturesOtherModel from(Map<String, dynamic> json) => _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charges'] = this.charges;
    data['content'] = this.content;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['id'] = this.id;
    return data;
  }
}

LecturesOtherModel _$RecordsFromJson(Map<String, dynamic> json) {
  return LecturesOtherModel(
    charges: json['charges'],
    id: json['id'],
    content: json['content'],
    title: json['title'],
    cover: json['cover'],
  );
}
