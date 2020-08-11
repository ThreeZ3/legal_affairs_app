import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/education_page.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_input.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/open_gender_dialog.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 律师用户添加个人信息页面

class LawyerInformationPersonal extends StatefulWidget {
  final String phone;
  final String code;

  LawyerInformationPersonal(this.phone, this.code);

  @override
  _LawyerInformationPersonalState createState() =>
      _LawyerInformationPersonalState();
}

class _LawyerInformationPersonalState extends State<LawyerInformationPersonal> {
  String name;
  String birthday;
  String email;
  String identityCard;
  String currentSex;
  String education;
  String isoTime;

  Result resultArr = new Result();
  bool whether = false;

  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: Scaffold(
        backgroundColor: Color(0xffF8F9F9),
        appBar: new NavigationBar(
          title: '基本信息',
          mainColor: ThemeColors.color333,
          backgroundColor: Colors.white,
          iconColor: ThemeColors.colorOrange,
          brightness: Brightness.light,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        LawyerInputTextFieldWidget(
                          head: '姓名',
                          title: '请输入真实姓名',
                          onChanged: (v) {
                            name = v;
                          },
                        ),
                        LawyerChoiceInput(
                          leading: '性别',
                          title: currentSex == null
                              ? '请选择您的性别'
                              : currentSex == '0' ? '男' : '女',
                          onTap: () {
                            openGenderDialog(context).then((value) {
                              if (!strNoEmpty(value)) return;
                              setState(() {
                                currentSex = value;
                              });
                            });
                          },
                        ),
                        LawyerChoiceInput(
                          leading: '学历',
                          title: education ?? '请输入您的学历',
                          onTap: () {
                            routePush(new EducationPage()).then((v) {
                              if (v == null) return;
                              setState(() {
                                education = v;
                              });
                            });
                          },
                        ),
                        LawyerChoiceInput(
                          leading: '执业时间',
                          title: isoTime?.substring(0, isoTime.indexOf('T')) ??
                              '请选择您的执业开始时间',
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1850),
                              lastDate: DateTime.now(),
                            ).then((DateTime time) {
                              if (time == null) return;
                              setState(() {
                                String iso = time.toIso8601String();
                                if (iso.length > 23) {
                                  isoTime =
                                      '${iso.substring(0, iso.length - 3)}Z';
                                } else {
                                  isoTime = '${iso}Z';
                                }
                              });
                            });
                          },
                        ),
                        LawyerChoiceInput(
                          leading: '区域',
                          title: whether
                              ? '${resultArr.provinceName}  ${resultArr.cityName}  ${resultArr.areaName}'
                              : '请选着所在地域',
                          onTap: () => cityPickers(),
                        ),
//                        LawyerInputTextFieldWidget(
//                          head: '生日',
//                          title: '示例：20001021',
//                          onChanged: (v) {
//                            birthday = v;
//                          },
//                        ),
                        LawyerChoiceInput(
                          leading: '生日',
                          title:
                              birthday?.substring(0, birthday.indexOf('T')) ??
                                  '请选择您的生日',
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1850),
                              lastDate: DateTime.now(),
                            ).then((DateTime time) {
                              if (time == null) return;
                              setState(() {
                                String iso = time.toIso8601String();
                                if (iso.length > 23) {
                                  birthday =
                                      '${iso.substring(0, iso.length - 3)}Z';
                                } else {
                                  birthday = '${iso}Z';
                                }
                              });
                            });
                          },
                        ),
                        LawyerInputTextFieldWidget(
                          head: '邮箱',
                          title: '请输入个人邮箱',
                          email: true,
                          onChanged: (v) {
                            email = v;
                          },
                        ),
                        LawyerInputTextFieldWidget(
                          head: '身份证号',
                          title: '请输入身份证号码',
//                          phone: true,
                          onChanged: (v) {
                            identityCard = v;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: RegisterButtonWidget(
                  title: '下一步',
                  onTap: () {
                    basicInformation();
                  }),
            ),
            SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
          ],
        ),
      ),
    );
  }

  void basicInformation() {
    registerLawyer
        .basicInformation(
      context,
      name: name,
      birthday: birthday,
      identityCard: identityCard,
      email: email,
      province: resultArr.provinceName,
      city: resultArr.cityName,
      district: resultArr.areaName,
      lng: 0,
      lat: 0,
      sex: currentSex,
      phone: widget.phone,
      code: widget.code,
      workYear: isoTime,
      education: education,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  ///城市选择
  void cityPickers() async {
    Result tempResult = await CityPickers.showCityPicker(
      context: context,
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
    }
  }
}
