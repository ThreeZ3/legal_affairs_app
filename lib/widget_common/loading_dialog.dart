import 'package:flutter/material.dart';

// 加载中loading提示
//Navigator.push(
//  context,
//  DialogRouter(LoadingDialog(
//  onTapToHideLoading: true,
//  tip: "注册中",
//)));

//隐藏 调用 Navigator.pop(context); 即可

class LoadingDialog extends Dialog {
  final bool onTapToHideLoading; // 点击背景可隐藏
  final String tip; // 提示内容
  LoadingDialog({this.onTapToHideLoading = false, this.tip = "加载中"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(

          ///背景透明
          color: Colors.transparent,

          ///保证控件居中效果
          child: Stack(
            children: <Widget>[
              GestureDetector(
                ///点击事件
                onTap: () {
                  if (onTapToHideLoading) {
                    Navigator.pop(context);
                  }
                },
              ),
              new Center(
                ///弹框大小
                child: new SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: new Container(
                    ///弹框背景和圆角
                    decoration: ShapeDecoration(
                      color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new CircularProgressIndicator(),
                        new Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: new Text(
                            tip,
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DialogRouter extends PageRouteBuilder {
  final Widget page;

  DialogRouter(this.page)
      : super(
          opaque: false,
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}
