import 'dart:async';
import 'dart:convert';
import 'dart:io' show HttpStatus; //Cookie, HttpHeaders

import 'package:dio/dio.dart';
import 'package:jh_legal_affairs/http/handle.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02'-1'9
///
final _client = new HttpClient();

var _id = 0;

Future<dynamic> api(String url, ReqType reqType, bool retJson,
    [final obj,
    Duration cacheTime,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress]) async {
//  Analytics.subEvent('API');

  final id = _id++;
  final httpUrl = '$serviceUrl$url';
  Map requestBody;
  StringBuffer query;

  AnHttpResponse response;

  if (reqType == ReqType.post) {
    requestBody = getKeys(obj);

    try {
      response = await _client.post(
        httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return netError(url);
    }
  } else if (reqType == ReqType.get) {
    requestBody = getKeys(obj);

    try {
      response = await _client.get(
        httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return netError(url);
    }
  } else if (reqType == ReqType.oss) {
    requestBody = obj.toJson();

    try {
      response = await _client.oss(
        url.startsWith('http') ? url : httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return netError(url);
    }
  } else if (reqType == ReqType.put) {
    requestBody = getKeys(obj);

    try {
      response = await _client.put(
        httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return netError(url);
    }
  } else if (reqType == ReqType.del) {
    requestBody = getKeys(obj);
    try {
      response = await _client.del(
        httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return netError(url);
    }
  } else if (reqType == ReqType.file) {
    requestBody = Map.from(obj.toJson());
    try {
      response = await _client.file(
        httpUrl,
        body: requestBody,
        headers: const {'Content-Type': 'application/json'},
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      return netError(url);
    }
  } else {
    query = new StringBuffer('?');

    if (obj is BaseRequest) {
      final map = jsonDecode(jsonEncode(obj));
      map.forEach((k, v) {
        if (v == null || v == 'null' || k == 'isFirstPage') return;

        query..write(k)..write('=')..write(v)..write('&');
      });
    } else if (query != null) {
      query.write(obj);
    }

    try {
      response = await _client.getPin('$httpUrl$query');
    } catch (e) {
      return netError(url);
    }
  }
  final statusCode = response?.code;

  switch (statusCode) {
    case HttpStatus.ok:
      final body = response.body;
      if (reqType == ReqType.file) {
        print('HTTP_REQUEST_URL::[$id]::$httpUrl');
        print('HTTP_RESPONSE_BODY::[$id]::$body');
      } else if (reqType == ReqType.oss) {
        print('HTTP_REQUEST_URL::[$id]::$url');
        print('HTTP_RESPONSE_BODY::[$id]::$body');
      } else {
        logPrint(reqType, query, id, httpUrl, requestBody, body);
      }

      if (retJson) {
        final json = jsonDecode(body);

        /// 等后端指定规范，否则无法正常封装
//          if (json['Code'] == 0) {
        final result = json;

        return result;
//          } else if (json['Code'] == 10000102) {
//            //登录失效 去重新登录
////            LoginViewModel.loginOut();
//          }

//          return '${json['Code']}::${json['Message']}::$url-$id';
      } else {
        logPrint(reqType, query, id, httpUrl, requestBody, body);
        return body;
      }
      break;
    default:
      return {'code': statusCode, 'msg': '网络连接失败', 'data': url};
  }
}

class HttpClient {
  Future<AnHttpResponse> get(url, {Map<String, String> headers, body}) async {
    final response = await Http.doGet(url, body, headers);
    return response;
  }

  Future<AnHttpResponse> post(url, {Map<String, String> headers, body}) async {
    final response = await Http.doPost(url, body, headers);
    return response;
  }

  Future<AnHttpResponse> oss(url, {Map<String, String> headers, body}) async {
    final response = await Http.doOss(url, body, headers);
    return response;
  }

  Future<AnHttpResponse> file(
    url, {
    Map<String, String> headers,
    body,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
  }) async {
    final response = await Http.doFile(
        url, body, headers, onReceiveProgress, onSendProgress);
    return response;
  }

  Future<AnHttpResponse> put(url, {Map<String, String> headers, body}) async {
    final response = await Http.doPut(url, body, headers);
    return response;
  }

  Future<AnHttpResponse> del(url, {Map<String, String> headers, body}) async {
    final response = await Http.doDel(url, body, headers);
    return response;
  }

  Future<AnHttpResponse> getPin(url, {Map<String, String> headers}) async {
    final response = await Http.doGetPin(Uri.encodeFull(url), headers);
    return response;
  }
}
