import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/add_email.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/add_phone.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/add_wx.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/create_ok.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:jh_legal_affairs/widget_common/dialog/select_photo_dialog.dart';

///创建律所页面
class CreateLawFirmPage extends StatefulWidget {
  @override
  _CreateLawFirmPageState createState() => _CreateLawFirmPageState();
}

class _CreateLawFirmPageState extends State<CreateLawFirmPage> {
  TextEditingController controllerAddress;
  TextEditingController controllerName;
  TextEditingController controllerIdea;
  TextEditingController controllerIntroduction;
  TextEditingController controllerHttp;
  TextEditingController controllerWx;
  TextEditingController photoController;
  TextEditingController wxnumberController;
  TextEditingController emailnumberController;
  List<CategoryModel> category;
  List<CategoryModel> newCategory = new List();
  List<Field> categoryId;
  List newList;
  CategoryModel categoryModel;
  String firmAvatar;
  Field fieldData;
  List firmPicList = ["1"];
  List firmHonorList = ["1"];
  List firmQualification = ["1"];
  List firmLicenseList = ["1"];
  List firmOfficial = ["1"];
  List<Setting> list;
  Result resultArr;
  List<Photo> emailList = [Photo(title: "民商", value: "", id: "")];
  List<Photo> phoneList = [Photo(title: "民商", value: "", id: "")];
  List<Photo> wxList = [Photo(title: "民商", value: "", id: "")];
  List _phoneData = new List();
  List _wxData = new List();
  List _emailData = new List();
  double weight = 0;

