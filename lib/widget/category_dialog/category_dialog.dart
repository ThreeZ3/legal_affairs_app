import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 新增类型对话框
class CategoryDialog extends StatefulWidget {
  final double height; //对话框高度
  final String title; //标题
  final String hintText; //提示文字
  final Function onTap; //提交按钮的点击事件
  final ValueChanged<String> onChanged; //传输入框的内容
  CategoryDialog({
    this.height: 139,
    this.title: "添加类型",
    this.hintText: "请输入新增类别名称",
    this.onTap,
    this.onChanged,
  });
  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
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
              SizedBox(height: 10),
              Container(
                height: 25,
                child: Text(
                  widget.title, //添加类别
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                alignment: Alignment.center,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(3),
                ),
                margin: EdgeInsets.only(left: 61, right: 60),
                child: TextField(
                  keyboardType: TextInputType.text,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
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
                  onChanged: widget.onChanged,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 44,
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
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0xFFE1B96B),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: widget.onTap,
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
