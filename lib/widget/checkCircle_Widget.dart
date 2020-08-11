//圆形选择按钮

import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

//Widget checkCircle({bool value, Function onTap}) {
//  return Container(
//    margin: EdgeInsets.only(left: winWidth(context) * 0.0426),
//    child: Center(
//      child: InkWell(
//        onTap: onTap,
//        child: Padding(
//          padding: EdgeInsets.all(0),
//          child: value
//              ? Icon(
//                  Icons.check_circle,
//                  size: 22.0,
//                  color: ThemeColors.colorOrange,
//                )
//              : Icon(
//                  Icons.check_circle_outline,
//                  size: 22.0,
//                  color: ThemeColors.colorOrange,
//                ),
//        ),
//      ),
//    ),
//  );
//}

class CheckCircle extends StatelessWidget {
  final bool value;
  final Function onTap;

  const CheckCircle({Key key, this.value, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: winWidth(context) * 0.0426),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: value
                ? Icon(
                    Icons.check_circle,
                    size: 22.0,
                    color: ThemeColors.colorOrange,
                  )
                : Icon(
                    Icons.check_circle_outline,
                    size: 22.0,
                    color: ThemeColors.colorOrange,
                  ),
          ),
        ),
      ),
    );
  }
}
