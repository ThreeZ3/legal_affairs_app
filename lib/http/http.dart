import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart' as adio;
import 'package:dio/dio.dart';
import 'package:jh_legal_affairs/http/handle.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
class Http {
  static const int CONNECT_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 3000;

  static Future<AnHttpResponse> doGetPin(
      String url, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      String tokenStr = await getStoreValue(JHActions.token());
      adio.Response response = await dio.get(url,
          options: adio.Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'authorization': '$tokenStr',
          }));

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doPost(
      String url, body, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      String tokenStr = await getStoreValue(JHActions.token());
      var params = url.contains('/login') ? body : null;
      adio.Response response = await dio.post(url,
          data: body,
          queryParameters: params,
          options: adio.Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'authorization': '$tokenStr',
          }));

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doOss(
      String url, body, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);
    options.responseType = ResponseType.plain;

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;
    dio.options.contentType =
        ContentType.parse("multipart/form-data").primaryType;

    String iso = DateTime.now().toIso8601String();
    String expiration = '';
    if (iso.length > 23) {
      expiration = '${iso.substring(0, iso.length - 3)}Z';
    } else {
      expiration = '${iso}Z';
    }

    File file = body['file'];
    MultipartFile fileData = await MultipartFile.fromFile(file.path);

    String policyText =
        '{"expiration": "$expiration","conditions": [["content-length-range", 0, 1048576000]]}';
    List<int> policyTextUtf8 = utf8.encode(policyText);
    String policyBase64 = base64.encode(policyTextUtf8);
    List<int> policy = utf8.encode(policyBase64);
    String fileName =
        "${file.path.substring(file.path.indexOf('Download/'), file.path.length)}";
    String accessKey = 'uGiCBnlLJBT1NbRofR8CMWqyJ6pGTB';
    List<int> key = utf8.encode(accessKey);
    List<int> signaturePre = new Hmac(sha1, key).convert(policy).bytes;
    String signature = base64.encode(signaturePre);

    FormData data = new FormData.fromMap({
      'chunk': '0',
      'key': "legal-file/" + fileName,
      'policy': policyBase64,
      'OSSAccessKeyId': 'PKvgp5McrViqTZTO',
      'success_action_status': '200',
      'signature': signature,
      'file': fileData,
      'Access-Control-Allow-Origin': '*',
    });

    try {
      adio.Response response = await dio.post(
        url,
        data: data,
        options: adio.Options(headers: {
          HttpHeaders.contentTypeHeader:
              ContentType.parse("multipart/form-data").primaryType,
        }),
      );
      if (response.statusCode == HttpStatus.ok) {
        String u =
            'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/';
        result = {"code": HttpStatus.ok, "data": u + fileName};
      } else {
        result = {};
      }
      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doFile(
    String url,
    body,
    Map<String, String> headers,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
  ) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: 360 * 1000, receiveTimeout: 360 * 1000);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      File file = body['file'];
      MultipartFile fileData = await MultipartFile.fromFile(file.path);
      Map map = {'file': fileData};
      FormData formData = FormData.fromMap(Map.from(map));
      adio.Response response = await dio.post(
        url,
        data: formData,
        options: adio.Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        }),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doPut(
      String url, body, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      String tokenStr = await getStoreValue(JHActions.token());
      adio.Response response = await dio.put(url,
          data: body,
          queryParameters: body,
          options: adio.Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'authorization': '$tokenStr',
          }));

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doDel(
      String url, body, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      String tokenStr = await getStoreValue(JHActions.token());
      adio.Response response = await dio.delete(url,
          data: body,
          queryParameters: body,
          options: adio.Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'authorization': '$tokenStr',
          }));

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }

  static Future<AnHttpResponse> doGet(
      String url, body, Map<String, String> headers) async {
    adio.BaseOptions options = new adio.BaseOptions(
        connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);

    Map result;
    adio.Dio dio = new adio.Dio(options);
    AnHttpResponse httpResponse;

    try {
      String tokenStr = await getStoreValue(JHActions.token());
      adio.Response response = await dio.get(url,
          queryParameters: body,
          options: adio.Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'authorization': '$tokenStr',
          }));

      if (response.statusCode == HttpStatus.ok) {
        result = await response.data;
      } else {
        result = {};
      }

      httpResponse = new AnHttpResponse(
          jsonEncode(result), response.statusCode, result['headers']);
    } on adio.DioError catch (e) {
      errorLog(url, e, body);
      return null;
    }

    return httpResponse;
  }
}

class AnHttpResponse {
  final String body;
  final int code;
  final Map headers;

  AnHttpResponse(this.body, this.code, this.headers);
}
