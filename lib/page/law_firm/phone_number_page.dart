import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/widget/law_firm/custom_pop_menu.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/api/my_law_firm/my_law_firm_model.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-27
///
/// 律师详情(律师)-业务类别设置页-律所电话

class PhoneNumberPage extends StatefulWidget {
  final List phoneList;
  final String lawId;

  PhoneNumberPage(this.phoneList,{this.lawId});
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
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
                '律所电话',
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
                    '律所电话',
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
                    children:List.generate(widget.phoneList.length, (index){
                      double width = (MediaQuery.of(context).size.width-54)/2;
                      return Container(
                        width: width,
                        child: Column(
                          children: <Widget>[
                            CustomPopMenuPage(
                              icon: index == widget.phoneList.length - 1
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
                              hintText: '${widget.phoneList[index].value}',
                              type: widget.phoneList[index].type,
                              lawId: widget.lawId,
                              id: widget.phoneList[index].id,
                              title: widget.phoneList[index].title,
                              isLast: index == widget.phoneList.length - 1 ? true : false,
                              onTap: () {
                                setState(() {
                                  isDown = !isDown;
                                });
                              },
                              onAdd: () {
                                Photo addList = Photo(
                                  title: '民商',
                                  type: '电话',
                                  value: '',
                                );
                                setState(() {
                                  widget.phoneList.add(addList);
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
