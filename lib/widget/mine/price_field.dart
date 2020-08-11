import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final ValueChanged<String> onChanged;

  PriceField({
    this.controller,
    this.hintText,
    this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(fontSize: 14, color: ThemeColors.color333),
        ),
        new Expanded(
          child: Container(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              textAlign: TextAlign.end,
              inputFormatters: priceFormatter,
              onChanged: onChanged,
              style: TextStyle(
                color: Color(0xffFF3333),
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff999999),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: ThemeColors.color333.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
