import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/home/homepage_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

//课件viewmodel
class HomeCourseWareRequestViewModel extends BaseViewModel {
  Future<ResponseModel> getCourseWareData(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await CourseWareRequestModel(
      page: page,
      limit: limit,
    ).sendApiAction(context, reqType: ReqType.get).then((rep) {
      List homeLecturesModel =
          dataModelListFromJson(rep['data']['records'], HomeLecturesModel());

      if (!listNoEmpty(homeLecturesModel) && page > 1) {
        showToast(context, "没有更多的数据了");
      }
      return ResponseModel.fromSuccess(homeLecturesModel);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