  @override
  void initState() {
    resultArr = new Result();
    category = new List();
    controllerAddress = TextEditingController();
    controllerName = TextEditingController();
    controllerIdea = TextEditingController();
    controllerIntroduction = TextEditingController();
    controllerHttp = TextEditingController();
    controllerWx = TextEditingController();
    photoController = TextEditingController();
    wxnumberController = TextEditingController();
    emailnumberController = TextEditingController();
    list = new List();
    categoryId = new List();

    super.initState();
    getCategory();
    Notice.addListener(JHActions.legalField(), (v) {
      getCategory();
    });
  }

  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => category = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }
  Future postCreateLawFirm() async {
    list.addAll([
      Setting(title: "公众号", type: 5, value: controllerWx?.text ?? " "),
      Setting(title: "网址", type: 4, value: controllerHttp?.text ?? " "),
    ]);
    getNewList(phoneList, 1);
    getNewList(emailList, 2);
    getNewList(wxList, 3);
    addData("照片", 6, _cutList(firmPicList));
    addData("社会荣誉", 8, _cutList(firmHonorList));
    addData("律所公函", 10, _cutList(firmOfficial));
    addData("执业许可", 11, _cutList(firmLicenseList));
    addData("资质证明", 9, _cutList(firmQualification));
    await firmViewModel
        .createFirm(
          context,
          address: controllerAddress.text,
          //todo 三级城市选择器
          province: resultArr.areaName,
          city: resultArr.cityName,
          district: resultArr.provinceName,
          firmAvatar: firmAvatar,
          town: "所属镇",
          firmInfo: controllerIntroduction.text,
          firmName: controllerName.text,
          setting: list,
          firmValue: "5",
          lat: '${location?.latitude ?? '0'}',
          lng: '${location?.longitude ?? '0'}',
          legalField: categoryId,
        )
        .then((rep) => routePush(CreateOk()))
        .catchError((e) => showToast(context, e.message));
  }

  void addData(String title, int type, List listData) {
    if (listNoEmpty(list)) {
      for (int i = 0; i < listData.length; i++) {
        list.add(
          Setting(title: title, type: type, value: listData[i].toString()),
        );
      }
    }
  }

  void getNewList(List listData, int type) {
    if (listNoEmpty(list)) {
      for (int i = 0; i < listData.length; i++) {
        list.add(
          Setting(
              title: listData[i].title,
              type: type,
              value: listData[i].value.toString()),
        );
      }
    }
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
      print('新增的类别::::::::::$result');
      List _list = result.split('+');
      categoryModel =
          new CategoryModel(id: _list[1], name: _list[0], isType: false);
      newCategory.add(categoryModel);
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    list.clear();
    categoryId.clear();
    category.clear();
    super.dispose();
    weight = 0;
    Notice.removeListenerByEvent(JHActions.taskRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: Scaffold(
        appBar: NavigationBar(
          title: "创建律所",
          rightDMActions: <Widget>[
            InkWell(
              onTap: () => postCreateLawFirm(),
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Text(
                  "下一步",
                  style: TextStyle(fontSize: 14, color: themeMainColor),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _title("律所名称"),
              _inputName(),
              _title("律所头像"),
              _firmAvatar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _title("律所业务"),
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
              _labels(category, newCategory),
              SizedBox(height: 16),
              _title("律所理念"),
              _richInputText('输入律所理念', controllerIdea),
              _title("律所简介"),
              _richInputText("输入律所简介", controllerIntroduction),
              _title("律所地址"),
              _chooseAddress(),
              _inputWidget("详细地址：如道路，门牌号，小区，楼栋号，单元，等，小区，楼栋号，单元，等", 2),
              _title("律所电话"),
              _iPone(),
              _title("律所微信"),
              _wxWidget(),
              _title("律所邮箱"),
              _email(),
              _title("律所网址"),
              _inputInter(),
              _title("律所公众号"),
              _inputWx(),
              _title("律所照片"),
              _firmPic(firmPicList),
              _title("社会荣誉"),
              _firmPic(firmHonorList),
              _title("资质证明"),
              _firmPic(firmQualification),
              _title("律所公函"),
              _firmPic(firmOfficial),
              _title("执业许可"),
              _firmPic(firmLicenseList),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Container(
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: themeMainColor))),
      padding: EdgeInsets.only(left: 2),
      margin: EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _inputName() {
    return TextField(
      controller: controllerName,
      decoration: InputDecoration(
          hintText: "输入律所名称",
          hintStyle: TextStyle(fontSize: 14, color: themeGrayColor)),
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
//    double _maxWidth = MediaQuery.of(context).size.width - (16 * 2 + 16 * 4);
//    double _width = _maxWidth / 5;
//    return Wrap(
//      spacing: 16.0,
//      runSpacing: 8.0,
//      children: list.map((item) {
//        CategoryModel model = item;
//        return ButtonCheckBox(
//          width: _width,
//          onTap: () {
//            setState(() {
//              model.isType = !model.isType;
//              if (model.isType == true) {
//                categoryId.add(model.id);
//              } else {
//                categoryId.remove(model.id);
//              }
//            });
//          },
//          title: model.name.toString(),
//          state: model.isType ? true : false,
//        );
//      }).toList(),
//    );
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
              onTap: () {
                double _weight =
                    double.parse(model.weight.toStringAsFixed(0)) * 0.01;
                setState(() {
                  model.isType = !model.isType;
                  if (model.isType == true) {
                    weight = weight + _weight;
                    print('all:$weight');
                    fieldData = new Field(id: model.id, weight: _weight);
                    categoryId.add(fieldData);
                    print(categoryId);
                  } else {
                    weight = weight - _weight;
                    print('all:$weight');
                    categoryId.remove(fieldData);
                    print(categoryId);
                  }
                });
              }),
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

  Widget _richInputText(String init, TextEditingController controllerInput) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: lightGrayColor, borderRadius: BorderRadius.circular(8)),
        child: TextField(
          controller: controllerInput,
          maxLines: 5,
          decoration: InputDecoration.collapsed(
              hintText: init,
              hintStyle: TextStyle(fontSize: 14, color: themeGrayColor)),
        ));
  }

  Widget _inputWidget(String init, int maxLine) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.2, color: themeGrayColor))),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controllerAddress,
        decoration: InputDecoration.collapsed(
          hintText: init,
          hintStyle: TextStyle(fontSize: 14, color: themeGrayColor),
        ),
        maxLines: maxLine,
      ),
    );
  }

  Widget _chooseAddress() {
    return InkWell(
        onTap: cityPickers,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.2, color: themeGrayColor))),
          child: Row(
            children: <Widget>[
              Text(
                "所在地址",
                style: TextStyle(color: themeGrayColor),
              ),
              Space(),
              Text(
                '${resultArr?.provinceName ?? " "} ${resultArr?.cityName ?? " "} ${resultArr?.areaName ?? ""} ',
                style: TextStyle(color: themeGrayColor),
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_right,
                size: 14,
                color: themeGrayColor,
              )
            ],
          ),
        ));
  }

  void cityPickers() async {
    Result tempResult = await CityPickers.showFullPageCityPicker(
      context: context,
      locationCode: resultArr != null
          ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId
          : null,
    );
    if (tempResult != null) {
      setState(() {
        resultArr = tempResult;
      });
    }
  }

  Widget _iPone() {
    return Wrap(
      children: List.generate(phoneList.length, (index) {
        return Container(
          width: (winWidth(context) - 40 / 2),
          child: Column(
            children: <Widget>[
              PhoneListWidget(
                controller: photoController,
                list: phoneList,
                index: index,
                formats: numFormatter,
                icon: index == phoneList.length - 1
                    ? Image.asset(
                        "assets/images/law_firm/full_add@3x.png",
                        width: 17,
                        height: 17,
                      )
                    : Image.asset(
                        "assets/images/law_firm/minus@3x.png",
                        width: 17,
                        height: 17,
                      ),
                hintText: '${phoneList[index].value}',
                id: phoneList[index].id,
                title: phoneList[index].title,
                isLast: index == phoneList.length - 1 ? true : false,
                onAdd: () {
                  if (strNoEmpty(phoneList[index].value)) {
                    Photo addList = Photo(
                      title: '民商',
                      type: '电话',
                      value: '',
                    );
                    setState(() {
                      phoneList.add(addList);
                    });
                  } else {
                    showToast(context, "请输入号码");
                  }
                },
                onTap: () {
                  setState(() {
                    phoneList.removeAt(index);
                  });
                  _phoneData.removeAt(index);
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _wxWidget() {
    return Wrap(
      children: List.generate(wxList.length, (index) {
        return Container(
          width: (winWidth(context) - 40 / 2),
          child: Column(
            children: <Widget>[
              WxListWidget(
                controller: wxnumberController,
                list: wxList,
                index: index,
                icon: index == wxList.length - 1
                    ? Image.asset(
                        "assets/images/law_firm/full_add@3x.png",
                        width: 17,
                        height: 17,
                      )
                    : Image.asset(
                        "assets/images/law_firm/minus@3x.png",
                        width: 17,
                        height: 17,
                      ),
                hintText: '${wxList[index].value}',
                id: wxList[index].id,
                title: wxList[index].title,
                isLast: index == wxList.length - 1 ? true : false,
                onAdd: () {
                  if (strNoEmpty(wxList[index].value)) {
                    Photo addList = Photo(
                      title: '民商',
                      type: '微信',
                      value: '',
                    );
                    setState(() {
                      wxList.add(addList);
                    });
                  } else {
                    showToast(context, "请输入微信号");
                  }
                },
                onTap: () {
                  setState(() {
                    wxList.removeAt(index);
                  });
                  _wxData.removeAt(index);
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _email() {
    return Column(
      children: List.generate(emailList.length, (index) {
        return Container(
          width: (winWidth(context) - 32),
          child: Column(
            children: <Widget>[
              EmailListPage(
                list: emailList,
                index: index,
                icon: index == emailList.length - 1
                    ? Image.asset(
                        "assets/images/law_firm/full_add@3x.png",
                        width: 17,
                        height: 17,
                      )
                    : Image.asset(
                        "assets/images/law_firm/minus@3x.png",
                        width: 17,
                        height: 17,
                      ),
                hintText: '${emailList[index].value}',
                id: emailList[index].id,
                title: emailList[index].title,
                isLast: index == emailList.length - 1 ? true : false,
                onAdd: () {
                  if (strNoEmpty(emailList[index].value)) {
                    Photo addList = Photo(
                      title: '民商',
                      type: '邮箱',
                      value: '',
                    );
                    setState(() {
                      emailList.add(addList);
                    });
                  } else {
                    showToast(context, "请输入邮箱");
                  }
                },
                onTap: () {
                  setState(() {
                    emailList.removeAt(index);
                    _emailData.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _inputInter() {
    return Column(
      children: <Widget>[
        TextField(
          controller: controllerHttp,
          decoration: InputDecoration.collapsed(
            hintText: "输入律所网址",
            hintStyle: TextStyle(fontSize: 14, color: themeGrayColor),
          ),
          onChanged: (tex) {
            print(tex);
          },
          onSubmitted: (text) {
            if (!isUrl(text)) {
              showToast(context, "输入的网址不对");
              controllerHttp.text = "";
            }
          },
        ),
        new Divider(),
//        Container(
//          width: winWidth(context) - 32,
//          child: DashedRect(color: Color(0xff979797), strokeWidth: 4, gap: 5.0),
//        ),
      ],
    );
  }

  Widget _inputWx() {
    return Column(
      children: <Widget>[
        TextField(
          controller: controllerWx,
          decoration: InputDecoration.collapsed(
              hintText: "输入律所公众号",
              hintStyle: TextStyle(fontSize: 14, color: themeGrayColor)),
        ),
        new Divider(),
//        Container(
//          width: winWidth(context) - 32,
//          child: DashedRect(color: Color(0xff979797), strokeWidth: 4, gap: 5.0),
//        ),
      ],
    );
  }

  ///获取图库视频
  _getPic(List list) async {
    String _image;
    selectPhotoDialog(context, openGallery: () async {
      File pic = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (pic == null) return;
      await systemViewModel.uploadFile(context, file: pic).then((rep) {
        _image = rep.data['data'];
        setState(() {
          list.insert(list.length - 1, _image);
        });
      }).catchError((e) => showToast(context, e.message));
    }, takePhoto: () async {
      File pic = await ImagePicker.pickImage(source: ImageSource.camera);
      if (pic == null) return;
      await systemViewModel.uploadFile(context, file: pic).then((rep) {
        _image = rep.data['data'];
        setState(() {
          list.insert(list.length - 1, _image);
        });
      }).catchError((e) => showToast(context, e.message));
    });
  }

  Widget _firmAvatar() {
    return firmAvatar == null
        ? InkWell(
            child: Container(
              height: 90,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3),
              color: Color(0xffF5F5F5),
              child: Image.asset(
                'assets/register/icon_add.png',
              ),
            ),
            onTap: () {
              setState(() {
                _getFirmAvatar();
              });
            },
          )
        : SizedBox(
            height: 90,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  height: 90,
                  color: Color(0xffF5F5F5),
                  margin: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: MediaQuery.of(context).size.width / 3),
                  child: Image.network(firmAvatar),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        firmAvatar = null;
                      });
                    },
                    child: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          );
  }

  _getFirmAvatar() async {
    selectPhotoDialog(context, openGallery: () async {
      File pic = await ImagePicker.pickImage(source: ImageSource.gallery);
      handle(pic);
    }, takePhoto: () async {
      File pic = await ImagePicker.pickImage(source: ImageSource.camera);
      handle(pic);
    });
  }

  handle(pic) async {
    if (pic == null) return;
    await systemViewModel.uploadFile(context, file: pic).then((rep) {
      setState(() => firmAvatar = rep.data['data']);
    }).catchError((e) => showToast(context, e.message));
  }

  Widget _firmPic(List list) {
    double picSize = (winWidth(context) - 80) / 4;
    return Wrap(
      children: List.generate(list.length, (index) {
        if (index != list.length - 1) {
          return Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Image.network(list[index],
                      width: picSize, height: picSize, fit: BoxFit.cover)),
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      list.removeAt(index);
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        } else {
          return InkWell(
            onTap: () {
              setState(() {
                _getPic(list);
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: picSize,
              height: picSize,
              decoration: BoxDecoration(
                color: lightGrayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.black,
              ),
            ),
          );
        }
      }),
    );
  }

  List _cutList(List list) {
    newList = new List();
    newList.addAll(list);

    if (newList.length == 1) {
      newList = [];
    } else {
      newList.removeLast();
    }
    return newList;
  }
}

Color themeMainColor = Color(0xffFFE1B96B);
Color themeGrayColor = Color(0xffFF999999);
Color lightGrayColor = Color(0xffFFF0F0F0);
