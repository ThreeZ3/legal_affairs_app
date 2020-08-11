import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/http/base_request.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/model/firm_list_model.dart';

import '../util/tools.dart';

FirmListViewModel firmListViewModel = new FirmListViewModel();

class FirmListViewModel extends BaseViewModel {
  Future<ResponseModel> firmList(
    BuildContext context, {
    final int page,
    final int limit,
    final String name,
    final String typeId,
    final int orderType,
    final String city,
    final String district,
    final String province,
    final int maxRank,
    final int maxRange,
  }) async {
    ResponseModel data = await FirmListRequestModel(
      lat: '${location?.latitude ?? '0'}',
      lng: '${location?.longitude ?? '0'}',
      city: city,
      district: district,
      province: province,
      page: page,
      limit: limit,
      name: name,
      typeId: typeId,
      orderType: orderType,
      maxRank: maxRank,
      maxRange: maxRange,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], new FirmListModel());
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
