import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart' hide showToast;
import 'package:oktoast/oktoast.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-04
///
/// 自定义对话框
class CustomDialog extends StatefulWidget {
  final double height; //对话框高度
  final String title; //标题
  final String hintText; //提示文字
  final VoidCallback cancelBtnOnpressed;
  final VoidCallback okBtnOnpressed;
  CustomDialog({
    this.height: 148,
    this.title,
    this.hintText,
    this.okBtnOnpressed,
    this.cancelBtnOnpressed,
  });
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          constraints: BoxConstraints(),
          margin: EdgeInsets.symmetric(horizontal: 52),
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 18),
              Text(
                widget.title, //添加类别
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(3),
                ),
                margin: EdgeInsets.only(left: 61, right: 60),
                child: TextField(
                  keyboardType: TextInputType.text,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  controller: textController,
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText, //请输入新增类别名称
                    hintStyle: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffC0984E),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (textController.text.toString().isNotEmpty) {
                            Navigator.pop(
                                context, [textController.text.toString()]);

                            print(textController.text.toString());
                          } else if (textController.text.toString().isEmpty) {
                            showToast('类别不能为空',
                                textPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                position: ToastPosition.center);
                          }
                        },
                        child: Text(
                          '提交',
                          style: TextStyle(
                            color: Color(0xfffafafa),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//白底对话框
//弹出框样式
class CustomWhiteDialog extends StatefulWidget {
  final double height; //对话框高度
  final String title; //标题
  final String hintText; //提示文字
  final VoidCallback cancelBtnOnpressed;
  final VoidCallback okBtnOnpressed;
  final TextEditingController textController;

  CustomWhiteDialog({
    this.height: 166,
    this.title,
    this.hintText,
    this.okBtnOnpressed,
    this.cancelBtnOnpressed,
    this.textController,
  });
  @override
  _CustomWhiteDialogState createState() => _CustomWhiteDialogState();
}

class _CustomWhiteDialogState extends State<CustomWhiteDialog> {
  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            constraints: BoxConstraints(),
            margin: EdgeInsets.symmetric(horizontal: 55),
            width: MediaQuery.of(context).size.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  widget.title, //添加类别
                  style: TextStyle(
                    color: Color(0xff595959),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [LengthLimitingTextInputFormatter(5)],
                    controller: widget.textController,
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffD9D9D9),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffD9D9D9),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: widget.hintText, //请输入新增类别名称
                      hintStyle: TextStyle(
                        color: Color(0xffBFBFBF),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Color(0xff8C8C8C),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (widget.textController.text.toString().isNotEmpty) {
                              Navigator.pop(
                                  context, [widget.textController.text.toString()]);

                              print(widget.textController.text.toString());
                            } else if (widget.textController.text.toString().isEmpty) {
                              showToast('学历类型不能为空',
                                  textPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  position: ToastPosition.center);
                            }
                          },
                          child: Text(
                            '确定',
                            style: TextStyle(
                              color: Color(0xffE1B96B),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
