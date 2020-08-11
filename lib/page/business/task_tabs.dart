import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/all_mission_model.dart';
import 'package:jh_legal_affairs/api/task/mission_view_model.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_task_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class TaskTabs extends StatefulWidget {
  TaskTabs({Key key}) : super(key: key);

  @override
  _TaskTabsState createState() => _TaskTabsState();
}

class _TaskTabsState extends State<TaskTabs> {
  List<MissionRecords> _allMissionData = new List();
  bool isLoadingOk = false;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    getAllMissionModelData(true);
  }

  Future getAllMissionModelData([isInit = false]) {
    if (isInit) goPage = 1;
    return missionViewModel
        .missionPublishing(
      context,
      page: goPage,
      limit: 15,
    )
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          _allMissionData = List.from(rep.data);
        } else {
          _allMissionData.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      if (mounted) setState(() => isLoadingOk = true);
      if (e?.message != null) showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return new DataView(
      color: Colors.white,
      data: _allMissionData,
      isLoadingOk: isLoadingOk,
      onRefresh: () => getAllMissionModelData(true),
      onLoad: () {
        goPage++;
        return getAllMissionModelData();
      },
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: _allMissionData.length,
          itemBuilder: (context, index) {
            MissionRecords model = _allMissionData[index];
            return new InkWell(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.title.toString(),
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        new Visibility(
                          visible: model?.own ?? false,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.only(right: 10),
                            color: Color(0xffF0F0F0),
                            alignment: Alignment.center,
                            child: Text(
                              '我',
                              style: TextStyle(
                                color: Color(0xffE1B96B),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          color: Color(0xffF0F0F0),
                          alignment: Alignment.center,
                          child: Text(
                            model?.category ?? '未知类别',
                            style: TextStyle(
                              color: Color(0xffE1B96B),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          color: Color(0xffF0F0F0),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '时限${model?.limit ?? '0'}日',
                            style: TextStyle(
                              color: Color(0xffE1B96B),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${model?.province ?? '未知省'} ${model?.city ?? '未知市'} ${model?.district ?? '未知区'}',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '￥${formatNum(model?.ask?.toString())}',
                          style: TextStyle(
                            color: Color(0xffFF3333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => routePush(new LawyerTaskDetailsPage(model.id)),
            );
          }),
    );
  }

//  @override
//  bool get wantKeepAlive => listNoEmpty(_allMissionData);
}
