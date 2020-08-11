import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/bid/bid_model.dart';
import 'package:jh_legal_affairs/api/bid/bid_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_bid_detail.dart';
import 'package:jh_legal_affairs/page/mine/my_sourcecase/source_case_undertake_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/lawyer/lawyer_entry.dart';

class SourceCaseBidPage extends StatefulWidget {
  final String id;
  final String title;
  final TakeType type;

  SourceCaseBidPage(this.id, this.title, this.type);

  @override
  _SourceCaseBidPageState createState() => _SourceCaseBidPageState();
}

class _SourceCaseBidPageState extends State<SourceCaseBidPage> {
  List<SourceCaseBidModel> data = new List();
  bool isLoadingOk = false;
  int _goPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData([bool isInit = false]) {
    if (widget.type == TakeType.sourceCase) {
      return sourceCaseBid(isInit);
    } else {
      return missionsBid(isInit);
    }
  }

  Future sourceCaseBid([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return bidViewModel
        .sourceCaseBiddingList(
      context,
      id: widget.id,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  Future missionsBid([bool isInit = false]) {
    if (isInit) _goPage = 1;
    return bidViewModel
        .missionsBidList(
      context,
      id: widget.id,
      limit: 15,
      page: _goPage,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NavigationBar(title: '竞价'),
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: data,
        onRefresh: () => getData(true),
        onLoad: () {
          _goPage++;
          return getData();
        },
        child: new ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            SourceCaseBidModel model = data[index];
            return SourceCaseBidItem(widget.id, model, widget.type);
          },
        ),
      ),
    );
  }
}

class SourceCaseBidItem extends StatelessWidget {
  final String id;
  final SourceCaseBidModel model;
  final TakeType type;

  SourceCaseBidItem(this.id, this.model, this.type);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: Color(0xff999999), fontSize: 12);

    return new InkWell(
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.8), width: 0.5),
          ),
        ),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              radius: 25,
              backgroundImage: strNoEmpty(model?.avatar)
                  ? CachedNetworkImageProvider(model?.avatar)
                  : AssetImage(avatarLawyerMan),
            ),
            new Space(),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    '${model?.nickName ?? '未知'}',
                    style: TextStyle(color: Color(0xff181111), fontSize: 14.0),
                  ),
                  new Wrap(
                    spacing: 10,
                    children: <Widget>[
                      new Text(
                          '${strNoEmpty(model?.province) ? model?.province : '未知省'} ${strNoEmpty(model?.city) ? model.city : '未知市'}',
                          style: labelStyle),
                    ]..addAll(List.from(model?.legalField ?? []).map((item) {
                        return new Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF2ECEC),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          child: new Text(
                            '${item ?? '未知'}',
                            style: TextStyle(
                                color: Color(0xffE1B96C), fontSize: 10),
                          ),
                        );
                      }).toList()),
                  ),
                  new Text('${model?.firmName ?? '未知事务所'}', style: labelStyle),
                ],
              ),
            ),
            new Space(),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new IconBox(
                    text: '排名',
                    number: '${stringDisposeWithDouble(model?.rank)}'),
                new Space(),
                new Text(
                  '¥ ${formatNum(model?.offer?.toString() ?? '0.0')}',
                  style: TextStyle(color: Color(0xffE12A2A), fontSize: 12.0),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () => routePush(new SourceCaseBidDetail(id,
          model?.advantage ?? '未知', type, model?.nickName ?? '未知', model.id)),
    );
  }
}
