import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_email_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_picture_page.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_we_chat_page.dart';
import 'package:jh_legal_affairs/page/law_firm/phone_number_page.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_setting_other_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/widget_common/view/image_photo.dart';

/// 创建者：李鸿杰
/// 开发者：李鸿杰
/// 创建日期：2020-05-09
///
/// 我的-律所详情(超级管理员)-详细资料设置页
///
class MyLawFirmSettingDetailsPage extends StatefulWidget {
  final String id;

  const MyLawFirmSettingDetailsPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _MyLawFirmSettingDetailsPageState createState() =>
      _MyLawFirmSettingDetailsPageState();
}

class _MyLawFirmSettingDetailsPageState
    extends State<MyLawFirmSettingDetailsPage> {
  bool selectDeletePic = false;
  bool selectDeleteHonor = false;
  bool selectDeletecRedentials = false;
  ViewMyFirmDetailModel _dataList = new ViewMyFirmDetailModel();

  @override
  void initState() {
    super.initState();
    viewMyFirmDetail();
    Notice.addListener(JHActions.myFirmDetailRefresh(), (v) {
      viewMyFirmDetail();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myFirmDetailRefresh());
  }

  ///查看我的律所数据详情
  viewMyFirmDetail() {
    myLawFirmViewModel
        .viewMyFirmDetails(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        _dataList = rep.data;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  /// 删除律所相关照片
  Future delFirmInfo(id) async {
    firmViewModel
        .delFirmSetting(
      context,
      id,
    )
        .then((rep) {
      showToast(context, '删除成功');
      viewMyFirmDetail();
    }).catchError((e) {
      setState(() => {});
      showToast(context, e.message);
    });
  }

  delDialog(id) {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定删除该照片？',
      okFunction: () {
        delFirmInfo(id);
      },
      cancelFunction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '详细资料',
      ),
      body: _dataList.id != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: <Widget>[
                IconTitleTileWidget(
                  title: '律所地址',
                  onTapEditTwo: () => routePush(MyLawSettingOtherPage(
                    title: '律所地址',
                    hintText: _dataList?.address,
                    lawId: _dataList?.id,
                  )),
                ),
                SizedBox(height: 8),
                TextModule(
                    text:
                        '${_dataList?.address ?? '律所地址888号律所地址888号律所地址888号律所地址888号律所地址888号律所地址888号'}'),
                SizedBox(height: 16),
                lawFirmWidget(
                    title: '律所电话',
                    list: _dataList.mobile,
                    type: '电话',
                    routerPage: PhoneNumberPage(_dataList.mobile,
                        lawId: _dataList.id)), //律所电话
                SizedBox(height: 16),
                lawFirmWidget(
                    title: '律所微信',
                    list: _dataList.wechat,
                    type: '微信',
                    routerPage: LawFirmWeChatPage(_dataList.wechat,
                        lawId: _dataList.id)),
                SizedBox(height: 16),
                lawFirmWidget(
                    title: '律所邮箱',
                    list: _dataList.email,
                    type: '邮箱',
                    widgetWidth: (MediaQuery.of(context).size.width - 46) / 2,
                    routerPage: LawFirmEmailPage(_dataList.email,
                        lawId: _dataList.id)), //律所邮箱
                SizedBox(height: 16),
                webPublicWidget(), //网址、公众号
                SizedBox(height: 24),
                lawyerFirmPic(), //律所照片
                SizedBox(height: 24),
                socialHonor(), //社会荣誉
                SizedBox(height: 24),
                credentials(), //资质证明
                SizedBox(height: 24),
                officialLetter(), //律所公函
              ],
            )
          : null,
    );
  }

  Widget lawFirmWidget(
      {String title,
      List list,
      String type,
      double widgetWidth,
      Widget routerPage}) {
    double width = (MediaQuery.of(context).size.width - 60) / 3;
    return InkWell(
      onTap: () => routePush(routerPage),
      child: Column(
        children: <Widget>[
          IconTitleTileWidget(title: '$title'),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            child: list.length > 0
                ? Wrap(
                    spacing: 14,
                    runSpacing: 4,
                    children: list.map((index) {
                      return Container(
                        width: widgetWidth != null ? widgetWidth : width,
                        child: Text(
                          '${index?.title ?? '暂无数据'} ${index?.value ?? ''}',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  )
                : GreyText(text: '暂无数据'),
          )
        ],
      ),
    );
  }

  //律所网址、律所公众号
  Widget webPublicWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律所网址',
                onTapEditTwo: () => routePush(MyLawSettingOtherPage(
                  title: '律所网址',
                  hintText: listNoEmpty(_dataList?.website)
                      ? _dataList.website[0]?.value
                      : null,
                  lawId: _dataList?.id,
                  id: listNoEmpty(_dataList?.website)
                      ? _dataList.website[0]?.id
                      : null,
                )),
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(_dataList?.website) ? _dataList?.website[0]?.value : '暂无网址'}'),
            ],
          ),
        ),
        Space(),
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律所公众号',
                onTapEditTwo: () => routePush(MyLawSettingOtherPage(
                  title: '律所公众号',
                  hintText: _dataList.officialAccounts != null
                      ? _dataList.officialAccounts[0]?.value
                      : null,
                  lawId: _dataList?.id,
                  id: _dataList.officialAccounts != null
                      ? _dataList.officialAccounts[0]?.id
                      : null,
                )),
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(_dataList?.officialAccounts) ? _dataList?.officialAccounts[0]?.value : '暂无公众号'}'),
            ],
          ),
        ),
      ],
    );
  }

  //律所照片
  Widget lawyerFirmPic() {
    List _innerImages = new List();
    List _dataListInner = List.from(_dataList.photo ?? []);
    for (int i = 0; i < _dataListInner.length; i++) {
      var item = _dataListInner[i];
      ImageModel imageModel = new ImageModel();
      imageModel.img = item?.value ?? userDefaultAvatarOld;
      imageModel.title = item?.title ?? '未知标题';
      imageModel.id = item?.id ?? '0';
      imageModel.index = i;
      _innerImages.add(imageModel);
    }

    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '律所照片',
          editIconUrlOne: 'assets/images/commom/img_add.png',
          editIconUrlTwo: 'assets/images/commom/img_reduce.png',
          iconSizeOne: 23,
          iconSize: 23,
          onTapEditOne: () => routePush(LawFirmPicturePage(
            type: 6,
            id: _dataList?.id,
            title: '律所照片',
          )),
          onTapEditTwo: () {
            setState(() {
              selectDeletePic = !selectDeletePic;
            });
          },
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: listNoEmpty(_innerImages)
              ? Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: _innerImages.map((item) {
                    ImageModel model = item;
                    return Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 5, top: 5),
                          width: (MediaQuery.of(context).size.width - 47) / 2,
                          child: Column(
                            children: <Widget>[
                              new InkWell(
                                child: CachedNetworkImage(
                                  imageUrl: '${model.img}',
                                  fit: BoxFit.fill,
                                  width: 180,
                                  height: 180,
                                ),
                                onTap: () => routePush(
                                    new PhotoPage(_innerImages, model.index)),
                              ),
                              SizedBox(height: 4),
                              GreyText(
                                text: '${model.title}',
                              ),
                            ],
                          ),
                        ),
                        selectDeletePic
                            ? Positioned(
                                right: 0,
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/lawyer/delete.png',
                                    width: 12,
                                  ),
                                  onTap: () {
                                    delDialog(model.id);
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
                    );
                  }).toList(),
                )
              : new Text('暂无数据'),
        ),
      ],
    );
  }

  //社会荣誉
  Widget socialHonor() {
    List _innerImages = new List();
    List _dataListInner = List.from(_dataList.spocialhonor ?? []);
    for (int i = 0; i < _dataListInner.length; i++) {
      var item = _dataListInner[i];
      ImageModel imageModel = new ImageModel();
      imageModel.img = item?.value ?? userDefaultAvatarOld;
      imageModel.title = item?.title ?? '未知标题';
      imageModel.id = item?.id ?? '0';
      imageModel.index = i;
      _innerImages.add(imageModel);
    }

    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '社会荣誉',
          editIconUrlOne: 'assets/images/commom/img_add.png',
          editIconUrlTwo: 'assets/images/commom/img_reduce.png',
          iconSizeOne: 23,
          iconSize: 23,
          onTapEditOne: () => routePush(LawFirmPicturePage(
            type: 8,
            id: _dataList?.id,
            title: '社会荣誉',
          )),
          onTapEditTwo: () {
            setState(() {
              selectDeleteHonor = !selectDeleteHonor;
            });
          },
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            spacing: 14,
            runSpacing: 8,
            children: _innerImages.map((item) {
              ImageModel model = item;
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5, top: 5),
                    width: (MediaQuery.of(context).size.width - 47) / 2,
                    child: Column(
                      children: <Widget>[
                        new InkWell(
                          child: CachedNetworkImage(
                            imageUrl: '${model.img}',
                            fit: BoxFit.fill,
                            width: 180,
                            height: 180,
                          ),
                          onTap: () => routePush(
                              new PhotoPage(_innerImages, model.index)),
                        ),
                        SizedBox(height: 4),
                        GreyText(
                          text: '${model.title}',
                        ),
                      ],
                    ),
                  ),
                  selectDeleteHonor
                      ? Positioned(
                          right: 0,
                          child: InkWell(
                            child: Image.asset(
                              'assets/images/lawyer/delete.png',
                              width: 12,
                            ),
                            onTap: () {
                              delDialog(model.id);
                            },
                          ),
                        )
                      : SizedBox(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  //资质证明
  Widget credentials() {
    List _innerImages = new List();
    List _dataListInner = List.from(_dataList.qualification ?? []);
    for (int i = 0; i < _dataListInner.length; i++) {
      var item = _dataListInner[i];
      ImageModel imageModel = new ImageModel();
      imageModel.img = item?.value ?? userDefaultAvatarOld;
      imageModel.title = item?.title ?? '未知标题';
      imageModel.id = item?.id ?? '0';
      imageModel.index = i;
      _innerImages.add(imageModel);
    }

    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '资质证明',
          editIconUrlOne: 'assets/images/commom/img_add.png',
          editIconUrlTwo: 'assets/images/commom/img_reduce.png',
          iconSizeOne: 23,
          iconSize: 23,
          onTapEditOne: () => routePush(LawFirmPicturePage(
            type: 9,
            id: _dataList?.id,
            title: '资质证明',
          )),
          onTapEditTwo: () {
            setState(() {
              selectDeletecRedentials = !selectDeletecRedentials;
            });
          },
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            spacing: 14,
            runSpacing: 8,
            children: _innerImages.map((item) {
              ImageModel model = item;
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5, top: 5),
                    width: (MediaQuery.of(context).size.width - 47) / 2,
                    child: Column(
                      children: <Widget>[
                        new InkWell(
                          child: CachedNetworkImage(
                            imageUrl: '${model.img}',
                            fit: BoxFit.fill,
                            width: 180,
                            height: 180,
                          ),
                          onTap: () => routePush(
                              new PhotoPage(_innerImages, model.index)),
                        ),
                        SizedBox(height: 4),
                        GreyText(
                          text: '${model.title}',
                        ),
                      ],
                    ),
                  ),
                  selectDeletecRedentials
                      ? Positioned(
                          right: 0,
                          child: InkWell(
                            child: Image.asset(
                              'assets/images/lawyer/delete.png',
                              width: 12,
                            ),
                            onTap: () {
                              delDialog(model.id);
                            },
                          ),
                        )
                      : SizedBox(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  //律所公函
  Widget officialLetter() {
    return Column(
      children: <Widget>[
        IconTitleTileWidget(
          title: '律所公函',
          onTapEditTwo: () => routePush(LawFirmPicturePage(
            type: 10,
            id: _dataList.missive[0]?.id,
            title: '律所公函',
          )),
        ),
        Space(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 16, bottom: 12),
          child: new InkWell(
            child: Image.network(
                listNoEmpty(_dataList.missive)
                    ? _dataList.missive[0].value
                    : defCover,
                fit: BoxFit.cover),
            onTap: () => routePush(new ImagePhoto(
                new CachedNetworkImageProvider(_dataList.missive[0].value))),
          ),
        )
      ],
    );
  }

//  Widget officialLetter() {
//    return Column(
//      children: <Widget>[
//        IconTitleTileWidget(
//          title: '律所公函',
//          editIconUrlOne: 'assets/images/commom/img_add.png',
//          editIconUrlTwo: 'assets/images/commom/img_reduce.png',
//          onTapEditOne: () => routePush(LawFirmPicturePage(
//            type: 10,
//            id: _dataList?.id,
//            title: '律所公函',
//          )),
//          onTapEditTwo: () {
//            setState(() {
//              selectDeletecRedentials = !selectDeletecRedentials;
//            });
//          },
//        ),
//        SizedBox(height: 8),
//        Container(
//          width: MediaQuery.of(context).size.width,
//          child: Wrap(
//            spacing: 14,
//            runSpacing: 8,
//            children: _dataList.missive.map((index) {
//              return Stack(
//                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.only(right: 5, top: 5),
//                    width: (MediaQuery.of(context).size.width - 47) / 2,
//                    child: Column(
//                      children: <Widget>[
//                        Image.network(
//                          '${index.value}',
//                          fit: BoxFit.fill,
//                          width: 180,
//                        ),
//                        SizedBox(height: 4),
//                        GreyText(
//                          text: '${index.title}',
//                        ),
//                      ],
//                    ),
//                  ),
//                  selectDeletecRedentials
//                      ? Positioned(
//                          right: 0,
//                          child: InkWell(
//                            child: Image.asset(
//                              'assets/images/lawyer/delete.png',
//                              width: 12,
//                            ),
//                            onTap: () {
//                              delDialog(index.id);
//                            },
//                          ),
//                        )
//                      : SizedBox(),
//                ],
//              );
//            }).toList(),
//          ),
//        ),
//      ],
//    );
//  }
}
