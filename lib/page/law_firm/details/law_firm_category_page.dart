import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-04
///
/// 律师详情(律师)-业务类别设置页

class LawFirmCategoryPage extends StatefulWidget {
  final List<LegalField> categoryList;

  const LawFirmCategoryPage({Key key, this.categoryList}) : super(key: key);

  @override
  _LawFirmCategoryPageState createState() => _LawFirmCategoryPageState();
}

class _LawFirmCategoryPageState extends State<LawFirmCategoryPage> {
  List<CategoryModel> category = new List();
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> newCategory = new List();
  List<Field> categoryId = new List();
  List newList;
  CategoryModel categoryModel;
  Field fieldData;
  List<Setting> list = new List();
  List<String> categoryName = List();
  double weight = 0;
  Map type = Map();

  @override
  void initState() {
    super.initState();
    getCategory();
    Notice.addListener(JHActions.legalField(), (v) {
      getCategory();
    });
  }

  ///获取业务类型
  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  void _showDialog() {
    confirmAlert(
      context,
      (bool isOk) {},
      input: true,
      tips: '新增类型',
      length: 6,
      hintTextSize: 12.0,
    ).then((result) {
      if (!strNoEmpty(result)) return;
      String id = result.toString().split('+')[1].replaceAll('id:', '');
      String name = result.toString().split('+')[0];
      setState(() {
        newCategory..add(CategoryModel(name: name, id: id));
      });
      print('新增的类别::::::::::$name');
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  _select(CategoryModel model) {
    double _weight = double.parse(model.weight.toStringAsFixed(0)) * 0.01;
    setState(() {
      if (!model.isType) {
        currentCategory = model;
        model.isType = true;
        print('ID:${model.id},类别:${model.name}');
      } else {
        model.isType = false;
        print('当前取消的类别:${model.name}');
      }
      if (model.isType == true) {
        fieldData = new Field(id: model.id, weight: _weight);
        categoryId.add(fieldData);
        categoryName.add(model.name);
      } else {
        categoryId.remove(fieldData);
        categoryName.remove(model.name);
      }
      type.addAll({'id': categoryId, 'name': categoryName});
      print('typetype::$type');
    });
  }

  ///修改新的业务类别
  void changeFirmField() {
    myLawFirmViewModel
        .changeFirmField(
      context,
      legalFieldIds: type['id'],
    )
        .catchError((e) {
      showToast(context, e.message);
    });
    pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.legalField());
  }

  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NavigationBar(
          title: "业务类别",
          rightDMActions: <Widget>[
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Image.asset(
                GoodSelectPic,
                width: 21,
              ),
              onPressed: () {
                changeFirmField();
              },
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _title("业务类别"),
                  GestureDetector(
                    onTap: () => _showDialog(),
                    child: Image.asset(
                      'assets/register/icon_add.png',
                      width: 20.0,
                      height: 20.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              _labels(category ?? [], newCategory ?? []),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labels(List defaultList, List newList) {
    return Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: defaultList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              categoryWidget(defaultList[index], false),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: newList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => categoryWidget(newList[index], true),
        ),
      ],
    );
  }

  Widget categoryWidget(v, bool del) {
    CategoryModel model = v;
    return Row(
      children: <Widget>[
        Container(
          child: ButtonCheckBox(
              width: MediaQuery.of(context).size.width / 6,
              title: model.name.toString(),
              state: model.isType ? true : false,
              onTap: () => _select(model)),
        ),
        Space(),
        del
            ? InkWell(
                child: Image.asset(
                  'assets/images/lawyer/input_delete.png',
                  width: 15,
                ),
                onTap: () {
                  setState(() {
                    newCategory.remove(model);
                  });
                },
              )
            : SizedBox(),
        Expanded(
          child: Slider(
            inactiveColor: themeMainColor.withOpacity(0.2),
            activeColor: themeMainColor,
            min: 0.0,
            max: 100.0,
            value: model.weight,
            onChanged: (value) {
              setState(() {
                model.weight = value;
              });
            },
          ),
        ),
        Text(
          '${model.weight <= 1 ? (model.weight * 100).toStringAsFixed(0) : model.weight.toStringAsFixed(0)}%',
          style: TextStyle(color: themeMainColor, fontSize: 13),
        ),
      ],
    );
  }

  Widget _title(String title) {
    return Container(
      padding: EdgeInsets.only(left: 2),
      margin: EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
