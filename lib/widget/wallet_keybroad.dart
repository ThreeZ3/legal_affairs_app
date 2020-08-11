import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-25
///
/// 钱包 充值-自定义键盘

class NumberKeyboardActionSheet extends StatefulWidget {
  final Function onTap;
  final String label;
  TextEditingController controller;

  NumberKeyboardActionSheet({
    Key key,
    @required this.controller,
    this.label = '充值',
    this.onTap,
  }) : super(key: key);

  @override
  State createState() => new _NumberKeyboardActionSheetState();
}

class _NumberKeyboardActionSheetState extends State<NumberKeyboardActionSheet> {
  ///键盘上的键值名称
  ///第一行
  static const List<String> _keyNamesOne = [
    '1',
    '2',
    '3',
    '<-',
  ];
  static const List<String> _keyNamesTwo = [
    '4',
    '5',
    '6',
  ];
  static const List<String> _keyNamesThree = [
    '7',
    '8',
    '9',
  ];

  ///控件点击事件
  void _onViewClick(String keyName) {
    var currentText = widget.controller.text; //当前的文本
    if (RegExp('^\\d+\\.\\d{2}\$').hasMatch(currentText) && keyName != '<-') {
      showToast(context, '只能输入两位小数');
      return;
    }
    if ((currentText == '' && (keyName == '.' || keyName == '<-')) ||
        (RegExp('\\.').hasMatch(currentText) && keyName == '.'))
      return; //{不能第一个就输入.或者<-},{不能在已经输入了.再输入}
    if (keyName == '<-') {
      //{回车键}
      if (currentText.length == 0) return;
      widget.controller.text = currentText.substring(0, currentText.length - 1);
      return;
    }
    if (currentText == '0' && (RegExp('^[1-9]\$').hasMatch(keyName))) {
      //{如果第一位是数字0，那么第二次输入的是1-9，那么就替换}
      widget.controller.text = keyName;
      return;
    }
    widget.controller.text = currentText + keyName;
  }

  ///构建显示数字键盘的视图
  Widget _showKeyboardGridView() {
    return Material(
      color: Color(0xff5a5a5a),
      child: Column(
        children: <Widget>[
          //第一行
          Row(
            children: List.generate(_keyNamesOne.length, (item) {
              return CustomContainerr(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 5,
                ),
                width: (MediaQuery.of(context).size.width - 50) / 4,
                child: item == 3
                    ? Icon(
                        Icons.backspace,
                        color: Color(0xfff0f0f0),
                        size: 18,
                      )
                    : CustomText(text: _keyNamesOne[item]),
                onTap: () => _onViewClick(_keyNamesOne[item]),
              );
            }),
          ),
          //第二、三、四行
          Row(
            children: <Widget>[
              _leftBox(), //左侧盒子
              _rightBox(), //右侧盒子
            ],
          ),
        ],
      ),
    );
  }

  //左侧盒子
  Widget _leftBox() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: List.generate(
              _keyNamesTwo.length,
              (item) {
                return CustomContainerr(
                  margin: EdgeInsets.only(left: 10),
                  width: (MediaQuery.of(context).size.width - 50) / 4,
                  onTap: () => _onViewClick(_keyNamesTwo[item]),
                  child: CustomText(text: _keyNamesTwo[item]),
                );
              },
            ),
          ),
          Row(
            children: List.generate(
              _keyNamesThree.length,
              (item) {
                return CustomContainerr(
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  width: (MediaQuery.of(context).size.width - 50) / 4,
                  onTap: () => _onViewClick(_keyNamesThree[item]),
                  child: CustomText(text: _keyNamesThree[item]),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              CustomContainerr(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                onTap: () => _onViewClick('0'),
                child: CustomText(text: '0'),
              ),
              CustomContainerr(
                width: (MediaQuery.of(context).size.width - 50) / 4,
                onTap: () => _onViewClick('.'),
                child: CustomText(text: '.'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //右侧盒子
  Widget _rightBox() {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 10, bottom: 10),
        height: 172,
        width: (MediaQuery.of(context).size.width - 50) / 4,
        decoration: BoxDecoration(
          color: Color(0xffE1B96B),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: Color(0xff333333), fontSize: 20),
          ),
        ),
      ),
    );
  }

  ///完整输入的Float值
  void _completeInputFloatValue() {
    var currentText = widget.controller.text;
    if (currentText.endsWith('.')) //如果是小数点结尾的
      widget.controller.text += '00';
    else if (RegExp('^\\d+\\.\\d\$').hasMatch(currentText)) //如果是一位小数结尾的
      widget.controller.text += '0';
    else if (RegExp('^\\d+\$').hasMatch(currentText)) //如果是整数，则自动追加小数位
      widget.controller.text += '.00';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Color(0xff5A5A5A),
        child: _showKeyboardGridView(),
      ),
    );
  }

  @override
  void deactivate() {
    _completeInputFloatValue();
    super.deactivate();
  }
}

//封装
//字体样式
class CustomText extends StatefulWidget {
  final String text;
  CustomText({this.text});
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: Color(0xfff0f0f0),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//每一格Container样式
class CustomContainerr extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double width;
  final EdgeInsetsGeometry margin;
  CustomContainerr({this.child, this.onTap, this.width, this.margin});
  @override
  _CustomContainerrState createState() => _CustomContainerrState();
}

class _CustomContainerrState extends State<CustomContainerr> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
