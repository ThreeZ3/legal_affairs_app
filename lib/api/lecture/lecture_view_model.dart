import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/pay_detail.dart';

LectureViewModel lectureViewModel = new LectureViewModel();

class LectureViewModel extends BaseViewModel {
  Future lectureSub(
    BuildContext context, {
    String id,
    String price,
    bool isCharge,
  }) async {
    if (isCharge) {
      bool isPayOk = await payDetailDialog(
        context,
        itemId: id,
        type: payType.weChat,
        orderType: 3,
        price: price,
      );
      if (isPayOk) {
        showToast(context, '订阅成功');
        return ResponseModel.fromSuccess('订阅成功');
      } else {
        return '';
      }
//      if (isPayOk) return lectureSubFree(context, id: id);
    } else {
      return lectureSubFree(context, id: id);
    }
  }

  ///免费课件订阅
  Future<ResponseModel> lectureSubFree(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LectureFreeSubRequest(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.isSubscription());
      showToast(context, '成功订阅该律师课件');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///给评论点赞--用户评论列表
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
      Notice.send(JHActions.commentUserRefresh());
//      showToast(context, '点赞成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///给评论点赞
  Future<ResponseModel> agreeLectureComments(
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
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 新增课件
  Future<ResponseModel> lectureAdd(
    BuildContext context, {
    String category,
    double charges,
    String content,
    String id,
    String cover,
    int isCharge,
    String title,
    String videoUrl,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError("请输入标题");
    } else if (!strNoEmpty(videoUrl)) {
      throw ResponseModel.fromParamError("请添加视频");
    } else if (!strNoEmpty(category)) {
      throw ResponseModel.fromParamError("请选择业务类别");
    } else if (isCharge == 1 && !isMoney(charges.toString())) {
      throw ResponseModel.fromParamError("请输入案值");
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (content.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }
    ResponseModel data = await LectureAddRequestModel(
      category: category,
      charges: charges,
      content: content,
      id: id,
      isCharge: isCharge,
      title: title,
      cover: cover,
      videoUrl: videoUrl,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.lectureRefresh());
      pop();
      showToast(context, '发布成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改课件
  Future<ResponseModel> lectureChange(
    BuildContext context, {
    String category,
    double charges,
    String content,
    String id,
    int isCharge,
    String title,
  }) async {
    ResponseModel data = await LectureAddRequestModel(
      category: category,
      charges: charges,
      content: content,
      id: id,
      isCharge: isCharge,
      title: title,
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

  /// 课件赞成
  Future<ResponseModel> lectureAgree(
    BuildContext context, {
    String lecturesId,
    String userId,
  }) async {
    ResponseModel data = await LectureAgreeRequestModel(
      lecturesId: lecturesId,
      userId: userId,
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

  /// 课件反对
  Future<ResponseModel> lectureOpposition(
    BuildContext context, {
    String lecturesId,
    String userId,
  }) async {
    ResponseModel data = await LectureOppositionRequestModel(
      lecturesId: lecturesId,
      userId: userId,
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

  /// 新增课件评论
  Future<ResponseModel> lectureComment(
    BuildContext context, {
    String comment,
    String id,
    String lectureId,
    String userId,
  }) async {
    ResponseModel data = await LectureCommentRequestModel(
      comment: comment,
      userId: userId,
      id: id,
      lectureId: lectureId,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      Notice.send(JHActions.commentRefresh());
      showToast(context, '评论成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 分页查询课件评论
  Future<ResponseModel> lectureCommentList(
    BuildContext context, {
    String id,
    int page,
    int limit,
  }) async {
    ResponseModel data =
        await LectureCommentsListRequestModel(id: id, page: page, limit: limit)
            .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
            .then((rep) {
      List commentList =
          dataModelListFromJson(rep['data'], LectureCommentListModel());
      return ResponseModel.fromSuccess(commentList);
    });
    return data;
  }

  /// 获取课件列表
  Future<ResponseModel> lectureList(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await LectureListRequestModel(
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List lectureList =
          dataModelListFromJson(rep['data']['records'], LectureListModel());
      if (!listNoEmpty(lectureList)) {
        // throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(lectureList);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律所获取课件列表
  Future<ResponseModel> lectureFirm(
    BuildContext context, {
    String id,
    int limit,
    int page,
  }) async {
    ResponseModel data = await LectureFirmRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List lectureList = dataModelListFromJson(rep['data'], LectureListModel());
      return ResponseModel.fromSuccess(lectureList);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 其他课件列表
  Future<ResponseModel> lectureOtherList(
    BuildContext context,
  ) async {
    ResponseModel data = await LectureOtherRequestModel(currentPage: 1, size: 2)
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List list =
          dataModelListFromJson(rep['data']['records'], LecturesOtherModel());
      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 按律师获取课件列表
  Future<ResponseModel> lectureLawyerList(
    BuildContext context, {
    String lawyerId,
    int limit,
    int page,
  }) async {
    ResponseModel data = await LectureLawyerListRequestModel(
      lawyerId: lawyerId,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      print('repResult::::::$rep}');
      List lectureLawyerList =
          dataModelListFromJson(rep['data']['records'], LectureListModel());
      if (page > 1 && !listNoEmpty(lectureLawyerList)) {
        throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(lectureLawyerList);
    }).catchError((e) {
      print('e=======>>>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 按律师获取课件列表
  Future<ResponseModel> lectureSubList(
    BuildContext context, {
    int limit,
    int page,
  }) async {
    ResponseModel data = await LectureSubListRequestModel(
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List lectureLawyerList =
          dataModelListFromJson(rep['data'], LectureListModel());
      if (page > 1 && !listNoEmpty(lectureLawyerList)) {
        throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(lectureLawyerList);
    }).catchError((e) {
      print('e=======>>>${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取课件订阅列表
  Future<ResponseModel> lectureSubscriptionList(BuildContext context,
      {String id, int page, int limit}) async {
    ResponseModel data =
        await LectureSubscriptionRequestModel(id: id, page: page, limit: limit)
            .sendApiAction(
      context,
      hud: '请求中',
    )
            .then((rep) {
      List modelList = dataModelListFromJson(
          rep['data']['records'], LectureSubscriptionModel());
      if (!listNoEmpty(modelList)) {
        // throw ResponseModel.fromError('没有更多数据了', rep['code']);
      }
      return ResponseModel.fromSuccess(modelList);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取课件总收入
  Future<ResponseModel> lectureSubscriptionIncome(BuildContext context,
      {String id}) async {
    ResponseModel data = await LectureGetIncomeRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep['data']);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 查找付费观看课件
  Future<ResponseModel> lectureNotFree(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LectureNotFreeRequestModel(
      id,
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

  /// 获取课件详情
  Future<ResponseModel> lectureDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LectureDetailsRequestModel(id)
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      LectureDetailsModel model = LectureDetailsModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      print('${e.toString()}');
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 删除课件
  Future<ResponseModel> lectureDel(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await LectureDelRequestModel(
      id: id,
    ).sendApiAction(context, reqType: ReqType.del, hud: '删除中').then((rep) {
      Notice.send(JHActions.lectureRefresh());
      showToast(context, '删除成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///课件评论 （点赞/反对）
  Future<ResponseModel> lectureAttitude(
    BuildContext context, {
    String id,
    int status,
  }) async {
    ResponseModel data = await LectureAttitudeRequestModel(
      lectureId: id,
      status: status,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
//      showToast(context, "操作成功");
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
