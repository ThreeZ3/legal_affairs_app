import 'package:jh_legal_affairs/http/base_request.dart';

/// 首页请求示例
class HomeRequestModel extends BaseRequest {
  /// 请求参数的定义
  final String index;
  final int pageSize;

  /// 请求参数的构造
  HomeRequestModel({
    this.index,
    this.pageSize,
  });

  /// 请求的Url，也就是路径
  @override
  String url() => 'mobile/public/api/wx/index';

  /// 请求参数json
  @override
  Map<String, dynamic> toJson() {
    return {
      'index': this.index,
      'pageSize': this.pageSize,
    };
  }
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************
/// 假设这是Home接口的响应数据
class HomeModel {
  final int code;
  final Map data;

  HomeModel({
    this.code,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  HomeModel from(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    code: json['code'],
    data: json['data'],
  );
}

/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

class StoreModel {
  final int shopId;
  final int userId;
  final String rzShopName;
  final int sortOrder;
  final Sellershopinfo sellershopinfo;
  final List<dynamic> goods;

  StoreModel({
    this.shopId,
    this.userId,
    this.rzShopName,
    this.sortOrder,
    this.sellershopinfo,
    this.goods,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  StoreModel from(Map<String, dynamic> json) => _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['rz_shopName'] = this.rzShopName;
    data['sort_order'] = this.sortOrder;
    if (this.sellershopinfo != null) {
      data['sellershopinfo'] = this.sellershopinfo.toJson();
    }
    if (this.goods != null) {
      data['goods'] = this.goods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) {
  return StoreModel(
    shopId: json['shop_id'],
    userId: json['user_id'],
    rzShopName: json['rz_shopName'],
    sortOrder: json['sort_order'],
    sellershopinfo: json['sellershopinfo'] != null
        ? new Sellershopinfo.fromJson(json['sellershopinfo'])
        : null,
    goods: json['goods'].map((item) {
      return new Goods.fromJson(item);
    }).toList(),
  );
}

class Sellershopinfo {
  final String logoThumb;
  final int ruId;
  final String streetThumb;

  Sellershopinfo({
    this.logoThumb,
    this.ruId,
    this.streetThumb,
  });

  factory Sellershopinfo.fromJson(Map<String, dynamic> json) =>
      _$SellershopinfoFromJson(json);

  Sellershopinfo from(Map<String, dynamic> json) =>
      _$SellershopinfoFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo_thumb'] = this.logoThumb;
    data['ru_id'] = this.ruId;
    data['street_thumb'] = this.streetThumb;
    return data;
  }
}

Sellershopinfo _$SellershopinfoFromJson(Map<String, dynamic> json) {
  return Sellershopinfo(
    logoThumb: json['logo_thumb'],
    ruId: json['ru_id'],
    streetThumb: json['street_thumb'],
  );
}

class Goods {
  final int goodsId;
  final String goodsName;
  final String goodsThumb;

  Goods({
    this.goodsId,
    this.goodsName,
    this.goodsThumb,
  });

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

  Goods from(Map<String, dynamic> json) => _$GoodsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_thumb'] = this.goodsThumb;
    return data;
  }
}

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return Goods(
    goodsId: json['goods_id'],
    goodsName: json['goods_name'],
    goodsThumb: json['goods_thumb'],
  );
}
