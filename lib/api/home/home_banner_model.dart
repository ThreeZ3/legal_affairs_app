import 'package:jh_legal_affairs/http/base_request.dart';

///首页广告
///
class HomeBannerRequest extends BaseRequest {
  @override
  String url() => "/banner/banners/1";
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class HomeBannerModel {
  int code;
  List<HomeBannerDataModel> data;
  String msg;

  HomeBannerModel({
    this.code,
    this.data,
    this.msg,
  });

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<HomeBannerDataModel>();
      json['data'].forEach((v) {
        data.add(new HomeBannerDataModel.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  HomeBannerModel from(Map<String, dynamic> json) =>
      _$HomeBannerModelFromJson(json);

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

HomeBannerModel _$HomeBannerModelFromJson(Map<String, dynamic> json) {
  return HomeBannerModel(
    code: json['code'],
    data: json['data'].map((item) {
      return new HomeBannerDataModel.fromJson(item);
    }).toList(),
    msg: json['msg'],
  );
}

class HomeBannerDataModel {
  final int createTime;
  final Null deleted;
  final String id;
  final int isShow;
  final String title;
  final int type;
  final int updateTime;
  final String url;

  HomeBannerDataModel({
    this.createTime,
    this.deleted,
    this.id,
    this.isShow,
    this.title,
    this.type,
    this.updateTime,
    this.url,
  });

  factory HomeBannerDataModel.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  HomeBannerDataModel from(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['deleted'] = this.deleted;
    data['id'] = this.id;
    data['isShow'] = this.isShow;
    data['title'] = this.title;
    data['type'] = this.type;
    data['updateTime'] = this.updateTime;
    data['url'] = this.url;
    return data;
  }
}

HomeBannerDataModel _$DataFromJson(Map<String, dynamic> json) {
  return HomeBannerDataModel(
    createTime: json['createTime'],
    deleted: json['deleted'],
    id: json['id'],
    isShow: json['isShow'],
    title: json['title'],
    type: json['type'],
    updateTime: json['updateTime'],
    url: json['url'],
  );
}
