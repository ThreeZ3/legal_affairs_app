import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-27
///
/// 律师 - 擅长领域页面

class LawyerChoicePage extends StatefulWidget {
  @override
  _LawyerChoicePageState createState() => _LawyerChoicePageState();
}

class _LawyerChoicePageState extends State<LawyerChoicePage> {
  TextStyle _styleOne = TextStyle(
    color: ThemeColors.color333,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle _styleTwo = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );
  Fields fieldData;
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> category = new List();
  List<CategoryModel> newCategory = new List();
  double weight = 0;
  List<Fields> categoryId = List();
  List<String> categoryName = List();
  Map type = Map();

  @override
  void initState() {
    super.initState();
    getCategory();
//    Notice.addListener(JHActions.legalField(), (v) {
//      getCategory();
//    });
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.taskRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '擅长领域',
        mainColor: ThemeColors.color333,
        backgroundColor: Color(0xffFAFAFA),
        iconColor: ThemeColors.colorOrange,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            //顶部标题
            _topTitle(),
            _labels(category, newCategory),
//            Expanded(
//              child: ListView(
//                children: <Widget>[
//                  Wrap(
//                    spacing: 10.0,
//                    runSpacing: 16.0,
//                    children: category.map((item) {
//                      CategoryModel model = item;
//                      return ButtonCheckBox(
//                        width: _width,
//                        onTap: () => _select(model),
//                        title: model.name.toString(),
//                        state: model.isType ? true : false,
//                      );
//                    }).toList(),
//                  ),
//                ],
//              ),
//            ),
            SizedBox(height: 16.0),
            RegisterButtonWidget(
              title: '确定',
              onTap: () => pop(type),
            ),
            SizedBox(height: 10.0),
          ],
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
            onTap: () => _select(model),
          ),
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
          '${model.weight.toStringAsFixed(0)}%',
          style: TextStyle(color: themeMainColor, fontSize: 13),
        ),
      ],
    );
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
        fieldData = new Fields(id: model.id, weight: _weight);
        categoryId.add(fieldData);
        categoryName.add(model.name);
      } else {
        categoryId.remove(fieldData);
        categoryName.remove(model.name);
      }
      type.addAll({'id': categoryId, 'name': categoryName});
      print(type);
    });
  }

  //顶部标题
  Widget _topTitle() {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '领域类别  ',
                  style: _styleOne,
                ),
                TextSpan(
                  text: '(选择擅长的领域，可多选)',
                  style: _styleTwo,
                ),
              ],
            ),
          ),
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
    );
  }

  void _showDialog() {
    confirmAlert(
      context,
      (bool isOk) {},
      input: true,
      tips: '添加类别',
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
}

class ButtonCheckBox extends StatefulWidget {
  final String title;
  final bool state;
  final GestureTapCallback onTap;
  final double width;

  const ButtonCheckBox({
    Key key,
    this.title,
    this.state = false,
    this.onTap,
    this.width = 30,
  }) : super(key: key);

  @override
  _ButtonCheckBoxState createState() => _ButtonCheckBoxState();
}

class _ButtonCheckBoxState extends State<ButtonCheckBox> {
  TextStyle _styleSelect = TextStyle(
    color: ThemeColors.colorOrange,
    fontSize: 14.0,
  );
  TextStyle _styleUnchecked = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: 28.0,
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: widget.state ? _styleUnchecked : _styleSelect,
        ),
        decoration: BoxDecoration(
          color: widget.state ? ThemeColors.colorOrange : Colors.white,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: ThemeColors.colorOrange, width: 0.5),
        ),
      ),
    );
  }
}

Color themeMainColor = Color(0xffFFE1B96B);
