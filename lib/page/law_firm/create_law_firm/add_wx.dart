
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/page/law_firm/create_law_firm/add_email.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';

class WxListWidget extends StatefulWidget {
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
  WxListWidget({
    this.icon,
    this.isDown,
    this.onTap,
    this.name: '民商',
    this.hintText: "123",
    this.title,
    this.id,
    this.isLast,
    this.onAdd,
    this.list,
    this.index,
    this.controller
  });
  @override
  _WxListWidgetState createState() => _WxListWidgetState();
}

class _WxListWidgetState extends State<WxListWidget> {
//  TextEditingController hintTextController =
//  TextEditingController(); //hintText控制器
//  TextEditingController wxController = new TextEditingController();
  String name = '民商';

  @override
  void initState() {
    super.initState();
//    hintTextController = new TextEditingController(text: widget.hintText);
//    wxController.text = widget.hintText;
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
                      changeValue();
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
      type: '微信',
      value: widget.controller.text,
    );
    setState(() {
      widget.list[widget.index] = newList;
    });
  }
}
