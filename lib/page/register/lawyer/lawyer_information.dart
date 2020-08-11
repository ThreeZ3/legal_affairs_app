import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_input.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_choice_page.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
import 'package:jh_legal_affairs/page/register/lawyer/practice_agency_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/dialog/select_photo_dialog.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 律师信息注册页面

class LawyerInformation extends StatefulWidget {
  final String phone;
  final String id;

  LawyerInformation(this.phone, this.id);

  @override
  _LawyerInformationState createState() => _LawyerInformationState();
}

class _LawyerInformationState extends State<LawyerInformation> {
  //背景图
  String _idCardImg = 'assets/register/id_card_front.png';
  String _idCardBackImg = 'assets/register/id_card_reverse.png';
  String _lawyerCardImg = 'assets/register/lawyer_card.png';

  //获取的数据
  Map _firmName;
  String _strName;
  String _lawyerCard;
  Map _type;

  bool _state = false;

  //选择的图片
  String _getImageOne;
  String _getImageTwo;
  String _getImageThree;

  @override
  void initState() {
    super.initState();
    Notice.addListener(JHActions.taskRefresh(), (v) {
      testFileThree();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _maxWidth = MediaQuery.of(context).size.width - (16 * 2 + 13.0);
    double _width = _maxWidth / 2;
    return new MainInputBody(
      child: Scaffold(
        backgroundColor: Color(0xffF8F9F9),
        appBar: NavigationBar(
          title: '执业信息',
          mainColor: ThemeColors.color333,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconColor: ThemeColors.colorOrange,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 156,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        LawyerChoiceInput(
                          leading: '执业机构',
                          title: _firmName != null
                              ? _firmName['firmName']
                              : strNoEmpty(_strName) ? _strName : '请选择执业机构',
                          onTap: () {
                            routePush(new PracticeAgencyPage()).then((value) {
                              if (value == null) return;
                              if (value is String) {
                                _strName = value;
                                _firmName = null;
                              } else {
                                _firmName = value;
                                _strName = null;
                              }
                              setState(() {});
                            });
                          },
//                          onChanged: (v) {
//                            _firmName = v;
//                            print(_firmName);
//                          },
                        ),
                        LawyerInputTextFieldWidget(
                          head: '执业证号',
                          title: ' 请输入执业证号',
                          onChanged: (v) {
                            _lawyerCard = v;
                            print(_lawyerCard);
                          },
                        ),
                        LawyerChoiceInput(
                            leading: '擅长领域',
                            title: _state &&
                                    _type != null &&
                                    strNoEmpty(_type['name'].toString())
                                ? '${_type['name'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '、')}'
                                : '请选择擅长领域',
                            onTap: () {
                              routePush(LawyerChoicePage()).then((v) {
                                if (v == null) return;
                                Map innerType = v;
                                setState(() {
                                  if (innerType.isEmpty) {
                                    return;
//                                    _state = false;
                                  } else {
                                    _state = true;
                                    _type = v;
                                  }
                                  print('返回的类别:::$_type');
                                });
                              }).catchError((e) {
                                showToast(context, e.message);
                              });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    color: Color(0xffF8F9F9),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '*请上传本人真实有效的身份证正面照片以及律师职业资格证',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 51.0),
                        Wrap(
                          spacing: 13.0,
                          children: <Widget>[
                            IdCard(
                              width: _width,
                              title: '上传身份证正面',
                              image: _idCardImg,
                              onTap: () => testFileOne(),
                              child: _getImageOne != null
                                  ? CachedNetworkImage(
                                      imageUrl: _getImageOne,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/register/icon_photograph.png',
                                      width: 36.0,
                                      height: 36.0,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            IdCard(
                              width: _width,
                              title: '上传身份证反面',
                              image: _idCardBackImg,
                              onTap: () => testFileTwo(),
                              child: _getImageTwo != null
                                  ? CachedNetworkImage(
                                      imageUrl: _getImageTwo,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/register/icon_photograph.png',
                                      width: 36.0,
                                      height: 36.0,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: 21.0),
                        Center(
                          child: IdCard(
                            width: 262.0,
                            height: 134.0,
                            title: '上传执业证书',
                            image: _lawyerCardImg,
                            onTap: () => testFileThree(),
                            child: _getImageThree != null
                                ? CachedNetworkImage(
                                    imageUrl: _getImageThree,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/register/icon_photograph.png',
                                    width: 36.0,
                                    height: 36.0,
                                    fit: BoxFit.cover,
                                  ),
                          ),
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
                title: '提交',
                onTap: () => practiceInformation(),
              ),
            ),
            SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
          ],
        ),
      ),
    );
  }

  String images =
      'http://img-dev-ugc.qqtowns.com/201907/4BC12348C4164EDF934AC42970801C73.png';

  void practiceInformation() {
    if (_firmName != null) {
      firmViewModel.applyFirm(context, id: _firmName['id']).catchError((e) {
        print('e---------------------->${e.toString()}');
        showToast(context, e.message);
      });
      _commit(_firmName['firmName']);
    } else if (strNoEmpty(_strName)) {
      _commit(_strName);
    } else {
      showToast(context, '请补齐资料');
    }
  }

  void _commit(String name) {
    registerLawyer
        .practiceInformation(
      context,
      widget.phone,
      firmName: name,
      id: widget.id,
      idCardBackImg: _getImageOne,
      idCardImg: _getImageOne,
      lawyerCard: _lawyerCard,
      lawyerCardBackImg: images,
      lawyerCardImg: _getImageThree,
      legalField: _type['id'],
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  testFileOne() async {
    File image;
    selectPhotoDialog(context, openGallery: () async {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageOne = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }, takePhoto: () async {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageOne = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    });
  }

  testFileTwo() async {
    File image;
    selectPhotoDialog(context, openGallery: () async {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageTwo = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }, takePhoto: () async {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageTwo = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    });
  }

  testFileThree() async {
    File image;
    selectPhotoDialog(context, openGallery: () async {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageThree = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    }, takePhoto: () async {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      systemViewModel.uploadFile(context, file: image).then((rep) {
        setState(() {
          _getImageThree = rep.data['data'];
        });
      }).catchError((e) {
        showToast(context, e.message);
      });
    });
  }
}

class IdCard extends StatefulWidget {
  final String image;
  final String title;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  final Widget child;

  const IdCard({
    Key key,
    this.image,
    this.title,
    this.onTap,
    this.width = 100,
    this.height = 115.0,
    this.child,
  }) : super(key: key);

  @override
  _IdCardState createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: widget.child,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  widget.image,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          widget.title,
          style: TextStyle(
            color: ThemeColors.color999,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
