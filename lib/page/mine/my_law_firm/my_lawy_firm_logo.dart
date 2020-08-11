import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/complaint_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details/lawyer_accusation_page.dart';
import 'package:jh_legal_affairs/page/other/photo_show_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';

///我的律所logo
class MyLawFirmLogo extends StatefulWidget {
  final String id;

  final MyFirmModel data;

  const MyLawFirmLogo({Key key, this.id, this.data}) : super(key: key);

  MyLawFirmLogoState createState() => MyLawFirmLogoState();
}

class MyLawFirmLogoState extends State<MyLawFirmLogo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HorizontalLinee(), //间隔条
        Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              lawFirmLogo(widget.data),
              ranking(context, widget.data),
            ],
          ),
        ),
//        buttons(context, widget.data),
      ],
    );
  }

  ///背景图
  Widget lawFirmLogo(data) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: new InkWell(
        child: strNoEmpty(data?.firmAvatar)
            ? CachedNetworkImage(
                imageUrl: data?.firmAvatar,
                fit: BoxFit.cover,
                height: 148,
              )
            : Image.asset(
                avatarLawFirm,
                fit: BoxFit.cover,
                height: 148,
              ),
        onTap: () => _openHeaderDialog(context),
      ),
    );
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
      handle(rep.data['data']);
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  handle(String avatarUrl) {
    myLawFirmViewModel
        .firmAvatars(
      context,
      avatarUrl: avatarUrl,
    )
        .then((v) {
      setState(() {
        widget.data?.firmAvatar = avatarUrl;
      });
    }).catchError((e) {
      print('e====>${e.toString()}');
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

  //打开头像底部弹出框
  _openHeaderDialog(context) async {
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

  ///排名
  Widget ranking(context, data) {
    return Container(
      padding: EdgeInsets.only(right: 16, top: 16),
      alignment: Alignment.topRight,
      width: MediaQuery.of(context).size.width,
      child: IconBox(text: '排名', number: '${data?.rank ?? '未知排名'}'),
    );
  }

  ///举报与投诉
  Widget buttons(context, data) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => routePush(new ComplaintPage(id: widget.id, type: 2)),
            child: Container(
                height: 70,
                width: winWidth(context) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Space(height: 12),
                    Image.asset(
                      "assets/images/lawyer/tell.png",
                      height: 22,
                    ),
                    Space(height: 4),
                    Text(
                      '投诉(${data?.complaintCount ?? '0'})',
                      style: TextStyle(color: THEME_COLOR),
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () => routePush(new AccusationPage(id: widget.id, type: 2)),
            child: Container(
              height: 70,
              width: winWidth(context) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Space(height: 12),
                  Image.asset(
                    "assets/images/lawyer/report.png",
                    height: 22,
                  ),
                  Space(height: 4),
                  Text(
                    '举报(${data?.accusationCount ?? '0'})',
                    style: TextStyle(color: THEME_COLOR),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
