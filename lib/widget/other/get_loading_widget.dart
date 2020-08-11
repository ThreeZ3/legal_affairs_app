import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/update_dialog.dart';

class GetLoadingWidget extends StatelessWidget {
  final int downloadProgress;
  final UploadingFlag uploadingFlag;

  GetLoadingWidget({
    @required this.downloadProgress,
    @required this.uploadingFlag,
  });

  @override
  Widget build(BuildContext context) {
    if (downloadProgress != 0 && uploadingFlag == UploadingFlag.uploading) {
      return Container(
        height: 30,
        width: winWidth(context),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: new Row(
          children: <Widget>[
            new Text('压缩中:'),
            new Space(),
            new Expanded(
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
                backgroundColor: Colors.grey[300],
                value: downloadProgress / 100,
              ),
            )
          ],
        ),
      );
    }
    if (uploadingFlag == UploadingFlag.uploading && downloadProgress == 0) {
      return Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
            SizedBox(
              width: 5,
            ),
            Material(
              child: Text(
                '等待',
                style: TextStyle(color: themeColor),
              ),
              color: Colors.transparent,
            )
          ],
        ),
      );
    }
    if (uploadingFlag == UploadingFlag.uploadingFailed) {
      return Container(
          alignment: Alignment.center,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.clear,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 5,
              ),
              Material(
                child: Text(
                  '下载超时',
                  style: TextStyle(color: themeColor),
                ),
                color: Colors.transparent,
              )
            ],
          ));
    }
    return Container();
  }
}
