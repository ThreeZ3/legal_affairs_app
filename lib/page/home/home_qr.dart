import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/img_item_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui';

///首页二维码 二维码-邀请码
///

class HomeQrPage extends StatefulWidget {
  @override
  _HomeQrPageState createState() => _HomeQrPageState();
}

class _HomeQrPageState extends State<HomeQrPage> {
  GlobalKey _key = new GlobalKey();

  bool onTap = false;

  void _checkPersmission([bool isTips = true]) async {
    await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  }

  @override
  void initState() {
    super.initState();
    _checkPersmission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        title: '二维码',
        rightDMActions: <Widget>[
          new SizedBox(
            width: 60,
            child: new FlatButton(
              onPressed: () => saveHandle(),
              child: new Icon(Icons.more_horiz, color: themeColor),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new RepaintBoundary(
                key: _key,
                child: QrImage(
                  data: JHData.inviteCode() ?? "No",
                  version: QrVersions.auto,
                  size: 201,
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  setState(() {
                    onTap = !onTap;
                  });
                },
                child: new Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "我的邀请码",
                    style: TextStyle(
                        color:
                            onTap ? Color(0xffFF999999) : Color(0xffFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Offstage(
                offstage: !onTap,
                child: Column(
                  children: <Widget>[
                    Text(
                      JHData.inviteCode(),
                      style: TextStyle(
                          color: Color(0xffFFE1B96B),
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: JHData.inviteCode()));
                        showToast(context, "复制成功");
                      },
                      child: Text(
                        "复制",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveHandle() async {
    try {
      RenderRepaintBoundary boundary = _key.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData _data = await image.toByteData(format: ImageByteFormat.png);
      Uint8List imageBytes = _data.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final newFile = await new File('${tempDir.path}/image.jpg').create();
      newFile.writeAsBytesSync(imageBytes);

      imgItemDialog(context, newFile.path);
    } catch (e) {
      showToast(context, '保存失败');
    }
  }
}
