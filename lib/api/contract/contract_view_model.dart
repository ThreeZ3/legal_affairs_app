import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/contract/contract_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

ContractViewModel contractViewModel = new ContractViewModel();

class ContractViewModel extends BaseViewModel {
  /// 新增律师合同
  Future<ResponseModel> contractAdd(
    BuildContext context, {
    String category,
    String contractReview,
    String id,
    String img,
    String lawyerId,
    int price,
    int textLimit,
    String title,
    int videoLimit,
    int voiceLimit,
  }) async {
    if (!strNoEmpty(category)) {
      throw ResponseModel.fromParamError('类别不能为空');
    } else if (!strNoEmpty(contractReview)) {
      throw ResponseModel.fromParamError('合同审查次数不能为空');
//    } else if (!strNoEmpty(id)) {
//      throw ResponseModel.fromParamError('id不能为空');
    } else if (!strNoEmpty(img)) {
      throw ResponseModel.fromParamError('img不能为空');
    } else if (!strNoEmpty(lawyerId)) {
      throw ResponseModel.fromParamError('律师Id不能为空');
    } else if (price == null || price < 1) {
      throw ResponseModel.fromParamError('价格不能为空或小于1');
    } else if (textLimit == null) {
      throw ResponseModel.fromParamError('文字咨询时长不能为空');
    } else if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError('标题不能为空');
    } else if (videoLimit == null) {
      throw ResponseModel.fromParamError('视频咨询时长不能为空');
    } else if (voiceLimit == null) {
      throw ResponseModel.fromParamError('语音咨询时长不能为空');
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (contractReview.length >= 9) {
      throw ResponseModel.fromParamError('审核合同次数过多');
    } else if (price.toString().length >= 9) {
      throw ResponseModel.fromParamError('价格长度过高');
    }
    ResponseModel data = await ContractAddRequestModel(
      category: category,
      contractReview: contractReview,
      id: id,
      img: img,
      lawyerId: lawyerId,
      price: price,
      textLimit: textLimit,
      title: title,
      videoLimit: videoLimit,
      voiceLimit: voiceLimit,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      showToast(context, '发布成功');
      Notice.send(JHActions.contractRefresh(), '');
      pop();
//      popUntil(ModalRoute.withName(MyContractPage().toStringShort()));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 修改律师合同
  Future<ResponseModel> contractChange(
    BuildContext context, {
    String category,
    String contractReview,
    String id,
    String img,
    String lawyerId,
    int price,
    int textLimit,
    String title,
    int videoLimit,
    int voiceLimit,
  }) async {
    ResponseModel data = await ContractAddRequestModel(
      category: category,
      contractReview: contractReview,
      id: id,
      img: img,
      lawyerId: lawyerId,
      price: price,
      textLimit: textLimit,
      title: title,
      videoLimit: videoLimit,
      voiceLimit: voiceLimit,
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

  /// 律师合同列表
  Future<ResponseModel> contractList(
    BuildContext context, {
    String lawyerId,
  }) async {
    ResponseModel data = await ContractsListRequestModel(
      lawyerId: lawyerId,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //ContractListModel
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律师合同列表
  Future<ResponseModel> byContracts(
    BuildContext context, {
    final String id,
    final int limit,
    final int page,
  }) async {
    ResponseModel data = await ByContractsRequestModel(
      id: id,
      limit: limit,
      page: page,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List listData =
          dataModelListFromJson(rep["data"], ContractsRecordsDataModel());
      return ResponseModel.fromSuccess(listData);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 通过律所id获取律所顾问合同
  Future<ResponseModel> contractFirm(
    BuildContext context, {
    final String id,
    final int page,
    final int limit,
  }) async {
    ResponseModel data = await ContractFirmRequestModel(
      id: id,
      page: page,
      limit: limit,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new ContractFirmModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律师合同详情
  Future<ResponseModel> contractDetail(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ContractsDetailRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //ContractListModel5
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 律师合同删除
  Future<ResponseModel> contractDel(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await ContractsDetailRequestModel(
      id: id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
      hud: '请求中',
    )
        .then((rep) {
      //ContractListModel
      Notice.send(JHActions.contractRefresh());
      showToast(context, '删除成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///获取当前律师合同列表
  Future<ResponseModel> getcontractList(
    BuildContext context, {
    int limit,
    int page,
    String id,
  }) async {
    ResponseModel data = await ContractsCurrentListRequestModel(
      limit: limit,
      page: page,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      //ContractListModel
      List listdata = dataModelListFromJson(
          rep["data"]["records"], ContractsRecordsDataModel());
      return ResponseModel.fromSuccess(listdata);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
