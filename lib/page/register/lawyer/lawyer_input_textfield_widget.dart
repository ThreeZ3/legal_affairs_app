import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-21
///
/// 律师信息 - 输入框

class LawyerInputTextFieldWidget extends StatefulWidget {
  final String head;
  final String title;
  final double height;
  final int length;
  final bool email;
  final bool phone;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const LawyerInputTextFieldWidget({
    Key key,
    this.head,
    this.title,
    this.height = 52.0,
    this.length = 20,
    this.email = false,
    this.phone = false,
    this.onChanged,
    this.controller,
  })  : assert(title != null),
        assert(length != null),
        super(key: key);

  @override
  _LawyerInputTextFieldWidgetState createState() =>
      _LawyerInputTextFieldWidgetState();
}

class _LawyerInputTextFieldWidgetState
    extends State<LawyerInputTextFieldWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: TextField(
        controller: _controller,
        maxLines: 1,
        autofocus: false,
        textAlign: TextAlign.left,
        obscureText: false,
        style: TextStyle(fontSize: 14.0),
        onChanged: widget.onChanged,
        keyboardType: widget.email
            ? TextInputType.emailAddress
            : widget.phone ? TextInputType.phone : TextInputType.text,
        inputFormatters: widget.email
            ? <TextInputFormatter>[
                LengthLimitingTextInputFormatter(widget.length),
//                BlacklistingTextInputFormatter(
//                    RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")),
              ]
            : <TextInputFormatter>[
                LengthLimitingTextInputFormatter(widget.length),
              ],
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Container(
            padding: EdgeInsets.only(right: 16.0, top: 12.0),
            child: Text(
              widget.head,
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          hintText: widget.title,
          hintStyle: TextStyle(color: Color(0xff999999), fontSize: 14.0),
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromRGBO(17, 21, 43, 0.08),
          ),
        ),
      ),
    );
  }
}
