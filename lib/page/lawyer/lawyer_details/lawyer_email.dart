import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';

class LawyerEmail extends StatefulWidget {
  final List emailList;
  LawyerEmail(this.emailList);

  @override
  _LawyerEmailState createState() => _LawyerEmailState();
}

class _LawyerEmailState extends State<LawyerEmail> {
  @override
  Widget build(BuildContext context) {
    return MainInputBody(
      child: Scaffold(
        appBar: NavigationBar(
          title: '律师邮箱',
          rightDMActions: <Widget>[
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Image.asset(
                GoodSelectPic,
                width: 22.38,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '律师邮箱',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              !listNoEmpty(widget.emailList)
                  ? Container(
                      width: (MediaQuery.of(context).size.width - 54) / 2,
                      child: Column(
                        children: <Widget>[
                          EmailListPage(
                            icon: Image.asset(
                              'assets/images/law_firm/full_add@3x.png',
                              width: 17,
                              height: 17,
                            ),
                            isLast: true,
                            onAdd: () {
                              Photo addList = Photo(
                                title: '民商',
                                type: '电话',
                                value: '',
                              );
                              setState(() {
                                widget.emailList.add(addList);
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : Wrap(
                      runSpacing: 10,
                      spacing: 20,
                      children: List.generate(widget.emailList.length, (index) {
                        return Container(
                          width: (MediaQuery.of(context).size.width - 54) / 2,
                          child: Column(
                            children: <Widget>[
                              EmailListPage(
                                icon: index == widget.emailList.length - 1
                                    ? Image.asset(
                                        'assets/images/law_firm/full_add@3x.png',
                                        width: 17,
                                        height: 17,
                                      )
                                    : Image.asset(
                                        'assets/images/law_firm/minus@3x.png',
                                        width: 17,
                                        height: 17,
                                      ),
                                hintText: '${widget.emailList[index].value}',
                                id: widget.emailList[index].id,
                                title: widget.emailList[index].title,
                                isLast: index == widget.emailList.length - 1
                                    ? true
                                    : false,
                                onAdd: () {
                                  Photo addList = Photo(
                                    title: '民商',
                                    type: '电话',
                                    value: '',
                                  );
                                  setState(() {
                                    widget.emailList.add(addList);
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
    );
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

class EmailListPage extends StatefulWidget {
  final Widget icon;
  final bool isDown;
  final Function onTap;
  final String name;
  final String hintText;
  final String title;
  final String id;
  final Function onadd;
  final bool isLast;
  final Function onAdd;
  EmailListPage({
    this.icon,
    this.isDown,
    this.onTap,
    this.name: '民商',
    this.hintText: "18829173616@qq.com",
    this.title,
    this.id,
    this.isLast,
    this.onAdd,
    this.onadd,
  });
  @override
  _EmailListPageState createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  TextEditingController textController = TextEditingController(); //邮箱控制器
  TextEditingController hintTextController =
      TextEditingController(); //hintText控制器
  String name = '民商';

  @override
  void initState() {
    super.initState();
    hintTextController = new TextEditingController(text: widget.hintText);
    textController.text = widget.hintText;
    name = widget.title;
  }

  ///添加律师详情资料->微信，电话，邮箱，公众号
  void lawyerContacts(value) {
    if (value == '') return;
    LawyerInFoViewModel()
        .lawyerContacts(context, title: name, value: value, type: 2)
        .then((rep) {
      showToast(context, '新增成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
      Navigator.pop(context);
    }).catchError((e) {
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  ///修改律师详情资料->微信，电话，邮箱，公众号
  void lawyerContactsChange(value) {
    if (widget.id == null) {
      lawyerContacts(value);
    } else {
      LawyerInFoViewModel()
          .lawyerContactsChange(context,
              id: widget.id, title: name, value: value, type: 2)
          .then((rep) {
        showToast(context, '修改成功');
        Notice.send(JHActions.myFirmDetailRefresh(), '');
      }).catchError((e) {
        print('e====>${e.toString()}');
        showToast(context, e.message);
      });
    }
  }

  ///删除律师详情资料->微信，电话，邮箱，公众号
  void lawyerContactsDelete() {
    LawyerInFoViewModel()
        .lawyerContactsDelete(
      context,
      id: widget.id,
    )
        .then((rep) {
      showToast(context, '删除成功');
      Notice.send(JHActions.myFirmDetailRefresh(), '');
      Navigator.pop(context);
    }).catchError((e) {
      print('e====>${e.toString()}');
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
        lawyerContactsDelete();
      },
      cancelFunction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    List showItem = [
      [
        "民商",
        () {
          setState(() {
            name = "民商";
            lawyerContactsChange(textController.text);
          });
          routePush(pop());
        }
      ],
      [
        "刑事",
        () {
          setState(() {
            name = "刑事";
            lawyerContactsChange(textController.text);
          });
          routePush(pop());
        }
      ],
      [
        "资本",
        () {
          setState(() {
            name = "资本";
            lawyerContactsChange(textController.text);
          });
          routePush(pop());
        }
      ],
      [
        "公益",
        () {
          setState(() {
            name = "公益";
            lawyerContactsChange(textController.text);
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
                  if (widget.onadd != null) widget.onadd();
                  if (widget.isLast) {
                    setState(() {
                      widget.onAdd();
                    });
                  } else {
                    setState(() {
                      delDialog();
                    });
                  }
                },
                child: widget.icon,
              ),
              SizedBox(width: 4),
              Text(name ?? '新增'),
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
                    controller: textController,
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
                      print('值为:' + value);
                      if (isEmail(value) == false) {
                        showToast(context, '请填写正确的邮箱格式');
                      } else {
                        lawyerContactsChange(value);
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
}
