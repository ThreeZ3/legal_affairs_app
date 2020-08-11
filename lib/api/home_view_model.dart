import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/home_model.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

typedef StoreData = Function(List model);

/// 首页 ViewModel 示例
class HomeViewModel extends BaseViewModel {
  /// 调用的方法，返回结果为ResponseModel
  /// 方法接收从view层传过来的参数
  /// 比如：index 和 pageSize
  Future<ResponseModel> getHome(
    BuildContext context, {
    String index, // 请求参数index
    int pageSize, // 请求参数pageSize
    StoreData storeData,
  }) async {
    print('进入getHome方法');

    /// HomeRequestModel 为调用请求Model
    /// 并且把接收的参数进行传递
    ResponseModel data = await HomeRequestModel(
      index: index, // 从方法拿的请求参数index
      pageSize: pageSize, // 从方法拿的请求参数pageSize
    )
        .sendApiAction(
      // sendApiAction 为发送api活动进行取数据
      context, // 拿上下文进行显示请求中对话框
      reqType: ReqType.get, // 请求类型枚举
      hud: '请求中', // 请求中对话框提示文本，如为空则不显示
    )
        .then((rep) {
      // 拿到数据继续执行
//      Map data = rep['data']; // 从数据内使用下标形式拿到data数据
      HomeModel model = HomeModel.fromJson(rep); // 进行json数据转数据模型
      List storeList = model.data['ad']['store'];
      List storeModelList =
          dataModelListFromJson(storeList, StoreModel());
      storeData(storeModelList);
      return ResponseModel.fromSuccess(model); // 返回一个成功的ResponseModel
    }).catchError((e) {
      // 异常处理
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
