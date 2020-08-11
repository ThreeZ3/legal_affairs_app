import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/http/base_request.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

CaseViewModel caseViewModel = new CaseViewModel();

class CaseViewModel extends BaseViewModel {
  /// 案例赞成
  Future<ResponseModel> caseAgree(
    BuildContext context, {
    String userId,
    String caseId,
  }) async {
    ResponseModel data = await CaseAgreeRequestModel(
      userId: userId,
      caseId: caseId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 案例反对
  Future<ResponseModel> caseOpposition(
    BuildContext context, {
    String userId,
    String caseId,
  }) async {
    ResponseModel data = await CaseOppositionRequestModel(
      userId: userId,
      caseId: caseId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取我的全部案例列表
  Future<ResponseModel> caseList(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await CaseListRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List listModel =
          dataModelListFromJson(rep['data']['records'], ConsultListModel());
      if (!listNoEmpty(listModel) && page > 1) {
        showToast(context, '没有更多的数据了');
      }
      return ResponseModel.fromSuccess(listModel);
    }).catchError((e) => showToast(context, e.message));
    return data;
  }

  /// 律所获取案例列表
  Future<ResponseModel> caseFirm(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await CaseFirmRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List listModel = dataModelListFromJson(rep['data'], ConsultListModel());
      return ResponseModel.fromSuccess(listModel);
    }).catchError((e) => showToast(context, e.message));
    return data;
  }

