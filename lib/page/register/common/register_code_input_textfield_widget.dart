import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class RegisterCodeInputTextFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final int length; //长度限制
  final bool suffixDisplay; //判断右侧图标是否显示
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RegisterCodeInputTextFieldWidget({
    Key key,
    this.title,
    this.hintText,
    this.length = 11,
    this.suffixDisplay = false,
    this.controller,
    this.onChanged,
  })  : assert(title != null),
        assert(hintText != null),
        assert(length != null),
        super(key: key);

  @override
  _RegisterCodeInputTextFieldWidgetState createState() =>
      _RegisterCodeInputTextFieldWidgetState();
}

class _RegisterCodeInputTextFieldWidgetState
    extends State<RegisterCodeInputTextFieldWidget> {
  //右侧图标是否显示
  bool _display = false;

  //密码显示判断
  bool _obscureText = true;

  void _judge() {
    setState(() {
      if (_display) {
        _display = false;
        _obscureText = true;
      } else {
        _display = true;
        _obscureText = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: ThemeColors.color999,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  maxLines: 1,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  autocorrect: false,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(widget.length),
                    BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")),
                  ],

                  /*<TextInputFormatter>[
                          LengthLimitingTextInputFormatter(widget.length),
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        ],*/
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(color: ThemeColors.color999, fontSize: 14.0),
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              widget.suffixDisplay
                  ? GestureDetector(
                      onTap: () => _judge(),
                      child: _display
                          ? Image.asset(
                              'assets/register/register_displayTrue.png',
                              width: 15.0,
                              height: 10.0,
                            )
                          : Image.asset(
                              'assets/register/register_displayFalse.png',
                              width: 15.0,
                              height: 10.0,
                            ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
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
