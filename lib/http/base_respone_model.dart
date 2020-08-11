/// 等后端指定规范再统一封装
class ResponseModel {
  int code;
  String message;
  String serverMessage;
  dynamic data;

  ResponseModel({this.code = 0, this.message = '请求成功', this.data});

  /*
  * 请求返回错误
  *
  * */
  factory ResponseModel.fromError(msg, code) {
    ResponseModel rep;

    rep = new ResponseModel()
      ..code = code
      ..message = msg;

    return rep;
  }

  /*
  * 请求成功
  *
  * */
  factory ResponseModel.fromSuccess(data) => new ResponseModel()..data = data;

  /*
  * 请求单个数组成功
  *
  * */
  factory ResponseModel.fromSuccessList(data) =>
      new ResponseModel()..data = data.data;

  /*
  * 参数校验
  *
  * */
  factory ResponseModel.fromParamError(String msg) => new ResponseModel()
    ..code = 1
    ..message = '$msg';
}
