import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/other/photo_show_page.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/open_gender_dialog.dart';
import 'package:jh_legal_affairs/widget_common/my_province.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-20
///
/// 我的（普通用户）-修改用户资料*版本2

class NorMalUserModifiesDataPage extends StatefulWidget {
  final String name;

  NorMalUserModifiesDataPage(this.name);

  @override
  _NorMalUserModifiesDataPageState createState() =>
      _NorMalUserModifiesDataPageState();
}

class _NorMalUserModifiesDataPageState
    extends State<NorMalUserModifiesDataPage> {
  Result resultArr = new Result();
  bool whether = false;
  bool isChangeFiled = false;
  LawyerInfoModel lawyerInfoModel = new LawyerInfoModel();

  Fields fieldData;
  CategoryModel currentCategory = new CategoryModel();
  List<CategoryModel> category = new List();
  List<CategoryModel> newCategory = new List();
  double weight = 0;
  List<Fields> categoryId = List();
  List<String> categoryName = List();
  Map type = Map();

  TextEditingController nameC = new TextEditingController();

  TextStyle _styleOne = TextStyle(
    color: ThemeColors.color333,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle _styleTwo = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );

  @override
  void initState() {
    super.initState();
    nameC.text = JHData.nickName();
    if (JHData.userType() == '2;律师') {
      getCategory();
      getLawyerInfo();
    }
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  getLawyerInfo() {
    loginViewModel.lawyerCurInfo(context).then((rep) {
      setState(() {
        lawyerInfoModel = rep.data;
      });
    }).catchError((e) {
      print('${e.message}');
    });
  }

  legalField() {
    lawyerInFoViewModel
        .lawyerLegalField(
      context,
      ids: type['id'],
    )
        .catchError((e) {
      showToast(context, e?.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainInputBody(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: new NavigationBar(
          rightDMActions: <Widget>[
            GestureDetector(
              onTap: () {
                updateInfo(nameC.text);
                if (JHData.userType() == '2;律师' && isChangeFiled) legalField();
                pop();
              },
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Image.asset("assets/images/law_firm/good_select_pic.png",
                    width: 22.39),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            CustomRowBox(
              '头像',
              CircleAvatar(
                radius: 60 / 2,
                backgroundImage: CachedNetworkImageProvider(
                  JHData.avatar(),
                ),
              ),
              onTap: _openHeaderDialog,
            ),
            CustomRowBox(
              '昵称',
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: nameC,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '输入昵称',
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 14,
                      ),
                    ),
                    cursorColor: Color(0xff333333),
                    cursorWidth: 1,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            new Visibility(
              visible: JHData.userType() == '2;律师',
              child: CustomRowBox(
                '真实姓名',
                Text(
                  widget.name ?? '未知名字',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  showToast(context, '真实姓名不允许修改');
                },
              ),
            ),
            CustomRowBox(
              '性别',
              Text(
                JHData.sex() == '0' ? '男' : '女',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                openGenderDialog(context).then((value) {
                  if (!strNoEmpty(value)) return;
                  setState(() {
                    Store(JHActions.sex()).value = value;
                    storeString(JHActions.sex(), value);
                  });
                  updateInfo();
                });
              },
            ),
            InkWell(
              onTap: () => cityPickers(),
              child: CustomRowBox(
                '地区',
                Text(
                  '${JHData.city()} ${JHData.district()}',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            new Visibility(
              visible: JHData.userType() == '2;律师',
              child: new FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {
                  setState(() {
                    isChangeFiled = !isChangeFiled;
                  });
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      '修改类别',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    new CupertinoSwitch(
                        value: isChangeFiled,
                        onChanged: (v) {
                          setState(() {
                            isChangeFiled = v;
                          });
                        }),
                  ],
                ),
              ),
            ),
            new Visibility(
              visible: JHData.userType() == '2;律师' && isChangeFiled,
              child: Column(
                children: <Widget>[
                  //顶部标题
                  Container(
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
                  ),
                  new Column(
                    children: category
                        .map((item) => categoryWidget(item, false))
                        .toList(),
                  ),
                  new Column(
                    children: newCategory
                        .map((item) => categoryWidget(item, true))
                        .toList(),
                  ),
//                  new Container(
//                    height: 800,
//                    child: _labels(category, newCategory),
//                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
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
      print('typetype::$type');
    });
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

  updateInfo([String name]) {
    if (strNoEmpty(name)) {
      Store(JHActions.nickName()).value = name;
      storeString(JHActions.nickName(), name);
    }

    loginViewModel
        .updateInfo(
      context,
      province: JHData.province(),
      city: JHData.city(),
      district: JHData.district(),
      avatar: JHData.avatar(),
      sex: JHData.sex(),
      nickName: nameC.text,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  //打开头像底部弹出框
  _openHeaderDialog() async {
    var result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: ['0', '拍照', '相册'].map((item) {
              return item == '0'
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        '选择头像',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          print(item);
                          if (item == '拍照') {
                            Navigator.pop(context);
                            return _takePhoto();
                          } else if (item == '相册') {
                            Navigator.pop(context);
                            return _openGallery();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
            }).toList(),
          ),
        );
      },
    );
    return result;
  }

  //图片控件
  Widget _imageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text('请选择相册或拍照'),
      );
    } else {
      return Image.file(imgPath);
    }
  }

  //拍照
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    routePush(new PhotoShowPage(
      image,
      onPressed: () => okFile(image),
    ));
  }

  okFile(image) {
    systemViewModel.uploadFile(context, file: image).then((rep) {
      if (!strNoEmpty(rep.data['data'])) return;
      setState(() {
        Store(JHActions.avatar()).value = rep.data['data'];
        storeString(JHActions.avatar(), rep.data['data']);
      });
      updateInfo();
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  //相册
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    routePush(new PhotoShowPage(
      image,
      onPressed: () => okFile(image),
    ));
  }

  //城市选择器
  ///城市选择
  void cityPickers() async {
    Result tempResult = await CityPickers.showCityPicker(
      context: context,
      citiesData: citiesDataChoose,
      /*theme: Theme.of(context).copyWith(primaryColor: Color(0xfffe1314)),*/
      locationCode: resultArr != null
          ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId
          : null,
      cancelWidget: Text(
        '取消',
        style: TextStyle(color: ThemeColors.color333, fontSize: 16.0),
      ),
      confirmWidget: Text(
        '确定',
        style: TextStyle(color: Color(0xFF2D88FF), fontSize: 16.0),
      ),
      height: 267.0,
    );
    if (tempResult != null) {
      setState(() {
        resultArr = tempResult;
        whether = true;
      });
      Store(JHActions.city()).value = resultArr.cityName;
      storeString(JHActions.city(), resultArr.cityName);
      Store(JHActions.district()).value = resultArr.areaName;
      storeString(JHActions.district(), resultArr.areaName);
      Store(JHActions.province()).value = resultArr.provinceName;
      storeString(JHActions.province(), resultArr.provinceName);
      updateInfo();
    }
  }
}

//自定义盒子
class CustomRowBox extends StatefulWidget {
  final String text;
  final Widget rightWidget;
  final GestureTapCallback onTap;

  CustomRowBox(this.text, this.rightWidget, {this.onTap});

  @override
  _CustomRowBoxState createState() => _CustomRowBoxState();
}

class _CustomRowBoxState extends State<CustomRowBox> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Column(
        children: <Widget>[
          rowItem(), //横向item
          rowLine(), //间隔条
        ],
      ),
      onTap: widget.onTap,
    );
  }

  //横向item
  Widget rowItem() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: widget.rightWidget,
          ),
        ],
      ),
    );
  }

  //间隔条
  Widget rowLine() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width - 32,
      color: Color(0xfff0f0f0),
    );
  }
}
