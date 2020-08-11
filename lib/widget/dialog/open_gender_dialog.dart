
//打开性别底部弹出框
import 'package:flutter/material.dart';

Future openGenderDialog(context) async {
  var result = await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: 112,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          children: ['男', '女'].map((item) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, item == '男' ? '0' : '1');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
  );
  return result;
}