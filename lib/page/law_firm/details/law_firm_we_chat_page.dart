import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/widget/law_firm/custom_pop_menu.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-27
///
/// 律师详情(律师)-业务类别设置页-律所微信

class LawFirmWeChatPage extends StatefulWidget {
  final List weChatList;
  final String lawId;

  LawFirmWeChatPage(this.weChatList,{this.lawId});
  @override
  _LawFirmWeChatPageState createState() => _LawFirmWeChatPageState();
}

class _LawFirmWeChatPageState extends State<LawFirmWeChatPage> {
  bool isDown = false; //下拉列表判断

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Color(0xff333333),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: isDown == false ? Colors.white : Colors.white.withOpacity(0.8),
            appBar: AppBar(
              backgroundColor: Color(0xff333333),
              elevation: 0,
              leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Image.asset(
                    ARROWPIC,
                    width: 22.38,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                '律所微信',
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
                    '律所微信',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 17,
                    runSpacing: 11,
                    children:List.generate(widget.weChatList.length, (index){
                      double width = (MediaQuery.of(context).size.width-54)/2;
                      return Container(
                        width: width,
                        child: Column(
                          children: <Widget>[
                            CustomPopMenuPage(
                               icon: index == widget.weChatList.length - 1
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
                              hintText: '${widget.weChatList[index].value}',
                              type: widget.weChatList[index].type,
                              lawId: widget.lawId,
                              id: widget.weChatList[index].id,
                              title: widget.weChatList[index].title,
                              isLast: index == widget.weChatList.length - 1 ? true : false,
                              onTap: () {
                                setState(() {
                                  isDown = !isDown;
                                });
                              },
                              onAdd: () {
                                Wechat addList = Wechat(
                                  title: '民商',
                                  type: '微信',
                                  value: '',
                                );
                                setState(() {
                                  widget.weChatList.add(addList);
                                });
                              },
                            ),
                          ],
                        ),
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