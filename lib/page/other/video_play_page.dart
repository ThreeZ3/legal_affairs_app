import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/video/video_model.dart';
import 'package:jh_legal_affairs/api/video/video_view_model.dart';
import 'package:jh_legal_affairs/common/check.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  final String url;
  final VideoDataModel model;
  final List data;

  VideoPlayPage(
    this.url,
    this.model,
    this.data,
  );

  @override
  State<StatefulWidget> createState() => VideoPlayPageState();
}

class VideoPlayPageState extends State<VideoPlayPage> {
  TargetPlatform _platform;

  @override
  void initState() {
    super.initState();
    print('播放视频链接:::${widget.url}');
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: ThemeData.dark().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      child: Scaffold(
        appBar: new NavigationBar(title: '视频播放'),
        body: strNoEmpty(widget?.url)
            ? listNoEmpty(widget.data)
                ? new ListView(
                    children: <Widget>[
                      new Container(
                        height: 300,
                        color: Colors.black,
                        child: new PageView.builder(
                          itemCount: widget.data.length,
                          controller:
                              PageController(initialPage: widget.model.index),
                          itemBuilder: (context, index) {
                            VideoDataModel innerModel = widget.data[index];
                            return PlayWidget(innerModel, widget.url);
                          },
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mainSpace * 2, vertical: 10),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '摘要：',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            new Padding(
                              padding: EdgeInsets.only(left: 20),
                              child:
                                  new EditRichShow(json: widget.model.summary),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : new PlayWidget(widget.model, widget.url)
            : new Center(
                child: new Text('视频为空'),
              ),
      ),
    );
  }
}

class PlayWidget extends StatefulWidget {
  final VideoDataModel model;
  final String url;

  PlayWidget(this.model, this.url);

  @override
  _PlayWidgetState createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> {
  VideoPlayerController _videoPlayerController1;

  @override
  void initState() {
    super.initState();

    _videoPlayerController1 =
        VideoPlayerController.network(widget.model?.dataUrl ?? widget.url)

          // 在初始化完成后必须更新界面
          ..initialize().then((_) {
            setState(() {});
          });
    //浏览视频
    if (strNoEmpty(widget.model?.id)) videoSeeHandle();
    if (widget.model != null) {
      int _count = int.parse(widget.model.count);
      print(_count);
      widget.model.count = '${_count + 1}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: _videoPlayerController1.value.initialized
          ? Chewie(
              controller: ChewieController(
                videoPlayerController: _videoPlayerController1,
                aspectRatio: _videoPlayerController1.value.aspectRatio,
                autoPlay: false,
                looping: false,
              ),
            )
          : Container(child: Text("加载中...")),
    );
  }

  //浏览视频
  void videoSeeHandle() => videoViewModel
      .putVideoSee(context, id: widget.model.id)
      .catchError((e) {});

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    super.dispose();
  }
}
