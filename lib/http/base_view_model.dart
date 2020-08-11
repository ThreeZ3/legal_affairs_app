import 'dart:async';
export 'base_respone_model.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
typedef Response(int code,String msg);

class BaseViewModel {

  var dataController = new StreamController<dynamic>.broadcast();

  Sink get inDataController => dataController;

  List dataList = new List();
  var datas;

  Stream<dynamic> get stream => dataController.stream.map((data){
    dataList.addAll(data);
    return dataList;
  });

  dynamic getData() => null;

  refreshData(){}

  loadMoreData(){}

  dispose() {
    dataController.close();
  }

  void dataModelFromJson(data, model,[dataController]){

    List repData = data['Data'];

    assert(repData is List);

    List list = new List();

    repData.forEach((json) => list.add(model.from(json)));

    inDataController.add(list??[]);

  }

  List dataModelListFromJson(data, model,[dataController]){

    List repData = data;

    assert(repData is List);

    List list = new List();

    repData.forEach((json) => list.add(model.from(json)));

    return list;
  }
}