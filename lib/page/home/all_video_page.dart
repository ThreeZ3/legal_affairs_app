import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/video/video_model.dart';
import 'package:jh_legal_affairs/api/video/video_view_model.dart';
import 'package:jh_legal_affairs/page/other/video_play_page.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class AllVideoPage extends StatefulWidget {
  final String id;

  AllVideoPage({this.id});

  @override
  _AllVideoPageState createState() => _AllVideoPageState();
}

class _AllVideoPageState extends State<AllVideoPage> {
  List<VideoDataModel> _videoData = new List();
  bool isLoadingOk = false;
  int goPage = 1;

  @override
  void initState() {
    super.initState();
    getVideoData();
  }

  //获取当前用户视频
  Future getVideoData([bool isInit = false]) {
    if (isInit) goPage = 1;
    return videoViewModel
        .allVideoList(
      context,
      limit: 10,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(title: '最新视频'),
      body: new DataView(
        isLoadingOk: isLoadingOk,
        data: _videoData,
        onRefresh: () => getVideoData(true),
        onLoad: () {
          goPage++;
          return getVideoData();
        },
        child: new Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 15),
          child: Wrap(
            runSpacing: 10,
            spacing: 16,
            children: _videoData.map((item) {
              VideoDataModel model = item;
              return new SizedBox(
                width: (winWidth(context) - 48) / 2,
                child: InkWell(
                  onTap: () {
                    routePush(
                      new VideoPlayPage(
                        model.dataUrl,
                        model,
                        _videoData,
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          new ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl: "${model?.cover ?? defCover}",
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
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
