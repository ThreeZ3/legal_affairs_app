import 'package:flutter/cupertino.dart';
import 'package:jh_legal_affairs/api/home/home_banner_model.dart';

import 'package:jh_legal_affairs/http/base_request.dart';
import 'package:jh_legal_affairs/http/base_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

///首页广告 viewmodel

class HomeBannerViewModel extends BaseViewModel {
  Future<ResponseModel> getBannerData(BuildContext context) async {
    ResponseModel bannerData = await HomeBannerRequest()
        .sendApiAction(context, reqType: ReqType.get)
        .then((rep) {
      HomeBannerModel homeBannerDataModel = HomeBannerModel.fromJson(rep);
      return ResponseModel.fromSuccess(homeBannerDataModel);
    }).catchError((e) => throw ResponseModel.fromError(e.message, e.code));
    return bannerData;
  }
}
