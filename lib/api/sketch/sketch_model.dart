import 'package:jh_legal_affairs/util/tools.dart';

/*
* 查询用户发表图文列表
*
* category
* @param string  业务类别
* @param current
* @param integer($int64)
* @param detail
* @param string  图文详情
* @param lawyerId
* @param string  律所id
* @param records
* @param array[object]
* @param size
* @param integer($int64)
* @param title
* @param string  图文标题
* @param total
* @param integer($int64)
* */
class SketchListRequestModel extends BaseRequest {
  final int limit;
  final int page;

  SketchListRequestModel({
    this.limit,
    this.page,
  });

  @override
  String url() => '/sketch/list-all/$page/$limit';

  @override
  Map<String, dynamic> toJson() {
    return {
      "limit": this.limit,
      "page": this.page,
    };
  }
}

/// 律所获取图文咨询列表
class SketchFirmRequestModel extends BaseRequest {
  final String id;
  final int limit;
  final int page;

  SketchFirmRequestModel({
    this.id,
    this.limit,
    this.page,
  });

  @override
  String url() => '/sketch/firm/$id/$page/$limit';
}

/// 通过用户id查询用户发表图文列表
class SketchMyListRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  SketchMyListRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/sketch/my-list/$page/$limit/$id';
}

/*
* 发布图文
*
* @param description:  图文表
* @param category string 业务类别
* @param collections integer($int32) 收藏数量
* @param createTime string($date-time) 记录创建时间
* @param deleted integer($int32) 删除标记,0表示没有被删除，1表示主动删除，2表示被动删除
* @param detail string 图文详情
* @param id string 图文id
* @param lawyerId string 律所id
* @param read integer($int32) 已读数量
* @param title string 图文标题
* @param updateTime string($date-time) 记录更新时间
* */
class SketchReleaseRequestModel extends BaseRequest {
  final String category;
  final String describe;
  final String detail;
  final String id;
  final String title;
  final String footUrl;
  final String headUrl;
  final String pictures;

  SketchReleaseRequestModel({
    this.category,
    this.describe,
    this.detail,
    this.id,
    this.title,
    this.footUrl,
    this.headUrl,
    this.pictures,
  });

  @override
  String url() => '/sketch';

  @override
  Map<String, dynamic> toJson() {
    return {
      "category": this.category,
      "describe": this.describe,
      "detail": this.detail,
      "id": this.id,
      "title": this.title,
      "footUrl": this.footUrl,
      "headUrl": this.headUrl,
      "pictures": this.pictures,
    };
  }
}

/// 图文赞成
class SketchAgreeRequestModel extends BaseRequest {
  final String sketchId;
  final String userId;

  SketchAgreeRequestModel({
    this.sketchId,
    this.userId,
  });

  @override
  String url() => '/sketch/agreement';

  @override
  Map<String, dynamic> toJson() {
    return {
      "sketchId": this.sketchId,
      "userId": this.userId,
    };
  }
}

/// 图文反对
class SketchOppositionRequestModel extends BaseRequest {
  final String sketchId;
  final String userId;

  SketchOppositionRequestModel({
    this.sketchId,
    this.userId,
  });

  @override
  String url() => '/sketch/opposition';

  @override
  Map<String, dynamic> toJson() {
    return {
      "sketchId": this.sketchId,
      "userId": this.userId,
    };
  }
}

/// 通过id查询图文详情
class SketchDetailRequestModel extends BaseRequest {
  final String id;

  SketchDetailRequestModel(this.id);

