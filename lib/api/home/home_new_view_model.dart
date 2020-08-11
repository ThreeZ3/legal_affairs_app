import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_new_consult_model.dart';
import 'package:jh_legal_affairs/api/sketch/sketch_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class HomeNewConsultRequestViewModel extends BaseViewModel {
  Future<ResponseModel> getNewConsultData(BuildContext context) async {
    ResponseModel data = await GetNewRequestModel()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      List listData = dataModelListFromJson(rep['data']['records'], Records());
      return ResponseModel.fromSuccess(listData);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}

List dataModelListFromJson(data, model, [dataController]) {
  List repData = data;

  assert(repData is List);

  List list = new List();

  repData.forEach((json) => list.add(model.from(json)));

  return list;
}

List dataModelListFromJsonIndex(data, model, [dataController]) {
  List repData = data;

  assert(repData is List);

  List list = new List();
  for (int i = 0; i < repData.length; i++) {
    list.add(model.from(repData[i], index: i));
  }

  return list;
}
