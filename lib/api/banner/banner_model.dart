import 'package:jh_legal_affairs/util/tools.dart';

/*
* 添加banner图
*
* @param createTime string($date-time) 记录创建时间
* @param deleted integer($int32) 删除标记,0表示没有被删除，1表示主动删除，2表示被动删除
* @param id string
* @param isShow integer($int32) 是否显示（0：不显、1：显示）
* @param title string 名称
* @param type integer($int32) 0：首页banner、1：运用banner、2：广告banner
* @param updateTime string($date-time) 记录更新时间
* @param url string 图片路径
* */
class BannerAddRequestModel extends BaseRequest {
  final String createTime;
  final int deleted;
  final String id;
  final int isShow;
  final String title;
  final int type;
  final String updateTime;
  final String bannerUrl;

  BannerAddRequestModel({
    this.createTime,
    this.deleted,
    this.id,
    this.isShow,
    this.title,
    this.type,
    this.updateTime,
    this.bannerUrl,
  });

  @override
  String url() => '/banner';

  @override
  Map<String, dynamic> toJson() {
    return {
      "createTime": this.createTime,
      "deleted": this.deleted,
      "id": this.id,
      "isShow": this.isShow,
      "title": this.title,
      "type": this.type,
      "updateTime": this.updateTime,
      "url": this.bannerUrl
    };
  }
}

/// 首页、律所、律师、业务 banner图列表
class BannerListRequestModel extends BaseRequest {
  final String createTime;
  final int deleted;
  final String id;
  final int isShow;
  final String title;
  final int type;
  final String updateTime;
  final String bannerUrl;

  BannerListRequestModel({
    this.createTime,
    this.deleted,
    this.id,
    this.isShow,
    this.title,
    this.type,
    this.updateTime,
    this.bannerUrl,
  });

  @override
  String url() => '/banner/banners';

  @override
  Map<String, dynamic> toJson() {
    return {
      "createTime": this.createTime,
      "deleted": this.deleted,
      "id": this.id,
      "isShow": this.isShow,
      "title": this.title,
      "type": this.type,
      "updateTime": this.updateTime,
      "url": this.bannerUrl,
    };
  }
}

/// 修改banner图状态
class BannerChangeRequestModel extends BaseRequest {
  final String id;
  final int isShow;
  final String title;
  final int type;
  final String bannerUrl;

  BannerChangeRequestModel({
    this.id,
    this.isShow,
    this.title,
    this.type,
    this.bannerUrl,
  });

  @override
  String url() => '/banner';

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "isShow": this.isShow,
      "title": this.title,
      "type": this.type,
      "url": this.bannerUrl
    };
  }
}

/// 删除banner图
class BannerDelRequestModel extends BaseRequest {
  final String id;

  BannerDelRequestModel({this.id});

  @override
  String url() => '/banner/$id';

  @override
  Map<String, dynamic> toJson() {
    return {"id": this.id};
  }
}
