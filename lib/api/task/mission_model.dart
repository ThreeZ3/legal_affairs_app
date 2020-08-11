import 'package:jh_legal_affairs/http/base_request.dart';

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* 发布任务
*
* @param description:  任务表
* @param ask string 要价
* @param category string 业务类别
* @param content string 简介
* @param deleted integer($int32) 删除任务
* @param id string 用户id
* @param lawyerId string 律师id
* @param limit string($date-time) 时限
* @param require string 要求
* @param underTakes string 承接人；lawyer表id
* */
class MissionReleaseDetailRequestModel extends BaseRequest {
  final String ask;
  final String categoryId;
  final String content;
  final String id;
  final int limit;
  final String title;
  final String require;

  MissionReleaseDetailRequestModel({
    this.require,
    this.ask,
    this.categoryId,
    this.content,
    this.id,
    this.limit,
    this.title,
  });

  @override
  String url() => '/mission';

  @override
  Map<String, dynamic> toJson() {
    return {
      "ask": this.ask,
      "categoryId": this.categoryId,
      "content": this.content,
      "id": this.id,
      "limit": this.limit,
      "title": this.title,
      "require": this.require,
    };
  }
}

/// 用户发布的任务列表 - 获取当前用户发布的任务列表
class UserMissionRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  UserMissionRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/mission/cur-list/$page/$limit/$id';
}

/// 用户承载的任务列表
class MissionUnderTakeRequestModel extends BaseRequest {
  final int limit;
  final int page;
  final String id;

  MissionUnderTakeRequestModel({
    this.limit,
    this.page,
    this.id,
  });

  @override
  String url() => '/mission/under-take/$page/$limit/$id';
}

/// 最新任务
class NewMissionRequestModel extends BaseRequest {
  @override
  String url() => '/index/new-mission';
}

///分页获取所有任务
class MissionPublishingRequestModel extends BaseRequest {
  final int limit;
  final int page;

  MissionPublishingRequestModel({
    this.limit,
    this.page,
  });

  @override
  String url() => '/mission/publishingPage/$page/$limit';
}

/// 承接任务  文档有误，此地正确
class MissionTakeRequestModel extends BaseRequest {
  final String id;

  MissionTakeRequestModel(
    this.id,
  );

  @override
  String url() => '/mission/undertake/$id';
}

/// 多选删除我的任务
class DeletesMissionRequestModel extends BaseRequest {
  final String ids;

  DeletesMissionRequestModel(this.ids);

  @override
  String url() => '/mission/bulk-Missions/$ids';
}

/// 删除任务
class DeleteMissionRequestModel extends BaseRequest {
  final String id;

  DeleteMissionRequestModel(this.id);

  @override
  String url() => '/mission/$id';
}
