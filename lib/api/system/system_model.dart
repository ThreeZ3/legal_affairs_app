import 'dart:io';
import 'package:jh_legal_affairs/util/tools.dart';

/// 获取系统消息列表
class SystemNotificationRequestModel extends BaseRequest {
  @override
  String url() => '/notification/list';
}

/// 根据id获取系统消息详情
class SystemMsgDetailsRequestModel extends BaseRequest {
  final String id;

  SystemMsgDetailsRequestModel(this.id);

  @override
  String url() => '/notification/$id';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* Notifications对象
* 
* @param description:  系统消息表
* @param content string 消息内容
* @param id string
* @param poster string 发布者
* @param reader string 接收者
* @param title string 消息标题
* @param type string 消息类型
* */
class NotificationModel {
  final String content;
  final String id;
  final String poster;
  final String reader;
  final String title;
  final String type;

  NotificationModel({
    this.content,
    this.id,
    this.poster,
    this.reader,
    this.title,
    this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  NotificationModel from(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['poster'] = this.poster;
    data['reader'] = this.reader;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    content: json['content'],
    id: json['id'],
    poster: json['poster'],
    reader: json['reader'],
    title: json['title'],
    type: json['type'],
  );
}

/// 申请添加任务类型
class LegalFieldRequestModel extends BaseRequest {
  final String name;

  LegalFieldRequestModel({this.name});

  @override
  String url() => '/legal-field';

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
    };
  }
}

/// 获取所有通过审核的任务类型
class LegalFieldListRequestModel extends BaseRequest {
  @override
  String url() => '/legal-field/passList';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [#/definitions/SysLegalFieldVo数据信息SysLegalFieldVo数据信息
*
* @param id string 类型id
* @param name string 类型名称]
* */
class CategoryModel {
  final String id;
  final String name;
  bool isType;
  double weight = 0;
  final String type;

  CategoryModel({
    this.id = '0',
    this.name = 'test',
    this.isType = false,
    this.type = '类别',
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  String toString() => 'id:$id,,name:$name';

  CategoryModel from(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['id'],
    name: json['name'],
  );
}

/// 上传文件
class UploadFileRequestModel extends BaseRequest {
  final File file;

  UploadFileRequestModel(this.file);

  @override
  String url() => '/upload/file';

  @override
  Map<String, dynamic> toJson() {
    return {
      'file': this.file,
    };
  }
}

/// testOss
class OssRequestModel extends BaseRequest {
  final File file;

  OssRequestModel(this.file);

  @override
  String url() => 'http://img-strategymall.qqtowns.com';

  @override
  Map<String, dynamic> toJson() {
    return {
      'file': this.file,
    };
  }
}

/// 获取最新版本
class VersionsRequestModel extends BaseRequest {
  @override
  String url() => '/versions';
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* description:  广告表
* @param appType integer($int32)
* @param App类型:1.安卓，2.ios,3.小程序
* @param content string 更新内容
* @param id string
* @param isSensitive integer($int32) 是否敏感信:1.是，0.否
* @param isUpdate integer($int32) 是否强制更新：1.是，0.否
* @param url string 下载链接
* @param version string 版本号
* */
class VersionModel {
  final int appType;
  final String content;
  final int createTime;
  final Null deleted;
  final String id;
  final int isSensitive;
  final int isUpdate;
  final int updateTime;
  final String url;
  final String version;

  VersionModel({
    this.appType,
    this.content,
    this.createTime,
    this.deleted,
    this.id,
    this.isSensitive,
    this.isUpdate,
    this.updateTime,
    this.url,
    this.version,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  VersionModel from(Map<String, dynamic> json) => _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appType'] = this.appType;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['id'] = this.id;
    data['isSensitive'] = this.isSensitive;
    data['isUpdate'] = this.isUpdate;
    data['updateTime'] = this.updateTime;
    data['url'] = this.url;
    data['version'] = this.version;
    return data;
  }
}

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return VersionModel(
    appType: json['appType'],
    content: json['content'],
    createTime: json['createTime'],
    deleted: json['deleted'],
    id: json['id'],
    isSensitive: json['isSensitive'],
    isUpdate: json['isUpdate'],
    updateTime: json['updateTime'],
    url: json['url'],
    version: json['version'],
  );
}
