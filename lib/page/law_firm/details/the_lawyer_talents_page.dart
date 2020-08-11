import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/firm/firm_model.dart';
import 'package:jh_legal_affairs/api/firm/firm_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/entry.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-23
///
/// 律所详情-律师人才
///
class TheLawyerTalentsPage extends StatefulWidget {
  final String id;

  TheLawyerTalentsPage(this.id);

  @override
  _TheLawyerTalentsPageState createState() => _TheLawyerTalentsPageState();
}

class _TheLawyerTalentsPageState extends State<TheLawyerTalentsPage> {
  List<FirmMemberModel> data = new List();
  bool isLoadingOk = false;

  @override
  void initState() {
    super.initState();
    getMember();
  }

  Future getMember() {
    return firmViewModel
        .viewFirmMembers(
      context,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        data = List.from(rep.data);
        isLoadingOk = true;
      });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      print('e====>${e.toString()}');
      showToast(context, e.message);
    });
  }

  Widget itemBuild(BuildContext context, index) {
    FirmMemberModel model = data[index];
    return new InkWell(
      child: Container(
        margin: index == 0
            ? EdgeInsets.only(top: 16, bottom: 25)
            : EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
                child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    strNoEmpty(model?.avatar)
                        ? new CachedNetworkImage(
                            imageUrl: model?.avatar,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : new Image.asset(
                            avatarLawyerMan,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    index <= 2
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: RedLabel(
                              text: 'Top${index + 1}',
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '${model?.realName ?? '未知'}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '执业${workYearStr(model.workYear)}年',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      new Space(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${model.district ?? '未知'}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(width: 4),
                          Container(
                            width: 1,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xff999999),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${model.city ?? '未知'}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      new Space(height: 5.0),
                      !listNoEmpty(model?.legalField)
                          ? LabelBox(
                              text: '未知',
                            )
                          : Wrap(
                              spacing: 5,
                              runSpacing: 3,
                              children: model.legalField.map((item) {
                                return LabelBox(
                                  text:
                                      '${item?.name ?? '未知'} ${stringDisposeWithDouble(item?.rank)}',
                                  width: 51,
                                  height: 18,
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ],
            )),
            Container(
              height: 84,
              alignment: Alignment.topRight,
              child: IconBox(
                text: '排名',
                number: '${model?.rank ?? 0}',
              ),
            ),
          ],
        ),
      ),
      onTap: () => routePush(new LawyerDetailsPage(
        model.userId,
//        int.parse(stringDisposeWithDouble(model?.rank)),
//        model?.legalField??[],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffffE),
      appBar: NavigationBar(title: '律所人才'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: new DataView(
          isLoadingOk: isLoadingOk,
          data: data,
          onRefresh: getMember,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: itemBuild,
          ),
        ),
      ),
    );
  }
}
