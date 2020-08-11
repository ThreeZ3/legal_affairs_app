// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-06
///
/// 律师详情(律师)-律所邮箱

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/widget/law_firm/custom_pop_menu.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';

class LawFirmEmailPage extends StatefulWidget {
  final List list;
  final String lawId;

  LawFirmEmailPage(this.list,{this.lawId});
  @override
  _LawFirmEmailPageState createState() => _LawFirmEmailPageState();
}

class _LawFirmEmailPageState extends State<LawFirmEmailPage> {
  bool isDown = false; //下拉列表判断
  List downList = ['民商', '刑事', '资本', '公益']; //下拉列表数据
  String name = '民商';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Color(0xff333333),
        child: SafeArea(
          child: Scaffold(
            backgroundColor:
                isDown == false ? Colors.white : Colors.white.withOpacity(0.8),
            appBar: AppBar(
              backgroundColor: Color(0xff333333),
              elevation: 0,
              leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Image.asset(
                    ARROWPIC,
                    width: 26.26,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                '律所邮箱',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Image.asset(
                      GoodSelectPic,
                      width: 22.38,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    '律所邮箱',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Column(
                    children: List.generate(widget.list.length, (index) {
                      return Column(
                        children: <Widget>[

                          Stack(
                            children: <Widget>[
                              CustomPopMenuPage(
                                icon: index == widget.list.length - 1
                                    ? Image.asset(
                                        "assets/images/law_firm/full_add@3x.png",
                                        width: 17,
                                        height: 17,
                                      )
                                    : Image.asset(
                                        "assets/images/law_firm/minus@3x.png",
                                        width: 17,
                                        height: 17,
                                      ),
                                hintText: '${widget.list[index].value}',
                                type: widget.list[index].type,
                                lawId: widget.lawId,
                                id: widget.list[index].id,
                                title: widget.list[index].title,
                                isLast: index == widget.list.length - 1 ? true : false,
                                onTap: () {
                                  setState(() {
                                    isDown = !isDown;
                                  });
                                },
                                onAdd: () {
                                    Email addList = Email(
                                      title: '民商',
                                      type: '邮箱',
                                      value: '',
                                    );
                                    setState(() {
                                      widget.list.add(addList);
                                    });
                                  },
                              ),
                              // SizedBox(height: 11),
                              // isDown == false
                              //     ? Container()
                              //     : Container(
                              //         color: Colors.white,
                              //         alignment: Alignment.center,
                              //         margin: EdgeInsets.only(top: 30),
                              //         height: 147,
                              //         width: 63.5,
                              //         child: Column(
                              //           children: List.generate(
                              //             downList.length,
                              //             (item) {
                              //               return Column(
                              //                 children: <Widget>[
                              //                   GestureDetector(
                              //                     onTap: () {
                              //                       print(
                              //                           '点击了${downList[item]};索引值为$item');
                              //                       setState(() {
                              //                         isDown = false;
                              //                         name = downList[item];
                              //                       });
                              //                     },
                              //                     child: Container(
                              //                       margin: EdgeInsets.symmetric(
                              //                           vertical: 7),
                              //                       child: Text(
                              //                         downList[item],
                              //                         style: TextStyle(
                              //                           fontSize: 14,
                              //                           color: Color(0xff333333),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   item == downList.length - 1
                              //                       ? Container()
                              //                       : Container(
                              //                           width:
                              //                               MediaQuery.of(context)
                              //                                   .size
                              //                                   .width,
                              //                           height: 2,
                              //                           color: Color(0xffF4F4F4),
                              //                         ),
                              //                 ],
                              //               );
                              //             },
                              //           ),
                              //         ),
                              //       ),
                            ],
                          ),
                          SizedBox(height: 6,),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
