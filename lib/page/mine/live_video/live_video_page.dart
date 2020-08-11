import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/video/video_model.dart';
import 'package:jh_legal_affairs/api/video/video_view_model.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import '../../../data/data.dart';
import 'video_post_page.dart';

class LiveVideoPage extends StatefulWidget {
  final String id;

  LiveVideoPage(this.id);

  @override
  _LiveVideoPageState createState() => _LiveVideoPageState();
}

class _LiveVideoPageState extends State<LiveVideoPage> {
  bool _delSwitch = false;

  //删除视频
  // delVideoData(){
  //   videoViewModel.delVideo(context,id: "0c1a2f92e1c2cc6e7a57e072937aefc0").catchError((e){
  //     showToast(context, e.message);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationBar(title: "视频直播"),
      body: new Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: new NestedScrollView(
          headerSliverBuilder: (context, bool s) {
            return [
              new SliverToBoxAdapter(
                  child: widget.id == JHData.id()
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 32),
                            Container(
                              height: 80,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
//                                    routePush(LiveVideoStartPage());
                                      showToast(context, '敬请期待');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffFFE1B96B),
                                      ),
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "开始直播",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 4),
                                          CachedNetworkImage(
                                            imageUrl:
                                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd91bdc567-649d-4bd6-9273-31241a2fdf7b",
                                            width: 16,
                                            height: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 16),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      routePush(VideoPostPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffFFE1B96B),
                                      ),
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "发布视频",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 4),
                                          CachedNetworkImage(
                                            imageUrl:
                                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd91bdc567-649d-4bd6-9273-31241a2fdf7b",
                                            width: 16,
                                            height: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        )
                      : new Container()
//                    : new InkWell(
//                        child: Container(
//                          height: 210,
//                          margin: EdgeInsets.symmetric(vertical: 10),
//                          child: new Stack(
//                            alignment: Alignment.bottomRight,
//                            children: <Widget>[
//                              new ClipRRect(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(5)),
//                                child: new CachedNetworkImage(
//                                  imageUrl:
//                                      "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1912947062,3609080490&fm=26&gp=0.jpg",
//                                  fit: BoxFit.cover,
//                                  height: double.maxFinite,
//                                ),
//                              ),
//                              new Container(
//                                padding: EdgeInsets.only(bottom: 8, right: 8.0),
//                                height: 33,
//                                alignment: Alignment.bottomRight,
//                                decoration: BoxDecoration(
//                                    color: Colors.black.withOpacity(0.5),
//                                    borderRadius: BorderRadius.vertical(
//                                        bottom: Radius.circular(5))),
//                                child: new Text(
//                                  '2020-03-31    17:00',
//                                  style: TextStyle(color: Colors.white),
//                                ),
//                              ),
//                              new Positioned(
//                                right: 0,
//                                top: 0,
//                                child: new Container(
//                                  decoration: BoxDecoration(
//                                      color: Colors.red,
//                                      borderRadius: BorderRadius.all(
//                                          Radius.circular(8.0))),
//                                  width: 100,
//                                  height: 35,
//                                  alignment: Alignment.center,
//                                  child: new Text(
//                                    '正在直播',
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 18.0),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        onTap: () {
//                          routePush(LiveVideoStartPage());
//                          showToast(context, '敬请期待');
//                        },
//                      ),
                  )
            ];
          },
          body: new Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    "视频",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  new Visibility(
                    visible: widget.id == JHData.id(),
                    child: GestureDetector(
                      onTap: () {
                        // delVideoData();
                        setState(() {
                          _delSwitch = !_delSwitch;
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd4f20021e-4379-4c6e-954a-009a3a56f86f",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              new Expanded(
                child: VideoGridList(
                  id: widget.id,
                  delSwitch: _delSwitch,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VideoGridList extends StatefulWidget {
  final String id;
  final bool delSwitch;

  VideoGridList({this.id, this.delSwitch});

  @override
  _VideoGridListState createState() => _VideoGridListState();
}

class _VideoGridListState extends State<VideoGridList> {
  List<VideoDataModel> _videoData = new List();
  bool isLoadingOk = false;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    getVideoData();
    Notice.addListener(JHActions.myVideoRefresh(), (v) {
      getVideoData();
    });
  }

  //获取当前用户视频
  Future getVideoData([bool isInit = false]) {
    if (isInit) goPage = 1;
    return videoViewModel
        .getVideoList(
      context,
      limit: 8,
      page: goPage,
      id: widget.id,
    )
        .then((rep) {
      setState(() {
        if (goPage == 1) {
          _videoData = List.from(rep.data);
        } else {
          _videoData.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() {
        isLoadingOk = true;
      });
      showToast(context, e.message);
    });
  }

  delVideoData(id) {
    videoViewModel
        .delVideo(
      context,
      id: id,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataView(
      isLoadingOk: isLoadingOk,
      data: _videoData,
      onRefresh: () => getVideoData(true),
      onLoad: () {
        goPage++;
        return getVideoData();
      },
      child: Wrap(
        runSpacing: 10,
        spacing: 16,
        children: _videoData.map((item) {
          VideoDataModel model = item;
          return new SizedBox(
            width: (winWidth(context) - 48) / 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () => routePush(
                          new VideoPlayPage(model.dataUrl, model, _videoData))
                      .then((value) {
                    setState(() {});
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          new ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl: "${model.cover}",
                              width: MediaQuery.of(context).size.width / 2 - 21,
                              height:
                                  (MediaQuery.of(context).size.width / 2 - 21) /
                                      (167 / 108),
                              fit: BoxFit.cover,
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd9f5ec8a3-94ad-4348-87bc-a4d106cfb2f4",
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "${model?.title ?? '未知'}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: <Widget>[
                          Text(
                            '${DateTimeForMater.formatTimeStampToString(stringDisposeWithDouble(model.createTime / 1000) ?? '0', "yyyy-MM-dd HH:mm:ss")}',
                            style: TextStyle(
                                fontSize: 10, color: Color(0xffFF999999)),
                          ),
                          Spacer(),
                          CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd04fa1f68-4a1c-488b-aac2-65ce34ea6fa8",
                            width: 12,
                            height: 8,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "${strNoEmpty(model?.count) ? model?.count : '0'}",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xffFF999999)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                widget.delSwitch
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            delVideoData(model.id);
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd513eae7e-de3e-4433-a835-ef03a0c2da22",
                            width: 16,
                            height: 16,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Notice.removeListenerByEvent(JHActions.myVideoRefresh());
  }
}
