import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';

class EmailListPage extends StatefulWidget {
  final TextEditingController controller;
  final Widget icon;
  final bool isDown;
  final Function onTap;
  final String name;
  final String hintText;
  final String title;
  final String id;
  final bool isLast;
  final Function onAdd;
  final List list;
  final int index;

  EmailListPage(
      {this.icon,
      this.isDown,
      this.onTap,
      this.name: '民商',
      this.hintText: "18829173616@qq.com",
      this.title,
      this.id,
      this.isLast,
      this.onAdd,
      this.list,
    this.index,
        this.controller
    });

  @override
  _EmailListPageState createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
//   widget = TextEditingController(); //邮箱控制器

//  TextEditingController hintTextController =
//      TextEditingController(); //hintText控制器
//  TextEditingController tController = new TextEditingController();
  String name = '民商';

  @override
  void initState() {
    super.initState();
//    hintTextController = new TextEditingController(text: widget.hintText);
//    tController.text = widget.hintText;
    name = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    List showItem = [
      [
        "民商",
        () {
          setState(() {
            name = "民商";
            changeValue();
          });
          routePush(pop());
        }
      ],
      [
        "刑事",
        () {
          setState(() {
            name = "刑事";
            changeValue();
          });
          routePush(pop());
        }
      ],
      [
        "资本",
        () {
          setState(() {
            name = "资本";
            changeValue();
          });
          routePush(pop());
        }
      ],
      [
        "公益",
        () {
          setState(() {
            name = "公益";
            changeValue();
          });
          routePush(pop());
        }
      ],
    ];
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
                    widget.onTap();
                  }
                },
                child: widget.icon,
              ),
              SizedBox(width: 4),
              Text(name),
              GestureDetector(
                onTapDown: (p) {
                  double positionDy = 0;
                  double positionDx = 0;
                  positionDy = p.globalPosition.dy;
                  positionDx = p.globalPosition.dx;
                  showDialog(
                    context: context,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Stack(
                          children: <Widget>[
                            Positioned(
                              top: positionDy - 10,
                              left: positionDx - 55,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: showItem.map((item) {
                                    return ShowItem(
                                      text: item[0],
                                      function: item[1],
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: InkWell(
                  child: Container(
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 20,
                  alignment: Alignment.centerRight,
                  child: TextField(
                    textAlign: TextAlign.end,
                    controller: widget.controller,
                    maxLines: 1,
                    inputFormatters: [LengthLimitingTextInputFormatter(18)],
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(),
                      hintText: '请输入',
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
                      if (isEmail(value) == false) {
                        showToast(context, '请填写正确的邮箱格式');
                      }else{
                        changeValue();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  changeValue() {
    Photo newList = Photo(
      title: name,
      type: '邮箱',
      value: widget.controller.text,
    );
    setState(() {
      widget.list[widget.index] = newList;
    });
  }
}

class ShowItem extends StatelessWidget {
  @required
  final String text;
  final Function function;

  ShowItem({Key key, this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.grey.withOpacity(0.4)))),
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
