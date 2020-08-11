import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

//支付方式
void payTypeDialog(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return PayTypeDialog();
    },
  );
}

class PayTypeDialog extends StatefulWidget {
  @override
  _PayTypeDialogState createState() => _PayTypeDialogState();
}

class _PayTypeDialogState extends State<PayTypeDialog> {
  List _paytype = [
    '微信支付',
    '支付宝支付',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    '取消',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.color333,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  '付款方式',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.color333,
                    fontSize: 16,
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    '确定',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.color333,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 46.0,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (i) {
                print('change:$i');
              },
              children: _paytype.map((item) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$item',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.color333,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