  /// 案例新增
  Future<ResponseModel> caseAdd(
    BuildContext context, {
    String category,
    String court,
    String detail,
    String id,
    String judge,
    String lawyerId,
    String title,
    int trialStage,
    String value,
    String caseUrl,
    String caseNo,
    String synopsis,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError("请输入标题");
    } else if (!strNoEmpty(detail)) {
      throw ResponseModel.fromParamError("请输入内容");
    } else if (!strNoEmpty(value) || !isMoney(value)) {
      throw ResponseModel.fromParamError("请输入案值");
    } else if (!strNoEmpty(court)) {
      throw ResponseModel.fromParamError("请输入经办法院");
    } else if (!strNoEmpty(judge)) {
      throw ResponseModel.fromParamError("请输入审判长");
//    } else if (!strNoEmpty(caseUrl)) {
//      throw ResponseModel.fromParamError("请输入案例网址");
//    } else if (!isUrl(caseUrl)) {
//      throw ResponseModel.fromParamError("请输入正确格式的案例网址");
    } else if (!strNoEmpty(caseNo)) {
      throw ResponseModel.fromParamError("请输入案例编号");
    } else if (trialStage == null) {
      throw ResponseModel.fromParamError("请选择审判阶段");
    } else if (!strNoEmpty(category)) {
      throw ResponseModel.fromParamError('请选择业务类别');
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (detail.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }else if (value.length > 8) {
      throw ResponseModel.fromParamError(
          '金额过大，限制8位数以内');
    }
    ResponseModel data = await CaseAddRequestModel(
      category: category,
      court: court,
      detail: detail,
      id: id,
      judge: judge,
      lawyerId: lawyerId,
      title: title,
      trialStage: trialStage,
      value: value,
      caseUrl: caseUrl,
      caseNo: caseNo,
      synopsis: synopsis,
    )
        .sendApiAction(
      context,
      hud: '发布中',
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.caseRefresh());
      pop();
      showToast(context, '发布成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 案例修改  修改案例
  Future<ResponseModel> caseChange(
    BuildContext context, {
    String category,
    String court,
    String detail,
    String id,
    String judge,
    String lawyerId,
    String title,
    int trialStage,
    String value,
  }) async {
    ResponseModel data = await CaseAddRequestModel(
      category: category,
      court: court,
      detail: detail,
      id: id,
      judge: judge,
      lawyerId: lawyerId,
      title: title,
      trialStage: trialStage,
      value: value,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.put,
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 相关内容评论（课件评论，律师评论,图文评论，案例评论）
  Future<ResponseModel> caseComment(
    BuildContext context, {
    String content,
    String targetId,
    int type,
  }) async {
    if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError('评论不能为空');
    }
    ResponseModel data = await CaseCommentRequestModel(
      content: content,
      targetId: targetId,
      type: type,
    )
        .sendApiAction(
      context,
      hud: '评论中',
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.commentRefresh());
      showToast(context, '评论成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 取消点赞
  Future<ResponseModel> cancelCommentAgree(
    BuildContext context, {
    String typeId,
  }) async {
    ResponseModel data = await CancelCommentAgreeRequestModel(
      typeId: typeId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.commentRefresh());
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 案例评论列表
  Future<ResponseModel> caseCommentList(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await CaseCommentListRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List modelList =
          dataModelListFromJson(rep['data'], CaseCommentListModel());
      return ResponseModel.fromSuccess(modelList);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取律师视频列表
  Future<ResponseModel> caseVideoList(
    BuildContext context, {
    String lawyerId,
  }) async {
    ResponseModel data = await CaseVideoRequestModel(
      lawyerId: lawyerId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //CaseVideoModel
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取案例详情
  Future<ResponseModel> caseDetailsList(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await CaseDetailsRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      print("===>>>>$rep");
      CaseDetailsModel model = CaseDetailsModel.fromJson(rep['data']);
      print("jjjjj$model");
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      showToast(context, e.message);
    });
    return data;
  }

  /// 获取案源列表
  Future<ResponseModel> sourceCaseList(
    BuildContext context,
  ) async {
    ResponseModel data = await SourceCaseListRequestModel()
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new SourceCaseModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 分页获取所有安源列表（不包括待审核和审核失败的）
  Future<ResponseModel> sourceCaseAllList(
    BuildContext context, {
    final int page,
    final int limit,
  }) async {
    ResponseModel data = await SourceCaseAllListRequestModel(
      page: page,
      limit: limit,
    )
        .sendApiAction(
      context,
    )
        .then((rep) {
      List data =
          dataModelListFromJson(rep['data']['records'], new SourceCaseModel());
      if (page > 1 && !listNoEmpty(data)) {
        throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 多选删除我的案例 [多个]
  Future<ResponseModel> deletesListCase(
    BuildContext context, {
    String ids,
  }) async {
    ResponseModel data = await DeletesCaseRequestModel(
      ids,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      showToast(context, '删除成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除案例
  Future<ResponseModel> deleteCase(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await DeleteCaseRequestModel(
      id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      Notice.send(JHActions.caseRefresh());
      showToast(context, '删除成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///案例评论 （点赞/反对）
  Future<ResponseModel> caseAttitude(
    BuildContext context, {
    String caseId,
    int status,
  }) async {
    ResponseModel data = await CaseOpinionModel(
      caseId: caseId,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
//      Notice.send(JHActions.commentClicked());
      showToast(context, '表态成功');
//      if (rep["code"] == 600) {
//        return showToast(context, "已经点赞拉");
//      }
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///新增评论
  Future<ResponseModel> caseNewComment(
    BuildContext context, {
    String targetId,
    String content,
    int type,
  }) async {
    if (!strNoEmpty(content)) {
      throw ResponseModel.fromParamError('请输入评论内容');
    }
    ResponseModel data = await CaseNewCommentRequestModel(
      targetId: targetId,
      content: content,
      type: type,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
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

  ///给评论点赞
  Future<ResponseModel> agreementComments(
    BuildContext context, {
    String typeId,
  }) async {
    ResponseModel data = await AgreementCommentsRequestModel(
      typeId: typeId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.commentRefresh());
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError('只能点赞一次', e.code);
    });
    return data;
  }

  ///给图文点赞
  Future<ResponseModel> praiseArticle(
    BuildContext context, {
    String sketchId,
    int status,
  }) async {
    ResponseModel data = await PraiseArticleRequestModel(
      sketchId: sketchId,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
//      showToast(context, '操作成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// comment-like-record/comment-del/{id} 删除评论 (post)
  Future<ResponseModel> commentDel(context, String id) async {
    ResponseModel data = await CommentDelRequestModel(id)
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
