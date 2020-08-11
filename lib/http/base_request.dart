import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/http/api.dart';
import 'package:jh_legal_affairs/http/progress_dialog.dart';
import 'package:jh_legal_affairs/common/hud_view.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
typedef OnData(t);
typedef OnError(String msg, int code);

enum ReqType {
  /// post 请求方式  用于提交表单
  post,

  /// get 请求方式  用于获取信息
  get,

  /// put 请求方式 用于修改信息
  put,

  /// delete 请求方式 用于删除
  del,

  /// getPin 请求方式 用于拼接形式get请求
  getPin,

  /// 文件
  file,

  /// Ali oss
  oss,
}

class BaseRequest {
  String url() => null;

  bool retJson() => true;

  Duration cacheTime() => null;

  bool needLogin() => false;

  Map<String, dynamic> toJson() => {};

  ReqType reqType;

  Future<dynamic> sendApiAction(
    BuildContext context, {
    ReqType reqType = ReqType.get,
    hud,
    OnData onData,
    OnError onError,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
    int second = 5,
  }) async {
//     final ls = hud != null ? DefaultStatusListener(hud:hud) : EmptyListener();
//
//     ls.onStart();

    if (context != null && hud != null)
      HudView.show(context, msg: hud, second: second);
    var result = await api(this.url(), reqType, this.retJson(), this,
        this.cacheTime(), onReceiveProgress, onSendProgress);
    if (context != null && hud != null) HudView.dismiss();
    if (result['code'] == '-1' || result['code'] == null) {
      print('response.handle：${result.toString()}');
      throw ResponseModel.fromError(result['msg'], -1);
    } else if (result['code'] == 600 || result['code'] == 403) {
      throw ResponseModel.fromError(
          result['msg'], int.parse(result['code'].toString()));
    } else if (result['code'] != 200) {
      throw ResponseModel.fromError(
          result['data'], int.parse(result['code'].toString()));
    }

    return result;
  }

  sendByFuture(
    Future future, {
    TaskStatusListener listener,
    OnData onData,
    OnError onError,
  }) {
    this.send(future, listener: listener, onData: onData, onError: onError);

    return future;
  }

  send(Future observable,
      {TaskStatusListener listener, OnData onData, OnError onError}) {
    final ls = listener ?? EmptyListener();

    ls.onStart();

    observable.then(
      (data) {
        final canCall = () => true && onData != null;
        if (canCall()) Timer.run(() => canCall() ? onData(data) : null);
      },
      onError: (e, s) {
        List data = e.toString().split('::');

        if (data.length != 3) {
          return;
        }
        if (onError != null) {
          Timer.run(
            () => onError(data[1], int.parse(data[0].toString())),
          );
        } else if (e is AuthError) {
//          clearLoginInfo();
//          toLogin(context, err);
        }
      },
    )..whenComplete(ls.onFinish);
  }
}

class EmptyListener extends TaskStatusListener {
  @override
  void onFinish() {}

  @override
  void onStart() {}
}

class DefaultStatusListener extends TaskStatusListener {
  final String hud;

  DefaultStatusListener({this.hud});

  @override
  onFinish() {
    ProgressOverlay.hidden();
  }

  @override
  onStart() {
    ProgressOverlay.show(hud: hud);
  }
}

abstract class TaskStatusListener {
  void onStart();

  void onFinish();
}

class AuthError extends Error {
  @override
  String toString() {
    return '登录状态已失效';
  }
}
