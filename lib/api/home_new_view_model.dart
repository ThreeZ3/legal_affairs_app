import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_new_view_model.dart';
import 'package:jh_legal_affairs/api/home_new_consult_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class HomeNewConsultRequestViewModel extends BaseViewModel {
  Future<ResponseModel> getNewConsultData(BuildContext context) async {
    ResponseModel data = await GetNewRequestModel()
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(
          rep['data']['records'], new GetNewsDataRecordsModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///分页获取所有咨询
  Future<ResponseModel> getAllNewConsultData(
    BuildContext context, {
    final int page,
    final int limit,
  }) async {
    ResponseModel data = await GetAllNewRequestModel(
      page: page,
      limit: limit,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(
          rep['data']['records'], new ConsultAllModel());
      if (page > 1 && !listNoEmpty(data)) {
        throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
