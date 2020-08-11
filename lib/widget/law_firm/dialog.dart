import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 自定义对话框 - 适用于新增类型
///
class CustomDialog extends Dialog {
  TextEditingController textController = TextEditingController();
  final double width; // 宽度
  final double height; // 高度
  final String title; // 顶部标题
  String content; // 内容
  final String cancelTxt; // 取消按钮的文本
  final String enterTxt; // 确认按钮的文本
  final String hintText;
  final Function callback; // 修改之后的回掉函数

  CustomDialog(
      {this.width: 271,
      this.height: 148,
      this.title,
      this.hintText,
      this.content, // 根据content来，判断显示哪种类型
      this.cancelTxt: "取消",
      this.enterTxt: "提交",
      this.callback});

  @override
  Widget build(BuildContext context) {
    return CustomDialogView(
      width: width,
      height: height,
      title: title,
      hintText: hintText,
      content: content,
      cancelTxt: cancelTxt,
      callback: callback,
    );
  }
}

class CustomDialogView extends StatefulWidget {
  final TextEditingController textController = TextEditingController();
  final double width; // 宽度
  final double height; // 高度
  final String title; // 顶部标题
  final String content; // 内容
  final String cancelTxt; // 取消按钮的文本
  final String enterTxt; // 确认按钮的文本
  final String hintText;
  final Function callback; // 修改之后的回掉函数

  CustomDialogView(
      {this.width: 271,
      this.height: 148,
      this.title,
      this.hintText,
      this.content, // 根据content来，判断显示哪种类型
      this.cancelTxt: "取消",
      this.enterTxt: "提交",
      this.callback});

  @override
  _CustomDialogViewState createState() => _CustomDialogViewState();
}

class _CustomDialogViewState extends State<CustomDialogView> {
  String _inputVal = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // 点击遮罩层隐藏弹框
        child: Material(
            type: MaterialType.transparency, // 配置透明度
            child: Center(
                child: GestureDetector(
                    // 点击遮罩层关闭弹框，并且点击非遮罩区域禁止关闭
                    onTap: () {
                      print('我是非遮罩区域～');
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 104,
                        margin: EdgeInsets.symmetric(horizontal: 52),
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: <
                                Widget>[
                          Visibility(
                              visible: widget.content == null ? true : false,
                              child: Positioned(
                                  top: 0,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 18),
                                      child: Text("${widget.title}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff333333),
                                              fontWeight: FontWeight.bold))))),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.fromLTRB(61, 10, 60, 25),
                              alignment: Alignment.center,
                              child: widget.content != null
                                  ? Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 42),
                                      alignment: Alignment.center,
                                      child: Text("${widget.content}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)))
                                  : Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: TextField(
                                        controller: widget.textController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(fontSize: 12),
                                        textInputAction: TextInputAction.send,
                                        cursorColor: Colors.black,
                                        cursorWidth: 1,
                                        decoration: new InputDecoration(
                                          alignLabelWithHint: true,
                                          hintText: '${widget.hintText}',
                                          hintStyle: TextStyle(
                                            color: Color(0xff999999),
                                            fontSize: 12,
                                          ),
                                          fillColor: Color(0xffF2F2F2),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 3.0,
                                                  horizontal: 5.0),
                                          enabledBorder: OutlineInputBorder(
                                              // 边框默认色
                                              borderSide: const BorderSide(
                                                  color: Color(0xffF2F2F2))),
                                          focusedBorder: OutlineInputBorder(
                                              // 聚焦之后的边框色
                                              borderSide: const BorderSide(
                                                  color: Color(0xffF2F2F2))),
                                        ),
                                      ),
                                    )),
                          Container(
                              height: 45,
                              child: Row(children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5)),
                                            ),
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text("${widget.cancelTxt}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: 14,
                                                ))),
                                        onTap: () {
                                          Navigator.pop(context);
                                        })),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffC0984E),
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5)),
                                            ),
                                            height: double.infinity,
                                            // 继承父级的高度
                                            alignment: Alignment.center,
                                            child: Text("${widget.enterTxt}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xffFAFAFA),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ))),
                                        onTap: () {
                                          if (widget.content != null) {
                                            widget.callback(
                                                _inputVal); // 通过回掉函数传给父级
                                          }
                                          if (!strNoEmpty(
                                              widget.textController.text)) {
                                            showToast(context, '请输入内容');
                                            return;
                                          }
                                          addWord();
                                        }))
                              ]))
                        ]))))),
        onTap: () {
          // Navigator.pop(context);
        });
  }

  void addWord() {
    systemViewModel
        .legalField(context, name: widget.textController.text)
        .then((rep) {
      showToast(context, '添加成功，等待审核');
    }).catchError((e) {
      showToast(context, e.message);
    });
  }
}
