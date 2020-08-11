import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/flutter/my_cupertino_dialog.dart';

Future confirmAlert<T>(
  BuildContext context,
  VoidCallbackConfirm callBack, {
  String tips,
  String okBtn,
  String cancelBtn,
  String name,
  bool input,
  int length, //输入类别名字长度
  double hintTextSize, //文字大小
  ValueChanged<String> onChanged,
  Function okFunction,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if (!strNoEmpty(okBtn)) okBtn = '确定';
      if (!strNoEmpty(cancelBtn)) cancelBtn = '取消';
      TextStyle _style(Color color) {
        return TextStyle(color: color, fontSize: 16.0);
      }

      void legalFielAdd() {
        systemViewModel.legalField(context, name: name).catchError((e) {
          showToast(context, e.message);
        });
      }

      return Material(
        type: MaterialType.transparency,
        child: MyCupertinoAlertDialog(
          content: new Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.symmetric(vertical: input ? 0 : 10),
                  child: Text(
                    '$tips',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                input ? SizedBox(height: 11.0) : new Container(),
                input
                    ? ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 35.0),
                        child: TextField(
                          maxLines: 1,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          autocorrect: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: ThemeColors.color999,
                            fontSize: hintTextSize,
                            textBaseline: TextBaseline.ideographic,
                          ),
                          onChanged: (v) {
                            name = v;
                          },
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(length),
                          ],
                          decoration: InputDecoration(
                            fillColor: Color(0xfff2f2f2),
                            filled: true,
                            hintText: '请输入新增类别名称',
                            hintStyle: TextStyle(
                              color: Color(0xff989898),
                              fontSize: hintTextSize,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              color: Color(0xffF0F0F0),
              padding: EdgeInsets.symmetric(vertical: 13.5),
              child: new Text('$cancelBtn', style: _style(Color(0xff333333))),
              onPressed: () {
                Navigator.pop(context);
                callBack(false);
              },
            ),
            new FlatButton(
              color: Color(0xffe1b96b),
              padding: EdgeInsets.symmetric(vertical: 13.5),
              child: new Text('$okBtn', style: _style(Colors.white)),
              onPressed: () {
                input ? legalFielAdd() : Navigator.pop(context);
                callBack(true);
                if (okFunction != null) okFunction();
              },
            ),
          ],
        ),
      );
    },
  );
}
