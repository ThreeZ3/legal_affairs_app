import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/home/home_new_view_model.dart';
import 'package:jh_legal_affairs/api/video/video_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

VideoViewModel videoViewModel = new VideoViewModel();

class VideoViewModel extends BaseViewModel {
  /// 获取当前用户视频
  Future<ResponseModel> getVideoList(
    BuildContext context, {
    int page,
    int limit,
    String id,
  }) async {
    ResponseModel data = await VideoListRequestModel(
      page: page,
      limit: limit,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List repData = rep["data"]["records"];

      assert(repData is List);

      List list = new List();
      for (int i = 0; i < repData.length; i++) {

        list.add(VideoDataModel(index: i).from(repData[i]));
      }

      if (!listNoEmpty(list) && page > 1) {
        throw ResponseModel.fromParamError('没有更多数据了');
      }
      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取视频列表
  Future<ResponseModel> allVideoList(
    BuildContext context, {
    int page,
    int limit,
    String id,
  }) async {
    ResponseModel data = await AllVideoListRequestModel(
      page: page,
      limit: limit,
      id: id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.get,
    )
        .then((rep) {
      List repData = rep["data"]["records"];

      assert(repData is List);

      List list = new List();
      for (int i = 0; i < repData.length; i++) {

        list.add(VideoDataModel(index: i).from(repData[i]));
      }

      if (!listNoEmpty(list) && page > 1) {
        throw ResponseModel.fromParamError('没有更多数据了');
      }
      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///新增视频
  Future<ResponseModel> postVideoList(
    BuildContext context, {
    String dataUrl,
    String title,
    String cover,
    String summary,
  }) async {
    if (!strNoEmpty(title)) {
      throw ResponseModel.fromParamError('标题不能为空');
    } else if (!strNoEmpty(dataUrl)) {
      throw ResponseModel.fromParamError('请上传视频');
    } else if (!strNoEmpty(summary)) {
      throw ResponseModel.fromParamError('输入摘要');
    } else if (title.length > maxTitleLength) {
      throw ResponseModel.fromParamError(
          '标题长度过大，限制${stringDisposeWithDouble(maxTitleLength)}字以内');
    } else if (summary.length > maxContentLength) {
      throw ResponseModel.fromParamError(
          '内容长度过大，限制${stringDisposeWithDouble(maxContentLength / 2)}字以内');
    }
    ResponseModel data = await VideoPostRequestModel(
      dataUrl: dataUrl,
      title: title,
      cover: strNoEmpty(cover) ? cover : defCover,
      summary: summary,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
      Notice.send(JHActions.myVideoRefresh());
      showToast(context, '发布成功');
      pop();
      Notice.send(JHActions.myVideoRefresh(), '');
//      popUntil(ModalRoute.withName(LiveVideoPage().toStringShort()));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///查看视频
  Future<ResponseModel> putVideoSee(BuildContext context, {String id}) async {
    ResponseModel data = await VideoListSeeRequestModel(id: id)
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

  ///删除视频
  Future<ResponseModel> delVideo(BuildContext context, {String id}) async {
    ResponseModel data = await VideoListDelRequestModel(id: id)
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.del,
    )
        .then((rep) {
      Notice.send(JHActions.myVideoRefresh(), '');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  ///首页视频
  Future<ResponseModel> getHomeVideoList(BuildContext context) async {
    ResponseModel data = await VideoListHomeRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      List repData = rep["data"];

      assert(repData is List);

      List list = new List();
      for (int i = 0; i < repData.length; i++) {

        list.add(VideoDataModel(index: i).from(repData[i]));
      }

      return ResponseModel.fromSuccess(list);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
