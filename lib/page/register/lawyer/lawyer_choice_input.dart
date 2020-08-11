import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：华佑
/// 开发者：华佑
/// 创建日期：2020-04-27
///
/// 律师 - 擅长领域选择

class LawyerChoiceInput extends StatefulWidget {
  final String leading;
  final String title;
  final bool details; //如果还需要添加详细地址？
  final int detailsTextLeading;
  final GestureTapCallback onTap;
  final TextEditingController controller;

  const LawyerChoiceInput({
    Key key,
    this.leading,
    this.title = '请选择擅长领域',
    this.details = false,
    this.detailsTextLeading = 50,
    this.onTap,
    this.controller,
  })  : assert(leading != null),
        assert(title != null),
        super(key: key);

  @override
  _LawyerChoiceInputState createState() => _LawyerChoiceInputState();
}

class _LawyerChoiceInputState extends State<LawyerChoiceInput> {
  TextStyle _style = TextStyle(color: ThemeColors.color999, fontSize: 14.0);

  @override
  Widget build(BuildContext context) {
    double _width =
        MediaQuery.of(context).size.width - (16 * 2 + 56 + 20 + 10 + 8);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 52.0,
        child: Row(
          children: <Widget>[
            Text(
              widget.leading,
              style: TextStyle(
                color: ThemeColors.color333,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: _width,
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _style,
                    ),
                  ),
                  widget.details
                      ? Container(
                          width: 170.0,
                          child: TextField(
                            controller: widget.controller,
                            maxLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.left,
                            obscureText: false,
                            style: TextStyle(
                              color: ThemeColors.color999,
                              fontSize: 14.0,
                            ),
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  widget.detailsTextLeading),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '请输入详细地址',
                              hintStyle: TextStyle(
                                  color: ThemeColors.color999, fontSize: 14.0),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (widget.onTap != null) widget.onTap();
              },
              child: Image.asset(
                'assets/register/icon_arrow_forward_left.png',
                width: 8.0,
                fit: BoxFit.cover,
              ),
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
      ),
    );
  }
}
