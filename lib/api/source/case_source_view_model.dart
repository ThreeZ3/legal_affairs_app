import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/source/case_source_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';

CaseSourceViewModel caseSourceViewModel = new CaseSourceViewModel();

class CaseSourceViewModel extends BaseViewModel {
  /// 获取案源详细
  Future<ResponseModel> caseSourceDetail(
    BuildContext context, {
    String sourceCaseId,
  }) async {
    ResponseModel data = await SourceCaseDetailRequestModel(
      sourceCaseId: sourceCaseId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除案源
  Future<ResponseModel> caseSourceDelete(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SourceCaseDelRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      Notice.send(JHActions.sourceCaseRefresh());
      showToast(context, "删除成功");
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 我的案源
  Future<ResponseModel> caseSourceMy(
    BuildContext context, {
    int limit,
    int page,
    int type,
    String id,
  }) async {
    ResponseModel data = await SourceCaseMyRequestModel(
      limit: limit,
      page: page,
      type: type,
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      List listData =
          dataModelListFromJson(rep["data"]['records'], CaseSourceModel());
      return ResponseModel.fromSuccess(listData);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取案源详细
  Future<ResponseModel> sourceCaseDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SourceCaseDetailsRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      SourceCaseDetails model = SourceCaseDetails.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 承接案源
  Future<ResponseModel> sourceCaseUndertake(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SourceCaseUndertakeRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '承接成功');
      pop();
      maybePop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 发布者确认完成
  Future<ResponseModel> sourceCaseConfirm(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SourceCasePublishConfirmModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '确认成功');
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 承接者确认完成
  Future<ResponseModel> sourceCaseCompleted(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SourceCaseCompletedModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
    )
        .then((rep) {
      showToast(context, '确认成功');
      pop();
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律所获取案源共享
  Future<ResponseModel> sourceCaseShare(
    BuildContext context, {
    int limit,
    int page,
    String firmId,
  }) async {
    ResponseModel data = await SourceCaseShareRequestModel(
      limit: limit,
      page: page,
      id: firmId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List listdata = dataModelListFromJson(rep["data"], CaseSourceModel());
      return ResponseModel.fromSuccess(listdata);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 发布案源
  Future<ResponseModel> caseSourceRelease(
    BuildContext context, {
    String category,
    String content,
    String fee,
    int limited,
    String requirement,
    String title,
    String value,
  }) async {
    if (!strNoEmpty(fee)) {
      throw ResponseModel.fromParamError('报价不能为空');
    } else if (!strNoEmpty(value)) {
      throw ResponseModel.fromParamError('标值不能为空');
    }
    double inFee = double.parse(fee);
    double inValue = double.parse(value);
    if (!strNoEmpty(category) || category == '0') {
      throw ResponseModel.fromParamError('类别不能为空');
    } else if (content == r'[{\"insert\":\"\\n\"}]') {
      throw ResponseModel.fromParamError('内容不能为空');
    } else if (inFee == null || inFee < 0) {
      throw ResponseModel.fromParamError('报价不能为空或小于1');
    } else if (limited == null || limited == 0) {
      throw ResponseModel.fromParamError('业务时限不能为空');
    } else if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError('标题不能为空');
    } else if (inValue == null || inValue < 0) {
      throw ResponseModel.fromParamError('标值不能为空或小于1');
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (content.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }
    ResponseModel data = await SourceCaseReleaseRequestModel(
      category: category,
      content: content,
      fee: inFee,
      limited: limited,
      requirement: requirement,
      title: title,
      value: inValue,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(payDetailDialog(
        context,
        type: payType.weChat,
        itemId: rep['data'],
        orderType: 5,
        price: '$inFee',
      ).then((v) {
        if (v == null || !v) {
//          showToast(context, '请支付');
        } else {
          showToast(context, '发布成功');
          pop(true);
          Notice.send(JHActions.caseRefresh());
        }
      }));
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
