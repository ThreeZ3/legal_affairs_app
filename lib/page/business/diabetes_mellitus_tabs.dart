import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/case/case_model.dart';
import 'package:jh_legal_affairs/api/case/case_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_details_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class DiabetesMellitusTabs extends StatefulWidget {
  DiabetesMellitusTabs({Key key}) : super(key: key);

  @override
  _DiabetesMellitusTabsState createState() => _DiabetesMellitusTabsState();
}

class _DiabetesMellitusTabsState extends State<DiabetesMellitusTabs> {
  List<SourceCaseModel> _sourceCasesData = [];
  bool isLoadingOk = false;
  int _goPage = 1;

  @override
  void initState() {
    super.initState();
    getMyCourseWareData();
  }

  Future getMyCourseWareData([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return caseViewModel
        .sourceCaseAllList(
      context,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          _sourceCasesData = List.from(rep.data);
        } else {
          _sourceCasesData.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, '${e.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return new DataView(
      isLoadingOk: isLoadingOk,
      data: _sourceCasesData,
      color: Colors.white,
      onRefresh: () => getMyCourseWareData(true),
      onLoad: () {
        _goPage++;
        return getMyCourseWareData();
      },
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _sourceCasesData.length,
        itemBuilder: (context, index) {
          return new InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          _sourceCasesData[index].title.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '￥' +
                            formatNum(_sourceCasesData[index]?.fee?.toString()),
                        style: TextStyle(
                          color: Color(0xffFF3333),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: <Widget>[
                      new Visibility(
                        visible: _sourceCasesData[index]?.own ?? false,
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
                          _sourceCasesData[index].categoryName.toString(),
                          style: TextStyle(
                            color: Color(0xffE1B96B),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(_sourceCasesData[index].createTime / 1000) ?? '0')}',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  EditRichShowText(
                    maxLines: 1,
                    json: _sourceCasesData[index].content.toString(),
                  ),
                ],
              ),
            ),
            onTap: () => routePush(
                new SourceCaseDetailsPage(_sourceCasesData[index].id)),
          );
        },
      ),
    );
  }

//  @override
//  bool get wantKeepAlive => listNoEmpty(_sourceCasesData);
}
