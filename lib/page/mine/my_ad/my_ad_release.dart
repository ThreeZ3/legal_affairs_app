import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_ad/my_ad_select_type_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/list_tile_card_widget.dart';

///广告发布

class MyAdRelease extends StatefulWidget {
  @override
  _MyAdReleaseState createState() => _MyAdReleaseState();
}

class _MyAdReleaseState extends State<MyAdRelease> {
  TextEditingController valueC = new TextEditingController();
  TextEditingController valueD = new TextEditingController();

  int _day;

  int allPrice; //预计费用

  //接收返回的数据
  AdSysAllModel model;

  String _getImage;

  ///发布
  void postAdSysBidding() {
    adViewModel
        .adSysBidding(
      context,
      bidPrice: valueC.text,
      contentUrl: _getImage,
      day: _day,
      id: JHData.id(),
      sysAdId: model.id,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  testFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    systemViewModel.uploadFile(context, file: image).then((rep) {
      setState(() {
        _getImage = rep.data['data'];
      });
      print('广告图片上传成功,最终地址为：：${rep.data['data']}');
      setState(() {});
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.colorBackground,
      appBar: NavigationBar(
        title: '广告发布',
        rightDMActions: <Widget>[
          InkWell(
            onTap: () => postAdSysBidding(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              /* child: Image.asset(
                'assets/images/mine/share_icon@3x.png',
                width: 22.0,
              ),*/
              child: Center(
                child: Text(
                  '发布',
                  style:
                      TextStyle(color: ThemeColors.colorOrange, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: MainInputBody(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () => testFile(),
              child: Container(
                height: 146.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: _getImage != null
                    ? CachedNetworkImage(
                        imageUrl: _getImage,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Image.asset(
                          'assets/images/mine/icon_add.png',
                          width: 48,
                        ),
                      ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Column(
                children: <Widget>[
                  ListTileCardWidget(
                    controller: valueC,
                    leading: '推送费用',
                    input: true,
                    time: false,
                    money: true,
                    formats: priceFormatter,
                    onChanged: (v) {
                      setState(() {
                        if (double.parse(v) < double.parse(model.minPrice)) {
                          showToast(context, '不能低于广告位的最低价格');
                          valueC.text = model.minPrice;
                        } else if (!strNoEmpty(v)) {
                          valueC.text = v;
                        }
                      });
                    },
                  ),
                  SizedBox(height: 22.0),
                  ListTileCardWidget(
                    controller: valueD,
                    length: 3,
                    leading: '推送时间',
                    input: true,
                    formats: numFormatter,
                    onChanged: (v) {
                      setState(() {
                        if (int.parse(v) < 1) {
                          showToast(context, '推送天数不得小于1天');
                          valueD.text = 1.toString();
                        }
                        _day = int.parse(v);
                        allPrice = _day * int.parse(valueC.text);
                      });
                    },
                  ),
                  SizedBox(height: 22.0),
                  ListTileCardWidget(
                    leading: '发送时间',
                    trailing: model != null
                        ? DateTimeForMater.formatTimeStampToString(
                            stringDisposeWithDouble(model.startTime / 1000))
                        : '请先选择推送位置',
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
              child: Column(
                children: <Widget>[
                  ListTileCardWidget(
                    leading: '推送位置',
                    trailing: model?.name ?? '选择位置',
                    onTap: () {
                      routePush(MyAdSelectTypePage()).then((v) {
                        setState(() {
                          model = v;
                        });
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  ListTileCardWidget(
                    leading: '预计费用',
                    trailing:
                        allPrice != null ? allPrice.toString() : '请先选择推送位置',
                    icon: true,
                    iconHead: true,
                    iconText: '系统根据竞价高低，竞价先后，推送时间长短来确定最终竞价是否成功',
                  ),
                  SizedBox(height: 8.0),
                  ListTileCardWidget(
                    leading: '当前最低',
                    trailing: model != null ? model.minPrice : '请先选择推送位置',
                    style: true,
                  ),
                  SizedBox(height: 8.0),
                  ListTileCardWidget(
                    leading: '当前最高',
                    trailing: model != null ? model.maxPrice : '请先选择推送位置',
                    style: true,
                  ),
                  SizedBox(height: 8.0),
                  ListTileCardWidget(
                    leading: '竞价人数',
                    trailing: model != null ? model.num : '请先选择推送位置',
                    style: true,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    valueC.dispose();
    valueD.dispose();
  }
}
