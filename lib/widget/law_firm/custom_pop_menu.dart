import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';

class CustomPopMenuPage extends StatefulWidget {
  final Widget icon;
  final bool isDown;
  final Function onTap;
  final String hintText;
  final String type;
  final String id;
  final String title;
  final bool isLast;
  final String lawId;
  final Function onAdd;
  CustomPopMenuPage({
    Key key,
    this.icon,
    this.isDown,
    this.onTap,
    this.hintText:"18829173616@qq.com",
    this.type,
    this.id,
    this.title,
    this.isLast,
    this.lawId,
    this.onAdd
    }) : super(key: key);
  @override
  _CustomPopMenuPageState createState() => _CustomPopMenuPageState();
}

class _CustomPopMenuPageState extends State<CustomPopMenuPage> {
  TextEditingController textController = TextEditingController(); //邮箱控制器
  bool isDown = false; //下拉列表判断
  List downList = ['民商', '刑事', '资本', '公益']; //下拉列表数据
  String name = '民商';

  @override
  void initState() {
    super.initState();
    textController.text = widget.hintText;
    name = widget.title;
  }

  ///新增属性
  addFirmSettingByType(value) {
    if (value == '') return;
    firmViewModel
      .addFirmSetting(
      context,
      lawId: widget.lawId,
      title: name,
      type: widget.type == '电话' ? 1 : (widget.type == '邮箱' ? 2 : 3),
      value: value,
    )
        .then((rep) {
      showToast(context, '新增成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
      Navigator.pop(context);
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  /// 修改律所属性
  Future changeFirmInfo(value) async {
    if (widget.id == null) {
      addFirmSettingByType(value);
    } else {
      firmViewModel
          .changeFirmSetting(
        context,
        id: widget.id,
        title: name,
        value: value
      )
          .then((rep) {
        showToast(context, '修改成功');
        Notice.send(JHActions.myFirmDetailRefresh(), '');
      }).catchError((e) {
        setState(() => {});
        showToast(context, e.message);
      });
    }
  }

  /// 删除律所属性
  Future delFirmInfo() async {
    firmViewModel
        .delFirmSetting(
      context,
      widget.id,
    )
        .then((rep) {
      showToast(context, '删除成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
      Navigator.pop(context);
    }).catchError((e) {
      setState(() => {});
      showToast(context, e.message);
    });
  }

  delDialog() {
    themeAlert(
      context,
      okBtn: '确定',
      cancelBtn: '取消',
      warmStr: '确定删除？',
      okFunction: () {
        delFirmInfo();
      },
      cancelFunction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (widget.isLast) {
                      widget.onAdd();
                    } else {
                      delDialog();
                    }
                  },
                  child: widget.icon,
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: ()  {
                    setState(() {
                      isDown = !isDown;
                      widget.onTap();
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff999999),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 20,
                    alignment: Alignment.centerRight,
                    child: TextField(
                      textAlign: TextAlign.end,
                      controller: textController,
                      maxLines: 1,
                      inputFormatters: [LengthLimitingTextInputFormatter(18)],
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(),
                        hintStyle: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: '请输入',
                        hintMaxLines: 1,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        print('值为:' + value);
                        if (widget.type == '邮箱' && isEmail(value) == false) {
                          showToast(context, '请填写正确的邮箱格式');
                        }else if (widget.type == '电话' && isMobilePhoneNumber(value) == false) {
                          showToast(context, '请填写正确的手机格式');
                        } else {
                          changeFirmInfo(value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            isDown == false
                ? Container()
                : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  height: 147,
                  width: 63.5,
                  child: Column(
                    children: List.generate(
                      downList.length,
                      (item) {
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print('点击了${downList[item]};索引值为$item');
                                setState(() {
                                  isDown = false;
                                  name = downList[item];
                                  changeFirmInfo(textController.text);
                                  widget.onTap();
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Text(
                                  downList[item],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ),
                            ),
                            item == downList.length - 1
                                ? Container()
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Color(0xffF4F4F4),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      );
  }
}
