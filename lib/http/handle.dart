import 'dart:convert';

import 'package:jh_legal_affairs/util/tools.dart';

Map getKeys(obj) {
  Map requestBody;
  if (obj is BaseRequest) {
    requestBody = jsonDecode(jsonEncode(obj));

    for (final k in requestBody.keys.toList(growable: false)) {
      final v = requestBody[k];
      if (v == null || v == 'null') {
        requestBody.remove(k);
      }
    }
  } else {
    requestBody = obj;
  }
  return requestBody;
}

Map netError(String url) {
  return {'code': '-1', 'msg': '网络连接失败', 'data': url};
}

logPrint(reqType, query, id, httpUrl, requestBody, body) {
  String queryStr = reqType == ReqType.getPin ? query.toString() : '';
  print('HTTP_REQUEST_URL::[$id]::$httpUrl${queryStr ?? ''}');
  if (requestBody != null) {
    String reqBody = jsonEncode(requestBody);
    print('HTTP_REQUEST_BODY::[$id]::$reqBody');
  }
  if (strNoEmpty(JHData.token().toString())) {
    String token = JHData.token().toString();
//    String sub = token.substring(0, 20);
//    String end = token.substring(token.length - 20, token.length);
//    print('HTTP_REQUEST_TOKEN::[$id]::' + sub + '......' + end);
    print('HTTP_REQUEST_TOKEN::[$id]::' + token);
  }
  print('HTTP_RESPONSE_BODY::[$id]::$body');
}

errorLog(url, e, [body]) {
  print('request.url：' + url.toString());
  if (strNoEmpty(JHData.token().toString())) {
    print('request.token：' + JHData.token().toString());
  }
  try {
    if (body != null) print('request.body：' + jsonEncode(body));
  } catch (e) {
    print('request.body：' + body.toString());
  }
  print('response.error：' + e.toString());
}

class ErrorResult {}
