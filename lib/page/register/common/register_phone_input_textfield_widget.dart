import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class RegisterPhoneInputTextFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RegisterPhoneInputTextFieldWidget({
    Key key,
    this.title,
    this.hintText,
    this.controller,
    this.onChanged,
  })  : assert(title != null),
        assert(hintText != null),
        super(key: key);

  @override
  _RegisterPhoneInputTextFieldWidgetState createState() =>
      _RegisterPhoneInputTextFieldWidgetState();
}

class _RegisterPhoneInputTextFieldWidgetState
    extends State<RegisterPhoneInputTextFieldWidget> {
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
          TextField(
            controller: widget.controller,
            maxLines: 1,
            autofocus: false,
            textAlign: TextAlign.left,
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(11),
              WhitelistingTextInputFormatter(RegExp("[0-9]")),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: ThemeColors.color999, fontSize: 14.0),
            ),
            onChanged: widget.onChanged,
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
