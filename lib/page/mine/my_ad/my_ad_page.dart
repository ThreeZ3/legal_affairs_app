import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/api/ad/ad_view_model.dart';
import 'package:jh_legal_affairs/page/mine/my_ad/my_ad_release.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/mine/round_check_box.dart';
import 'my_ad_details_page.dart';

/// ${widget.oc}的广告
class MyAdPage extends StatefulWidget {
  final String id;
  final String oc;

  MyAdPage(this.id, this.oc);

  @override
  _MyAdPageState createState() => _MyAdPageState();
}

class _MyAdPageState extends State<MyAdPage> {
  int _page = 1;
  bool _isLoadingOk = false;
  List _delList = new List();
  bool _openDel = false;

  List<AdSysBidModel> _consultList = new List();

  @override
  void initState() {
    super.initState();
    getAdSysBid();
    Notice.addListener(JHActions.myAdListRefresh(), (v) => getAdSysBid(true));
    Notice.addListener(JHActions.sourceCaseRefresh(), (v) => getAdSysBid(true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(
        title: '${widget.oc}的广告',
        rightDMActions: widget.id == JHData.id()
            ? <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _openDel = !_openDel;
                    });
                  },
                  child: Image.asset(
                    'assets/images/mine/list_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () => routePush(MyAdRelease()),
                  child: Image.asset(
                    'assets/images/mine/share_icon@3x.png',
                    width: 22.0,
                  ),
                ),
                SizedBox(width: 16.0),
              ]
            : [],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          children: <Widget>[
            Expanded(
              child: DataView(
                isLoadingOk: _isLoadingOk,
                data: _consultList,
                onRefresh: () => getAdSysBid(true),
                onLoad: () {
                  _page++;
                  return getAdSysBid();
                },
                child: ListView(
                  children: _consultList
                      .map((item) => AdItem(
                            data: item,
                            openDel: _openDel,
                            delList: _delList,
                            userId: widget.id,
                          ))
                      .toList(),
                ),
              ),
            ),
            Visibility(
              visible: _openDel,
              child: Column(
                children: <Widget>[
                  RegisterButtonWidget(
                    title: '删除',
                    onTap: () => delAd(),
                  ),
                  SizedBox(height: 14),
                  RegisterButtonWidget(
                    title: '取消',
                    titleColors: ThemeColors.color999,
                    backgroundColors: ThemeColors.colore4,
                    onTap: () {
                      setState(() {
                        _openDel = false;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///删除广告
  delAd() {
    for (int a = 0; a < _delList.length; a++) {
      adViewModel.deleteAd(context, ids: _delList[a]).catchError((e) {
        showToast(context, e.message);
      });
    }
    setState(() {
      _openDel = false;
      _delList = new List();
      Future.delayed(Duration(microseconds: 1000), () {
        getAdSysBid(true);
      });
    });
  }

  ///获取${widget.oc}的广告
  Future getAdSysBid([bool isInit = false]) async {
    if (isInit) _page = 1;
    return adViewModel
        .adSysBid(context, id: widget.id, page: _page, limit: 10)
        .then((rep) {
      setState(() {
        if (_page == 1) {
          _consultList = List.from(rep.data);
        } else {
          _consultList.addAll(List.from(rep.data));
        }
        _isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => _isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myAdListRefresh());
    Notice.removeListenerByEvent(JHActions.sourceCaseRefresh());
  }
}

///${widget.oc}的广告Item
class AdItem extends StatefulWidget {
  final AdSysBidModel data;
  final bool openDel;
  final List delList;
  final String userId;

  const AdItem({
    Key key,
    this.data,
    this.openDel,
    this.delList,
    this.userId,
  }) : super(key: key);

  @override
  _AdItemState createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> {
  TextStyle _style = TextStyle(
    color: ThemeColors.color999,
    fontSize: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        !widget.openDel
            ? Container()
            : Padding(
                padding: EdgeInsets.only(right: 19.0),
                child: RoundCheckBox(
                  value: widget.data.delCheck,
                  onChanged: (v) {
                    setState(() {
                      widget.data.delCheck = !widget.data.delCheck;
                      if (widget.data.delCheck)
                        widget.delList.add(widget.data.id);
                      if (!widget.data.delCheck)
                        widget.delList.remove(widget.data.id);
                    });
                  },
                ),
              ),
        Expanded(child: myAdItem(item: widget.data, userId: widget.userId)),
      ],
    );
  }

  Widget myAdItem({item, userId}) {
    AdSysBidModel model = item;
    return GestureDetector(
      onTap: () => routePush(MyAdDetailsPage(model.id, userId)),
      child: Column(
        children: <Widget>[
          new ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              width: winWidth(context) - 32,
              height: (winWidth(context) - 32) * 438 / 1029,
              imageUrl: model?.contentUrl ??
                  'http://picnew14.photophoto.cn/20200227/falvjiangtang-36334334_1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Space(),
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/mine/ic_location.png',
                width: 14.4,
                height: 18.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 4.0),
                child: Text('${model.position?.split(';')[1] ?? '未知位置'}',
                    style: _style),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: model.startTime != null
                    ? Text(
                        DateTimeForMater.formatTimeStampToString(
                            stringDisposeWithDouble(model.startTime / 1000)),
                        style: _style)
                    : '未知',
              ),
              Spacer(),
              Image.asset('assets/images/mine/ic_eye.png', width: 22.0),
              SizedBox(width: 6.0),
              Text('${model?.clickCount ?? '未知'}次', style: _style),
            ],
          ),
          Divider(),
          SizedBox(height: 13.0),
        ],
      ),
    );
  }
}
