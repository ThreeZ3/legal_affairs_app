import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/business/consult_model.dart';
import 'package:jh_legal_affairs/api/home/home_new_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';

ConsultViewModel consultViewModel = new ConsultViewModel();

class ConsultViewModel extends BaseViewModel {
  /// 获取咨询列表
  Future<ResponseModel> consultList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await ConsultListRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(
          rep['data']['records'], new ConsultViewListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律所获取咨询列表
  Future<ResponseModel> consultFirm(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await ConsultFirmRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data'], new ConsultViewListModel());
      if (!listNoEmpty(data)) {
        // throw ResponseModel.fromError('暂时没有数据了', 999);
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 分页获取所有咨询
  Future<ResponseModel> consultPublishingPage(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await ConsultPublishingPageRequestModel(
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //ConsultListModel
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 发布咨询列表
  Future<ResponseModel> consultReleaseList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await ConsultReleaseRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(
          rep['data']['records'], new ConsultViewListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 承接的咨询列表
  Future<ResponseModel> consultByUnderList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await ConsultByUnderRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data = dataModelListFromJson(
          rep['data']['records'], new ConsultViewListModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取用户咨询列表
  Future<ResponseModel> consultUserList(
    BuildContext context, {
    String userId,
  }) async {
    ResponseModel data = await ConsultUserRequestModel(
      userId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //ConsultListModel
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取咨询详情
  Future<ResponseModel> consultDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ConsultDetailsRequestModel(
      id,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      ConsultDetailsModel model = ConsultDetailsModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 新增咨询
  Future<ResponseModel> consultAdd(
    BuildContext context, {
    String categoryId,
    String content,
    String firstAsk,
    int limit,
    String optimumAsk,
    String require,
    String similarAsk,
    String title,
    String totalAsk,
    String synopsis,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError("请输入标题");
    } else if (!strNoEmpty(firstAsk) ||
        !strNoEmpty(optimumAsk) ||
        !strNoEmpty(similarAsk) ||
        !strNoEmpty(totalAsk)) {
      throw ResponseModel.fromParamError("请输入价格");
    } else if (categoryId == '0' || categoryId == '') {
      throw ResponseModel.fromParamError("请选择类别Id");
    } else if (content == r'[{\"insert\":\"\\n\"}]') {
      throw ResponseModel.fromParamError("请输入问题");
    } else if (limit < 1) {
      throw ResponseModel.fromParamError("时限必须大于等于1");
    } else if (!strNoEmpty(require)) {
      throw ResponseModel.fromParamError("请输入要求");
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (content.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength)}字以内');
    } else if (require.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '要求长度过大，限制${stringDisposeWithDouble(maxContentLength)}字以内');
    }

    ResponseModel data = await ConsultAddRequestModel(
      categoryId: categoryId,
      content: content,
      firstAsk: firstAsk,
      id: "",
      limit: limit,
      optimumAsk: optimumAsk,
      require: require,
      similarAsk: similarAsk,
      title: title,
      totalAsk: totalAsk,
      synopsis: synopsis,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(
        payDetailDialog(
          context,
          type: payType.weChat,
          itemId: rep['data'],
          orderType: 1,
          price: '$totalAsk',
        ).then((v) {
          if (v == null || !v) {
//          showToast(context, '请支付');
          } else {
            showToast(context, '发布成功');
            pop(true);
            Notice.send(JHActions.mineAdvisoryRefresh(), ' ');
          }
        }),
      );
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改咨询
  Future<ResponseModel> consultChange(
    BuildContext context, {
    String categoryId,
    String content,
    String firstAsk,
    int limit,
    String optimumAsk,
    String require,
    String similarAsk,
    String title,
    String totalAsk,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError("请输入标题");
    } else if (!strNoEmpty(firstAsk) ||
        !strNoEmpty(optimumAsk) ||
        !strNoEmpty(similarAsk) ||
        !strNoEmpty(totalAsk)) {
      throw ResponseModel.fromParamError("请输入价格");
    } else if (categoryId == '0' || categoryId == '') {
      throw ResponseModel.fromParamError("请选择类别Id");
    } else if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError("请输入内容");
    } else if (limit < 1) {
      throw ResponseModel.fromParamError("时限必须大于等于1");
    } else if (!strNoEmpty(require)) {
      throw ResponseModel.fromParamError("请输入要求");
    }

    ResponseModel data = await ConsultAddRequestModel(
      categoryId: categoryId,
      content: content,
      firstAsk: firstAsk,
      id: "",
      limit: limit,
      optimumAsk: optimumAsk,
      require: require,
      similarAsk: similarAsk,
      title: title,
      totalAsk: totalAsk,
    )
        .sendApiAction(
      context,
      reqType: ReqType.put,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///多选删除我的咨询 【多个】
  Future<ResponseModel> deletesConsult(
    BuildContext context,
    String ids,
  ) async {
    ResponseModel data = await DeletesConsultRequestModel(
      ids,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///删除咨询 【单个】 文档上是错误的，此地正确
  Future<ResponseModel> deleteConsult(
    BuildContext context,
    String id,
  ) async {
    ResponseModel data = await DeleteConsultRequestModel(
      id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 咨询回复
  Future<ResponseModel> consultAnswer(
    BuildContext context, {
    String consultId,
    String content,
  }) async {
    ResponseModel data = await ConsultAnswerRequestModel(
      consultId: consultId,
      content: content,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.consultAnswerRefresh(), '');
      showToast(context, '回答成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 分页获取咨询回复列表
  Future<ResponseModel> consultAnswerLimit(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await ConsultAnswerLimitRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      List list = dataModelListFromJson(rep['data']['records'], Recordss());
      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 咨询回复标记
  Future<ResponseModel> consultAnswerMark(
    BuildContext context, {
    String id,
    int score,
  }) async {
    ResponseModel data = await ConsultAnswerMarkRequestModel(
      id: id,
      score: score,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.put,
    )
        .then((rep) {
      Notice.send(JHActions.consultAnswerRefresh(), '');
      showToast(context, '标记成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///案例评论（点赞/反对）
  Future<ResponseModel> caseOpinion(
    BuildContext context, {
    String caseId,
    int status,
  }) async {
    ResponseModel data = await CaseOpinionRequestModel(
      caseId: caseId,
      status: status,
    ).sendApiAction(context, reqType: ReqType.post).then((rep) {
      showToast(context, '表态成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///案例新增评论 相关内容评论（课件评论，律师评论,图文评论，案例评论）
  Future<ResponseModel> newComment(
    BuildContext context, {
    final String targetId,
    final String content,
    final int type,
  }) async {
    if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError('请输入评论内容');
    }
    ResponseModel data = await CaseNewCommentRequestModel(
      targetId: targetId,
      content: content,
      type: type,
    ).sendApiAction(context, reqType: ReqType.post).then((rep) {
      Notice.send(JHActions.lawyerDetailPageRefresh());
      showToast(context, '表态成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// consult-answer/del/{id} 删除回复
  Future<ResponseModel> consultAnswerDel(context, String id) async {
    ResponseModel data = await ConsultAnswerDelRequestModel(id)
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
