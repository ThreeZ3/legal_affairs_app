import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/button/small_button.dart';

class WalletInquireDetail extends StatefulWidget {
  @override
  _WalletInquireDetailState createState() => _WalletInquireDetailState();
}

class _WalletInquireDetailState extends State<WalletInquireDetail> {
  List time = ['本月', '本周', '近一个月', '近三个月', '近六个月'];
  String currentTiem = '本月';
  DateTime _selectDateStart = DateTime.now();
  String type = '全部';
  DateTime _selectDateLast = DateTime.now();

  //起始时间
  _selectDateMethodStart() async {
    debugPrint('选择时间方法');
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _selectDateStart,
      firstDate: DateTime(1998),
      lastDate: DateTime(2029),
    );

    if (date == null) return;

    setState(() {
      _selectDateStart = date;
    });
  }

  //截止时间
  _selectDateMethodLast() async {
    debugPrint('选择时间方法');
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _selectDateLast,
      firstDate: DateTime(1998),
      lastDate: DateTime(2029),
    );

    if (date == null) return;
    setState(() {
      _selectDateLast = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    List showItem = [
      [
        "全部",
        () {
          setState(() {
            type = '全部';
          });
          routePush(pop());
        }
      ],
      [
        "收入",
        () {
          setState(() {
            type = '收入';
          });
          routePush(pop());
        }
      ],
      [
        "支出",
        () {
          setState(() {
            type = '支出';
          });
          routePush(pop());
        }
      ],
    ];
    return new Scaffold(
        backgroundColor: Color(0xFF333333),
        appBar: new NavigationBar(title: '查询明细'),
        body: Column(
          children: <Widget>[
            Container(
                color: Color(0xFF5A5A5A),
                child: ListTile(
                  title: Text(
                    '收入类别',
                    style: TextStyle(color: Color(0xFFE1B96B), fontSize: 16),
                  ),
                  trailing: GestureDetector(
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
                                  top: positionDy > 440
                                      ? winHeight(context) * 2 / 3
                                      : positionDy,
                                  left: positionDx < 120
                                      ? positionDx
                                      : positionDx - 120,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2)),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    child: Text(
                      type,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )),
            Wrap(
                spacing: 10,
                runSpacing: 5.0,
                children: time.map((item) {
                  return InkWell(
                    onTap: () {
                      print(item);
                      setState(() {
                        currentTiem = item;
                      });
                    },
                    child: Chip(
                      backgroundColor: currentTiem == item
                          ? Color(0xFFE1B96B)
                          : Color(0xFF5A5A5A),
                      label: Text(
                        item,
                        style: TextStyle(
                            color: currentTiem == item
                                ? Color(0xFFFFFFFF)
                                : Color(0xFFE1B96B),
                            fontSize: 14),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xFFE1B96B),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  );
                }).toList()),
            Container(
              margin: EdgeInsets.only(top: 5),
              color: Color(0xFF5A5A5A),
              child: ListTile(
                onTap: () {
                  _selectDateMethodStart();
                },
                title: Text(
                  '起始时间',
                  style: TextStyle(color: Color(0xFFE1B96B), fontSize: 16),
                ),
                trailing: Text(
                  formatDate(this._selectDateStart, [yyyy, '-', mm, '-', dd]),
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18),
              color: Color(0xFF5A5A5A),
              child: ListTile(
                onTap: () {
                  _selectDateMethodLast();
                },
                title: Text(
                  '截止时间',
                  style: TextStyle(color: Color(0xFFE1B96B), fontSize: 16),
                ),
                trailing: Text(
                  formatDate(this._selectDateLast, [yyyy, '-', mm, '-', dd]),
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: SmallButton(
                onPressed: () {
                  if (_selectDateLast.isAfter(_selectDateStart)) {
                    routePush(pop());
                  } else {
                    showToast(context, '截止时间应大于起始时间');
                  }
                },
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: Color(0xFFE1B96B),
                pressedOpacity: 0.8,
                child: Text(
                  '确定',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class ShowItem extends StatelessWidget {
  @required
  final String text;
  final Function function;

  ShowItem({
    Key key,
    this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(top: 7, bottom: 7),
        child: Text(
          text,
          style: TextStyle(color: Color(0xff595959)),
        ),
      ),
    );
  }
}
