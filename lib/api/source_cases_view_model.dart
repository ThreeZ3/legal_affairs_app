import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/source_cases_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

typedef SourceCasesData = Function(List model);

/// 我的案源-ViewModel
class SourceCasesViewModel extends BaseViewModel {
  Future<ResponseModel> getSourceCases(
    BuildContext context, {
    String lawyerId,
    int status,
    SourceCasesData sourceCasesData,
  }) async {
    ResponseModel data = await SourceCasesRequestModel(
      lawyerId: lawyerId,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      SourceCasesModel model = SourceCasesModel.fromJson(rep);

      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
