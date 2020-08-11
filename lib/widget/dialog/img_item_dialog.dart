import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:jh_legal_affairs/util/tools.dart';

void saveImg(context, imgUrl) {
  GallerySaver.saveImage(imgUrl).then((bool success) {
    if (success) {
      showToast(context, "图片保存成功");
    } else {
      showToast(context, "图片保存失败");
    }
  });
}

imgItemDialog(context, imgUrl) {
  action(v) {
    Navigator.of(context).pop();
    if (v == '保存图片') {
      saveImg(context, imgUrl);
    } else {
      showToast(context, "敬请期待");
    }
  }

  Widget item(item) {
    return new Container(
      width: winWidth(context),
      decoration: BoxDecoration(
        border: item != '编辑'
            ? Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              )
            : null,
      ),
      child: new FlatButton(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        onPressed: () => action(item),
        child: new Text(item),
      ),
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      List data = [
        '保存图片',
      ];

      return new Center(
        child: new Material(
          type: MaterialType.transparency,
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new InkWell(
                  child: new Container(),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              new ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: new Container(
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Column(children: data.map(item).toList()),
                      new HorizontalLine(
                          color: Color.fromRGBO(237, 237, 237, 1),
                          height: 10.0),
                      new FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pop(),
                        child: new Container(
                          width: winWidth(context),
                          alignment: Alignment.center,
                          child: new Text('取消'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
