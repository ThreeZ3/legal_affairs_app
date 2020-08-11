
/// **************************************************************************
/// 来自金慧科技Json转Dart工具
/// **************************************************************************

/*
* [订阅情况
*
* @param charges number 收费标准
* @param createTime string 创建时间
* @param nickName string 昵称]
* */

class LecturesSubscriptionModel {
  final double charges;
  final String createTime;
  final String nickName;

  LecturesSubscriptionModel({
    this.charges,
    this.createTime,
    this.nickName,
  });

  factory LecturesSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  LecturesSubscriptionModel from(Map<String, dynamic> json) => _$RecordsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charges'] = this.charges;
    data['createTime'] = this.createTime;
    data['nickName'] = this.nickName;
    return data;
  }
}

LecturesSubscriptionModel _$RecordsFromJson(Map<String, dynamic> json) {
  return LecturesSubscriptionModel(
    charges: json['charges'],
    createTime: json['createTime'],
    nickName: json['nickName'],
  );
}