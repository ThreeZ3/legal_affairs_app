import 'package:jh_legal_affairs/util/tools.dart';

///获取当前用户视频
class VideoListRequestModel extends BaseRequest {
  final int page;
  final int limit;
  final String id;

  VideoListRequestModel({
    this.page,
    this.limit,
    this.id,
  });

  @override
  String url() => '/lawyer-video/my-video/$page/$limit/$id';
}

///获取视频列表
class AllVideoListRequestModel extends BaseRequest {
  final int page;
  final int limit;
  final String id;

  AllVideoListRequestModel({
    this.page,
    this.limit,
    this.id,
  });

  @override
  String url() => '/lawyer-video/video/$page/$limit';
}

///新增视频
class VideoPostRequestModel extends BaseRequest {
  final String dataUrl;
  final String title;
  final String cover;
  final String summary;

  VideoPostRequestModel({
    this.dataUrl,
    this.title,
    this.cover,
    this.summary,
  });

  @override
  String url() => '/lawyer-video/video';

  Map<String, dynamic> toJson() {
    return {
      "dataUrl": this.dataUrl,
      "title": this.title,
      "cover": this.cover,
      "summary": this.summary,
    };
  }
}

///查看视频
class VideoListSeeRequestModel extends BaseRequest {
  final String id;

  VideoListSeeRequestModel({this.id});

  @override
  String url() => '/lawyer-video/video/see/$id';
}

///删除视频
class VideoListDelRequestModel extends BaseRequest {
  final String id;

  VideoListDelRequestModel({this.id});

  @override
  String url() => '/lawyer-video/video/$id';
}

///首页视频
class VideoListHomeRequestModel extends BaseRequest {
  @override
  String url() => '/index/new-video';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************
/*
* [LawyerVideoVO
*
* @param count string 观看数
* @param cover string 封面
* @param createTime string($date-time) 视频发布时间
* @param dataUrl string 数据地址
* @param id string 视频id
* @param nickName string 用户昵称
* @param title string 标题
* @param userId string 律师id]

* */

///获取当前用户视频数组模型
class VideoDataModel {
  String count;
  final String cover;
  final int createTime;
  final String dataUrl;
  final String id;
  final String nickName;
  final String title;
  final String userId;
  final String summary;
  final int index;

  VideoDataModel({
    this.count,
    this.cover,
    this.createTime,
    this.dataUrl,
    this.id,
    this.nickName,
    this.title,
    this.userId,
    this.summary,
    this.index,
  });

//  factory VideoDataModel.fromJson(Map<String, dynamic> json) =>
//      _$VideoDataModelFromJson(json);

  VideoDataModel from(Map<String, dynamic> json) =>
      _$VideoDataModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    data['dataUrl'] = this.dataUrl;
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['title'] = this.title;
    data['userId'] = this.userId;
    return data;
  }

  VideoDataModel _$VideoDataModelFromJson(Map<String, dynamic> json) {
    return VideoDataModel(
      count: json['count'],
      cover: json['cover'],
      createTime: json['createTime'],
      dataUrl: json['dataUrl'],
      id: json['id'],
      nickName: json['nickName'],
      title: json['title'],
      userId: json['userId'],
      summary: json['summary'],
      index: this.index,
    );
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* count string 观看数
* @param cover string 封面
* @param createTime string($date-time) 视频发布时间
* @param dataUrl string 数据地址
* @param id string 视频id
* @param nickName string 用户昵称
* @param title string 标题
* @param userId string 律师id
* */

class HomeVideoModel {
  final String count;
  final String cover;
  final int createTime;
  final String dataUrl;
  final String id;
  final String nickName;
  final String title;
  final String userId;

  HomeVideoModel({
    this.count,
    this.cover,
    this.createTime,
    this.dataUrl,
    this.id,
    this.nickName,
    this.title,
    this.userId,
  });

  factory HomeVideoModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  HomeVideoModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    data['dataUrl'] = this.dataUrl;
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['title'] = this.title;
    data['userId'] = this.userId;
    return data;
  }
}

HomeVideoModel _$DataFromJson(Map<String, dynamic> json) {
  return HomeVideoModel(
    count: json['count'],
    cover: json['cover'],
    createTime: json['createTime'],
    dataUrl: json['dataUrl'],
    id: json['id'],
    nickName: json['nickName'],
    title: json['title'],
    userId: json['userId'],
  );
}
