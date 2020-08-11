import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/my_province.dart';

import '../../api/system/system_model.dart';
import '../../common/global_variable.dart';
import '../../common/ui.dart';
import '../../common/win_media.dart';
import '../../page/lawyer/lawyer_page.dart';

typedef OnFilter = Function(
    CategoryModel categoryModel,
    RankModel rankModel,
    DistanceModel distanceModel,
    OrderTypeModel orderTypeModel,
    Result resultArr);

class FilterView extends StatefulWidget {
  final bool visible;
  final GestureTapCallback onCancel;
  final List<CategoryModel> data;
  final OnFilter onFilter;

  FilterView({
    this.visible = false,
    this.onCancel,
    this.data,
    @required this.onFilter,
  });

  FilterViewState createState() => FilterViewState();
}

class FilterViewState extends State<FilterView> {
  CategoryModel currentCategory;
  RankModel currentRank;
  DistanceModel currentDistance;
  OrderTypeModel currentOrderTypeModel;
  Result resultArr;

  List<OrderTypeModel> orderTypes = [
    new OrderTypeModel(null, '全部', true),
    new OrderTypeModel(1, '人气', false),
    new OrderTypeModel(2, '距离', false),
  ];

  List<RankModel> ranks = [
    new RankModel(null, '全部', true),
    new RankModel(3, '前3名', false),
    new RankModel(5, '前5名', false),
    new RankModel(10, '前10名', false),
    new RankModel(20, '前20名', false),
    new RankModel(50, '前50名', false),
    new RankModel(100, '前100名', false),
    new RankModel(200, '前200名', false),
  ];

  List<DistanceModel> distances = [
    new DistanceModel(null, '全部', true),
//    new DistanceModel(50, '50m', false),
//    new DistanceModel(100, '100m', false),
//    new DistanceModel(300, '300m', false),
//    new DistanceModel(500, '500m', false),
    new DistanceModel(1000, '1km', false),
    new DistanceModel(3000, '3km', false),
    new DistanceModel(5000, '5km', false),
  ];