  @override
  String url() => '/sketch/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* SketchDetailVO
*
* @param avatar string 律师头像
* @param category string 业务类别id
* @param categoryName string 业务类别名称
* @param collections integer($int32) 收藏数量
* @param createTime string($date-time) 发布时间
* @param detail string 图文详情
* @param dislike integer($int32) 反对
* @param footUrl string 尾部图片链接
* @param headUrl string 头部图片链接
* @param id string 图文id
* @param lawyerAvatar string 发布者头像
* @param lawyerId string 律师id
* @param lawyerName string 发布者名称
* @param like integer($int32) 支持
* @param reading integer($int32) 已读数量
* @param realName string 律师名称
* @param status SketchStatusEnum
* ...}
* @param title string 图文标题
* */
class SketchDetailsModel {
  final String avatar;
  final String category;
  final String categoryName;
  final int collections;
  final int createTime;
  final String detail;
  int dislike;
  final String footUrl;
  final String headUrl;
  final String id;
  final dynamic lawyerAvatar;
  final String lawyerId;
  final dynamic lawyerName;
  int like;
  final int likeStatus;
  final int reading;
  final String realName;
  final String status;
  final String title;

  SketchDetailsModel({
    this.avatar,
    this.category,
    this.categoryName,
    this.collections,
    this.createTime,
    this.detail,
    this.dislike,
    this.footUrl,
    this.headUrl,
    this.id,
    this.lawyerAvatar,
    this.lawyerId,
    this.lawyerName,
    this.like,
    this.likeStatus,
    this.reading,
    this.realName,
    this.status,
    this.title,
  });

  factory SketchDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SketchDetailsModelFromJson(json);

  SketchDetailsModel from(Map<String, dynamic> json) =>
      _$SketchDetailsModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['collections'] = this.collections;
    data['createTime'] = this.createTime;
    data['detail'] = this.detail;
    data['dislike'] = this.dislike;
    data['footUrl'] = this.footUrl;
    data['headUrl'] = this.headUrl;
    data['id'] = this.id;
    data['lawyerAvatar'] = this.lawyerAvatar;
    data['lawyerId'] = this.lawyerId;
    data['lawyerName'] = this.lawyerName;
    data['like'] = this.like;
    data['likeStatus'] = this.likeStatus;
    data['reading'] = this.reading;
    data['realName'] = this.realName;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

SketchDetailsModel _$SketchDetailsModelFromJson(Map<String, dynamic> json) {
  return SketchDetailsModel(
    avatar: json['avatar'],
    category: json['category'],
    categoryName: json['categoryName'],
    collections: json['collections'],
    createTime: json['createTime'],
    detail: json['detail'],
    dislike: json['dislike'],
    footUrl: json['footUrl'],
    headUrl: json['headUrl'],
    id: json['id'],
    lawyerAvatar: json['lawyerAvatar'],
    lawyerId: json['lawyerId'],
    lawyerName: json['lawyerName'],
    like: json['like'],
    likeStatus: json['likeStatus'],
    reading: json['reading'],
    realName: json['realName'],
    status: json['status'],
    title: json['title'],
  );
}

/// 批量删除图文,id间用 ; 隔开
class SketchDeletesRequestModel extends BaseRequest {
  final String ids;

  SketchDeletesRequestModel(this.ids);

  @override
  String url() => '/sketch$ids';
}

/// updateSketchcollect  图文收藏
class SketchCollectionRequestModel extends BaseRequest {
  final String id;

  SketchCollectionRequestModel(this.id);

  @override
  String url() => '/sketch/collection/$id';
}

/// updateSketchnotcollect  图文取消收藏
class SketchNotCollectionRequestModel extends BaseRequest {
  final String id;

  SketchNotCollectionRequestModel(this.id);

  @override
  String url() => '/sketch/notcollection/$id';
}

/// updateSketchread  更新图文读
class SketchReadRequestModel extends BaseRequest {
  final String id;

  SketchReadRequestModel(this.id);

  @override
  String url() => '/sketch/read/$id';
}

/// 图文咨询分享
class SketchShareRequestModel extends BaseRequest {
  final String id;

  SketchShareRequestModel(this.id);

