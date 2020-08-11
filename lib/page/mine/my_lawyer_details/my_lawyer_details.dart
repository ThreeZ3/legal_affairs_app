import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_email.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_phone.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_wechat.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';
import 'package:jh_legal_affairs/widget/mine/icon_title_tile_widget.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_setting_other_page.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/details/law_firm_picture_page.dart';
import 'package:jh_legal_affairs/widget_common/view/image_photo.dart';

class MyLawyerDetailList extends StatefulWidget {
  final String id;

  const MyLawyerDetailList(this.id);

  @override
  _MyLawyerDetailListState createState() => _MyLawyerDetailListState();
}

class _MyLawyerDetailListState extends State<MyLawyerDetailList> {
  bool selectDeletePic = false;
  bool selectDeleteHonor = false;
  bool selectDeletecRedentials = false;
  ViewLawyerDetailModel _dataList = new ViewLawyerDetailModel();
  Map detailsInfo = {};
  bool isSelect = false;

  @override
  void initState() {
    super.initState();
    getDetailsInfo();
    Notice.addListener(
        JHActions.myFirmDetailRefresh(), (v) => getDetailsInfo());
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myFirmDetailRefresh());
  }

  getDetailsInfo() {
    lawyerViewModel
        .lawyerDetailsInfo(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        _dataList = rep.data;
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  /// 删除律师照片弹窗
  delPhotoDialog(id) {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定删除该照片？',
      okFunction: () {
        lawyerInFoViewModel.updateLawyerPhoto(context, id: id);
      },
      cancelFunction: () {},
    );
  }

  /// 删除律师社会荣誉弹框
  delHonorDialog(id) {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定删除该照片？',
      okFunction: () {
        lawyerInFoViewModel.lawyerHonorDelete(context, id: id);
      },
      cancelFunction: () {},
    );
  }

  /// 删除律师资质证明弹框
  delCertification(id) {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定删除该照片？',
      okFunction: () {
        lawyerInFoViewModel.certificationDelete(context, id: id);
      },
      cancelFunction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(title: '详细资料'),
      body: _dataList.id != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: <Widget>[
                lawFirmWidget(
                  title: '律师电话',
                  list: _dataList.mobile,
                  type: '电话',
                  routerPage: LawyerPhone(_dataList.mobile),
                ),
                /* SizedBox(height: 16),
                lawFirmWidget(
                  title: '测试',
                  list: _dataList.mobile,
                  type: '电话',
                  routerPage: TestPage(),
                ),*/
                SizedBox(height: 16),
                lawFirmWidget(
                  title: '律师微信',
                  list: _dataList.wechat,
                  type: '微信',
                  routerPage: LawyerWeChat(_dataList.wechat),
                ),
                SizedBox(height: 16),
                lawFirmWidget(
                  title: '律师邮箱',
                  list: _dataList.email,
                  type: '邮箱',
                  widgetWidth: (MediaQuery.of(context).size.width - 46) / 2,
                  routerPage: LawyerEmail(_dataList.email),
                ),
                SizedBox(height: 16),
                webPublicWidget(), //微博
                SizedBox(height: 16),
                officialWidget(), //公众号
                SizedBox(height: 24),
                lawyerFirmPic(), //律师照片
                SizedBox(height: 24),
                socialHonor(), //社会荣誉
                SizedBox(height: 24),
                credentials(), //资质证明
                SizedBox(height: 12),
              ],
            )
          : Container(),
    );
  }

  //律师电话、微信、邮箱
  Widget lawFirmWidget({
    String title,
    List list,
    String type,
    double widgetWidth,
    Widget routerPage,
  }) {
    double width = (MediaQuery.of(context).size.width - 60) / 3;
    return InkWell(
      onTap: () => routePush(routerPage),
      child: Column(
        children: <Widget>[
          IconTitleTileWidget(title: '$title'),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            child: Wrap(
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
            ),
          )
        ],
      ),
    );
  }

  //律师微博
  Widget webPublicWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律师微博',
                onTapEditTwo: () => routePush(MyLawSettingOtherPage(
                  title: '律师微博',
                  hintText: listNoEmpty(_dataList.weibo)
                      ? _dataList?.weibo[0]?.value
                      : null,
                  id: listNoEmpty(_dataList.weibo)
                      ? _dataList.weibo[0]?.id
                      : null,
                )),
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(_dataList.weibo) ? _dataList.weibo[0]?.value : '暂无微博'}'),
            ],
          ),
        ),
      ],
    );
  }

  //律师公众号
  Widget officialWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              IconTitleTileWidget(
                title: '律师公众号',
                onTapEditTwo: () => routePush(MyLawSettingOtherPage(
                  title: '律师公众号',
                  hintText: listNoEmpty(_dataList.officialAccounts)
                      ? _dataList.officialAccounts[0]?.value
                      : null,
                  id: listNoEmpty(_dataList.officialAccounts)
                      ? _dataList.officialAccounts[0]?.id
                      : null,
                )),
              ),
              SizedBox(height: 8),
              GreyText(
                  text:
                      '${listNoEmpty(_dataList.officialAccounts) ? _dataList?.officialAccounts[0]?.value : '暂无公众号'}'),
            ],
          ),
        ),
      ],
    );
  }

  //律师照片
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
          title: '律师照片',
          editIconUrlOne: 'assets/images/commom/img_add.png',
          editIconUrlTwo: 'assets/images/commom/img_reduce.png',
          iconSizeOne: 23,
          iconSize: 23,
          onTapEditOne: () => routePush(LawFirmPicturePage(
            type: 6,
            id: _dataList?.id,
            title: '律师照片',
            from: '律师',
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
                                    delPhotoDialog(model.id);
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
            from: '律师',
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
                              delHonorDialog(model.id);
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
            from: '律师',
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
                              delCertification(model.id);
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
}
