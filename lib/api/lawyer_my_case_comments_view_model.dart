import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/lawyer_my_case_comments_model.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class LawyerMyCaseCommentsViewModel extends BaseViewModel {
  Future<ResponseModel> getLawyerMyCaseComments(BuildContext context) async {
    print('进入getLawyerMyCaseComments方法');
    ResponseModel data = await LawyerMyCaseCommentsRequestModel()
        .sendApiAction(context, hud: '请求中')
        .then((rep) {
      LawyerMyCaseCommentsModel model = LawyerMyCaseCommentsModel.fromJson(rep);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
