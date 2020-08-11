import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/common/handle.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:path_provider/path_provider.dart';

SystemViewModel systemViewModel = new SystemViewModel();

class SystemViewModel extends BaseViewModel {
  /// 获取系统消息列表
  Future<ResponseModel> systemNotification(
    BuildContext context,
  ) async {
    ResponseModel data = await SystemNotificationRequestModel()
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

  /// 根据id获取系统消息详情
  Future<ResponseModel> systemMsgDetails(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SystemMsgDetailsRequestModel(
      id,
    )
        .sendApiAction(
      context,
      hud: '请求中',
    )
        .then((rep) {
      /// NotificationModel
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 根据id删除系统消息详情
  Future<ResponseModel> systemMsgDelete(
    BuildContext context, {
    String id,
  }) async {
    ResponseModel data = await SystemMsgDetailsRequestModel(
      id,
    )
        .sendApiAction(
      context,
      reqType: ReqType.del,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 申请添加任务类型
  Future<ResponseModel> legalField(
    BuildContext context, {
    String name,
  }) async {
    if (!strNoEmpty(name)) {
      throw ResponseModel.fromParamError('请输入类别');
    }
    ResponseModel data = await LegalFieldRequestModel(
      name: name,
    )
        .sendApiAction(
      context,
      reqType: ReqType.post,
      hud: '请求中',
    )
        .then((rep) {
      showToast(context, '已添加，等待审核通过');
      pop('$name+id:${rep['data']}');
      Notice.send(JHActions.legalField());
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 获取所有通过审核的任务类型
  Future<ResponseModel> legalFieldList(
    BuildContext context,
  ) async {
    ResponseModel data = await LegalFieldListRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
      hud: '请求中',
    )
        .then((rep) {
      List data = dataModelListFromJson(rep['data'], new CategoryModel());
      return ResponseModel.fromSuccess(data);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// 上传文件 example:
  ///
  /// testFile() async {
  ///   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  ///   if (image == null) return;
  ///   systemViewModel.uploadFile(context, file: image).then((rep) {
  ///     print('上传文件成功,最终地址为：：${rep.data['data']}');
  ///   }).catchError((e) {
  ///     showToast(context, e.message);
  ///   });
  /// }
  Future<ResponseModel> uploadFile(
    BuildContext context, {
    File file,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
    bool isVideo = false,
    int second = 5,
    Callback thumbnail,
    hud = '上传中',
  }) async {
    File newFile;
//    MediaInfo info;
    if (!isVideo) {
      Uint8List uList = Uint8List.fromList(await compressFile(file));
      final tempDir = await getTemporaryDirectory();
      newFile = await new File('${tempDir.path}/image.jpg').create();
      newFile.writeAsBytesSync(uList);
    } else {
      if (thumbnail != null) {
        final thumbnailFile = await FlutterVideoCompress()
            .getThumbnailWithFile(file.path, quality: 50, position: -1);

        systemViewModel
            .uploadFile(
          context,
          file: thumbnailFile,
          hud: null,
        )
            .then((rep) {
          thumbnail(rep.data['data']);
        }).catchError((e) {
          showToast(context, e.message);
        });
      }
//      if (context != null) HudView.show(context, msg: '压缩中', second: 15);
//      info = await FlutterVideoCompress().compressVideo(
//        file.path,
//        quality: VideoQuality.MediumQuality,
//        deleteOrigin: false,
//      );
//      print(
//          'FlutterVideoCompress().isCompressing;:::${FlutterVideoCompress().isCompressing}');
//      if (context != null) HudView.dismiss();
    }
    ResponseModel data = await UploadFileRequestModel(
      !isVideo && file.lengthSync() > 50000 ? newFile : file,
    )
        .sendApiAction(
      context,
      reqType: ReqType.file,
      hud: hud,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      second: second,
    )
        .then((rep) {
      if (isVideo) showToast(context, '文件上传成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError('文件上传失败，可能文件太大或网络问题', e.code);
    });
    return data;
  }

  Future<ResponseModel> testOss(
    BuildContext context, {
    File file,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
    bool isVideo = false,
    int second = 5,
    Callback thumbnail,
    hud = '上传中',
  }) async {
    if (thumbnail != null) {
      final thumbnailFile = await FlutterVideoCompress()
          .getThumbnailWithFile(file.path, quality: 50, position: -1);

      systemViewModel
          .uploadFile(
        context,
        file: thumbnailFile,
        hud: null,
      )
          .then((rep) {
        thumbnail(rep.data['data']);
      }).catchError((e) {
        showToast(context, e.message);
      });
    }
    ResponseModel data = await OssRequestModel(
      file,
    )
        .sendApiAction(context, reqType: ReqType.oss, second: second, hud: hud)
        .then((rep) {
      showToast(context, '文件上传成功');
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError('文件上传失败，可能文件太大或网络问题', e.code);
    });
    return data;
  }

  Future<ResponseModel> uploadUint8ListImage(
    BuildContext context, {
    Uint8List uint8List,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final newFile = await new File('${tempDir.path}/image.jpg').create();
    newFile.writeAsBytesSync(uint8List);
    ResponseModel data = await UploadFileRequestModel(
      newFile,
    )
        .sendApiAction(
      context,
      reqType: ReqType.file,
      hud: '请求中',
    )
        .then((rep) {
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  Future<ResponseModel> getVersion(
    BuildContext context,
  ) async {
    ResponseModel data = await VersionsRequestModel()
        .sendApiAction(
      context,
      reqType: ReqType.get,
    )
        .then((rep) {
      VersionModel model = VersionModel.fromJson(rep['data']);
      return ResponseModel.fromSuccess(model);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