  @override
  void initState() {
    super.initState();
    for (OrderTypeModel inModel in orderTypes) {
      if (inModel.isType) currentOrderTypeModel = inModel;
    }
    for (CategoryModel inModel in widget.data) {
      if (inModel.isType) currentCategory = inModel;
    }
    for (RankModel inModel in ranks) {
      if (inModel.isType) currentRank = inModel;
    }
    for (DistanceModel inModel in distances) {
      if (inModel.isType) currentDistance = inModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget itemBuild(item) {
      var model = item;
      return new SizedBox(
        width: (winWidth(context) - 80) / 4,
//        height: 26,
        child: new FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          color: model.isType ? themeColor : Color(0xffF5F5F5),
          onPressed: () => handle(model),
          child: new Text(
            '${model?.name ?? '未知类别'}',
            style: TextStyle(
                fontSize: 14,
                color: model.isType ? Colors.white : Color(0xff8C8C8C)),
          ),
        ),
      );
    }

    Widget btBuild(bt) {
      var isOk = bt == '完成';
      return new Container(
        width: winWidth(context) / 2,
        child: new FlatButton(
          onPressed: () {
            if (bt == '重置') {
              reset();
            } else {
              if (currentCategory == null) {
                currentCategory =
                    new CategoryModel(name: '综合', id: null, isType: true);
              }
              widget.onCancel();
              widget.onFilter(currentCategory, currentRank, currentDistance,
                  currentOrderTypeModel, resultArr);
            }
          },
          shape: RoundedRectangleBorder(),
          padding: EdgeInsets.symmetric(vertical: 13),
          color: isOk ? themeColor : Color(0xffF7F8FA),
          child: new Text(
            bt,
            style: TextStyle(
              color: isOk ? Colors.white : Color(0xff11152B).withOpacity(0.8),
              fontSize: (16),
            ),
          ),
        ),
      );
    }

    TextStyle _style = TextStyle(color: Color(0xffBFBFBF), fontSize: (14));
    List body = <Widget>[
      new Space(),
      new Row(
        children: <Widget>[
          new Space(),
          new Text('筛选', style: _style),
          new Spacer(),
//          new Text(
//            '常用类别',
//            style: TextStyle(color: Color(0xffBFBFBF), fontSize: 10.0),
//          ),
//          new Space(width: mainSpace / 3),
//          new SizedBox(
//            width: 30,
//            child: new FlatButton(
//              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
//              child: new Image.asset('assets/images/ic_set.png', width: 17.8),
//              onPressed: () => routePush(new CategoryPage()),
//            ),
//          ),
          new Space(),
        ],
      ),
      new Space(height: mainSpace),
      new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              padding: EdgeInsets.symmetric(horizontal: mainSpace),
              child: new Row(
                children: <Widget>[
                  new Image.asset(PLACEPIC, color: themeColor, width: 15),
                  new Space(),
                  new Text(
                      '位置：${resultArr == null ? '全部' : '${resultArr.provinceName} ${searchRange(resultArr.cityName)} ${searchRange(resultArr.areaName)}'}',
                      style: _style),
                ],
              ),
              onPressed: () => cityPickers(),
            ),
          ),
          new FlatButton(
            onPressed: () {
              setState(() => resultArr = null);
            },
            child: new Text(
              '全部',
              style: TextStyle(
                color: Color(0xffBFBFBF),
                fontSize: (14),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      new Space(height: mainSpace),
      new Padding(
        padding: EdgeInsets.symmetric(horizontal: mainSpace),
        child: new Text('排序方式', style: _style),
      ),
      new Space(),
      new Padding(
        padding: EdgeInsets.only(
          left: mainSpace,
          right: mainSpace,
          bottom: 20,
        ),
        child: new Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          children: orderTypes.map(itemBuild).toList(),
        ),
      ),
      new Row(
        children: <Widget>[
          new Space(),
          new Text('类型', style: _style),
          new Space(),
//          new Text(
//            '多选',
//            style: TextStyle(color: Color(0xffBFBFBF), fontSize: 10.0),
//          ),
        ],
      ),
      new Space(),
      new Padding(
        padding: EdgeInsets.only(
          left: mainSpace,
          right: mainSpace,
          bottom: 20,
        ),
        child: new Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          children: widget.data.map(itemBuild).toList(),
        ),
      ),
      new Padding(
        padding: EdgeInsets.symmetric(horizontal: mainSpace),
        child: new Text('排名', style: _style),
      ),
      new Space(),
      new Padding(
        padding: EdgeInsets.only(
          left: mainSpace,
          right: mainSpace,
          bottom: 20,
        ),
        child: new Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          children: ranks.map(itemBuild).toList(),
        ),
      ),
      new Padding(
        padding: EdgeInsets.symmetric(horizontal: mainSpace),
        child: new Text('距离', style: _style),
      ),
      new Space(),
      new Padding(
        padding: EdgeInsets.only(
          left: mainSpace,
          right: mainSpace,
          bottom: 20,
        ),
        child: new Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          children: distances.map(itemBuild).toList(),
        ),
      ),
    ];

    return new Visibility(
      visible: widget.visible,
      child: new Column(
        children: <Widget>[
          new Container(
            color: Colors.white,
            width: winWidth(context),
            child: new SizedBox(
              height: winHeight(context) - topBarHeight(context) * 3,
              child: new Column(
                children: <Widget>[
                  new Expanded(child: new ListView(children: body)),
                  new Row(children: ['重置', '完成'].map(btBuild).toList()),
                ],
              ),
            ),
          ),
          new Expanded(
            child: new GestureDetector(
              child: new Container(color: Colors.black.withOpacity(0.2)),
              onTap: () {
                if (widget.onCancel != null) {
                  widget.onCancel();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void reset() {
    setState(() {
      currentCategory = new CategoryModel(name: '综合', id: null, isType: true);
      currentRank = new RankModel(null, '全部', true);
      currentDistance = new DistanceModel(null, '全部', true);
      currentOrderTypeModel = new OrderTypeModel(null, '全部', true);
      resultArr = null;
      for (OrderTypeModel inModel in orderTypes) {
        if (inModel.id == null) {
          inModel.isType = true;
        } else {
          inModel.isType = false;
        }
      }
      for (CategoryModel inModel in widget.data) {
        if (inModel.id == null) {
          inModel.isType = true;
        } else {
          inModel.isType = false;
        }
      }
      for (RankModel inModel in ranks) {
        if (inModel.id == null) {
          inModel.isType = true;
        } else {
          inModel.isType = false;
        }
      }
      for (DistanceModel inModel in distances) {
        if (inModel.id == null) {
          inModel.isType = true;
        } else {
          inModel.isType = false;
        }
      }
    });
  }

  void cityPickers() async {
    Result tempResult = await CityPickers.showCityPicker(
      context: context,
      citiesData: citiesDatas,
      locationCode: resultArr != null
          ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId
          : null,
    );
    if (tempResult != null) {
      setState(() {
        tempResult.cityName =
            tempResult.cityName == '全部' ? null : tempResult.cityName;
        tempResult.areaName =
            tempResult.areaName == '全部' ? null : tempResult.areaName;
        resultArr = tempResult;
      });
    }
  }

  //判断是否为搜索全部
  String searchRange(String city) {
    if (city == "全部" || city == null) {
      return '';
    } else {
      return city;
    }
  }

  handle(model) {
    setState(() {
      model.isType = true;
      switch (model.type) {
        case '类别':
          currentCategory = model;
          for (CategoryModel inModel in widget.data) {
            if (model.id != inModel.id) inModel.isType = false;
          }
          break;
        case '排名':
          currentRank = model;
          for (RankModel inModel in ranks) {
            if (model.id != inModel.id) inModel.isType = false;
          }
          break;
        case '距离':
          currentDistance = model;
          for (DistanceModel inModel in distances) {
            if (model.id != inModel.id) inModel.isType = false;
          }
          break;
        case '排序方式':
          currentOrderTypeModel = model;
          print('currentOrderTypeModel::${currentOrderTypeModel.toString()}');
          for (OrderTypeModel inModel in orderTypes) {
            if (model.id != inModel.id) inModel.isType = false;
          }
          break;
      }
    });
  }
}

class RankModel {
  final int id;
  final String name;
  bool isType;
  final String type;

  RankModel(this.id, this.name, this.isType, [this.type = '排名']);

  String toString() => 'id:$id,,name:$name';
}

class DistanceModel {
  final int id;
  final String name;
  bool isType;
  final String type;

  DistanceModel(this.id, this.name, this.isType, [this.type = '距离']);

  String toString() => 'id:$id,,name:$name';
}

class OrderTypeModel {
  final int id;
  final String name;
  bool isType;
  final String type;

  OrderTypeModel(this.id, this.name, this.isType, [this.type = '排序方式']);

  String toString() => 'id:$id,,name:$name';
}