  @override
  String url() => '/sketch/share/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 图文点评操作  图文点评（支持反对）
*
* @param sketchId string 图文id
* @param status integer($int32) 操作类型:1.支持，2.反对
* */
class SketchCommentRequestModel extends BaseRequest {
  final String sketchId;
  final int status;

  SketchCommentRequestModel({
    this.sketchId,
    this.status,
  });

  @override
  String url() => '/sketch/comment';

  @override
  Map<String, dynamic> toJson() {
    return {
      "sketchId": this.sketchId,
      "status": this.status,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* IPage«SketchListVO»
*
* @param current integer($int64)
* @param pages integer($int64)
* @param records [SketchListVO
*
* @param category string 业务类别id
* @param categoryName string 业务类别名称
* @param collections integer($int32) 收藏数量
* @param detail string 图文详情
* @param dislike integer($int32) 反对
* @param id string 图文id
* @param like integer($int32) 支持
* @param reading integer($int32) 已读数量
* @param status SketchStatusEnum
* ...}
* @param title string 图文标题]
* @param searchCount boolean
* @param size integer($int64)
* @param total integer($int64)
* */
class SketchListModel {
  final int current;
  final int pages;
  final List<Records> records;
  final bool searchCount;
  final int size;
  final int total;

  SketchListModel({
    this.current,
    this.pages,
    this.records,
    this.searchCount,
    this.size,
    this.total,
  });

  factory SketchListModel.fromJson(Map<String, dynamic> json) =>
      _$SketchListModelFromJson(json);

  SketchListModel from(Map<String, dynamic> json) =>
      _$SketchListModelFromJson(json);

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

SketchListModel _$SketchListModelFromJson(Map<String, dynamic> json) {
  return SketchListModel(
    current: json['current'],
    pages: json['pages'],
    records: json['records'].map((item) {
      return new Records.fromJson(item);
    }).toList(),
    searchCount: json['searchCount'],
    size: json['size'],
    total: json['total'],
  );
}

class Records {
  final String category;
  final String categoryName;
  final int collections;
  final String describe;
  final int dislike;
  final String id;
  final String lawyerAvatar;
  final String lawyerId;
  final String lawyerName;
  final int like;
  final String pictures;
  final int reading;
  final String status;
  final String title;
  final int shareCount;
  final int commentsCount;
  final int createTime;
  bool delCheck;

  Records({
    this.category,
    this.categoryName,
    this.collections,
    this.describe,
    this.dislike,
    this.id,
    this.lawyerAvatar,
    this.commentsCount,
    this.lawyerId,
    this.lawyerName,
    this.like,
    this.pictures,
    this.reading,
    this.status,
    this.title,
    this.shareCount,
    this.createTime,
    this.delCheck = false,
  });

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Records from(Map<String, dynamic> json) => _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['commentsCount'] = this.commentsCount;
    data['collections'] = this.collections;
    data['describe'] = this.describe;
    data['dislike'] = this.dislike;
    data['id'] = this.id;
    data['lawyerAvatar'] = this.lawyerAvatar;
    data['lawyerId'] = this.lawyerId;
    data['lawyerName'] = this.lawyerName;
    data['like'] = this.like;
    data['pictures'] = this.pictures;
    data['reading'] = this.reading;
    data['status'] = this.status;
    data['title'] = this.title;
    data['shareCount'] = this.shareCount;
    data['createTime'] = this.createTime;
    return data;
  }
}

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return Records(
    category: json['category'],
    categoryName: json['categoryName'],
    collections: json['collections'],
    commentsCount: json['commentsCount'],
    describe: json['describe'],
    dislike: json['dislike'],
    id: json['id'],
    lawyerAvatar: json['lawyerAvatar'],
    lawyerId: json['lawyerId'],
    lawyerName: json['lawyerName'],
    like: json['like'],
    pictures: json['pictures'],
    reading: json['reading'],
    status: json['status'],
    title: json['title'],
    shareCount: json['shareCount'],
    createTime: json['createTime'],
  );
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
