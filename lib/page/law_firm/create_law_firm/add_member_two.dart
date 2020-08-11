import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_model.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';
import 'package:jh_legal_affairs/page/home/home_label_widget.dart';
import 'package:jh_legal_affairs/page/home/home_ranking_widget.dart';
import 'package:jh_legal_affairs/page/mine/my_law_firm/my_law_firm_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';

///创建律所-添加成员2
class AddMemberPageTwo extends StatefulWidget {
  final String name;
  final String num;
  final String id;

  AddMemberPageTwo({this.name, this.num, this.id});

  @override
  _AddMemberPageTwoState createState() => _AddMemberPageTwoState();
}

//23sd
class _AddMemberPageTwoState extends State<AddMemberPageTwo> {
  bool isLoadingOk = false;
  List<LawyerDetailsInfoModel> data = new List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    lawyerInFoViewModel
        .lawyerSearch(
      context,
      identityCard: widget.id,
      realName: widget.name,
      lawyerCard: widget.num,
    )
        .then((rep) {
      setState(() {
        data = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  inviteHandle(id) {
    firmViewModel.firmInvited(context, userId: id).then((rep) {
      popUntil(ModalRoute.withName(MyLawFirmPage().toStringShort()));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        title: "添加成员",
        rightDMActions: <Widget>[
          new FlatButton(
            onPressed: () {
              data.forEach((item) {
                LawyerDetailsInfoModel model = item;
                inviteHandle(model.id);
              });
            },
            child: new Text(
              '添加',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: data,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: data.map((v) {
            LawyerDetailsInfoModel model = v;
            return AddMemberListBuild(model);
          }).toList(),
        ),
      ),
    );
  }
}

Color themeMainColor = Color(0xffFFE1B96B);
Color themeGrayColor = Color(0xffFF999999);
Color lightGrayColor = Color(0xffFFF0F0F0);

class AddMemberListBuild extends StatelessWidget {
  final LawyerDetailsInfoModel model;

  AddMemberListBuild(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      width: winWidth(context) - 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: strNoEmpty(model?.avatar)
                ? CachedNetworkImage(
                    imageUrl: model?.avatar,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : new Image.asset(
                    avatarLawyerMan,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 9),
          new Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: winWidth(context) - 172,
                  child: Text(
                    "${model?.realName ?? '未知'}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                listNoEmpty(model?.legalField)
                    ? new Container()
                    : new Space(height: mainSpace / 2),
                Text("执业${workYearStr(model?.workYear)}年",
                    style: TextStyle(fontSize: 12, color: Color(0xff999999))),
                listNoEmpty(model?.legalField)
                    ? new Container()
                    : new Space(height: mainSpace / 2),
                Row(
                  children: [
                    "${model?.province ?? '未知地区'}",
                    "${model?.firmName ?? ''}"
                  ].map((v) {
                    return Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text("$v",
                          style: TextStyle(
                              fontSize: 12, color: Color(0xff999999))),
                    );
                  }).toList(),
                ),
                new Space(height: mainSpace / 2),
                new Visibility(
                  visible: listNoEmpty(model?.legalField),
                  child: Wrap(
                    runSpacing: 5,
                    children: (model?.legalField ?? []).map((v) {
                      return Container(
                        margin: EdgeInsets.only(right: 8),
                        child: HomeLabelWidget(name: v.name),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          HomeRankingWidget(name: '${stringDisposeWithDouble(model?.rank)}'),
        ],
      ),
    );
  }
}
