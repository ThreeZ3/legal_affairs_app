import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:easy_video_compress/easy_video_compress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/api/video/video_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/update_dialog.dart';
import 'package:jh_legal_affairs/widget/other/get_loading_widget.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:video_player/video_player.dart';
import 'package:zefyr/zefyr.dart';

class VideoPostPage extends StatefulWidget {
  @override
  _VideoPostPageState createState() => _VideoPostPageState();
}

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

final doc = r'[{"insert":"\n"}]';

class _VideoPostPageState extends State<VideoPostPage> {
  String _title;
  String _videoPath;
  String thumbnailPath = '';
  int _count = 0;
  int _total = 0;

  int _downloadProgress = 0;
  UploadingFlag uploadingFlag = UploadingFlag.idle;

  DateTime d = DateTime.now();

//  String _content;
  File _video;
  VideoPlayerController _videoPlayerController;

  final ZefyrController _controller =
      ZefyrController(NotusDocument.fromDelta(getDelta()));

  ///获取图库视频
  _getVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    setState(() {
      _video = video;
      print('选取视频：' + _video.path);
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
//          _videoPlayerController.play();
        });
    });
    print('压缩之前文件大小::${video.lengthSync()}');
    String download = await EasyVideoCompress().getPath;
    String dateStr =
        'video_${d.year}_${d.month}_${d.day}_${d.hour}_${d.minute}_${d.second}.mp4';
    print('完整路径：：$download$dateStr');
    if (Platform.isIOS) {
      systemViewModel
          .testOss(
        context,
        file: video,
        isVideo: true,
        second: 360,
        thumbnail: (v) => thumbnailPath = v,
        onSendProgress: (int count, int total) {
          if (mounted)
            setState(() {
              _count = count;
              _total = total;
            });
        },
      )
          .then((rep) {
        if (mounted)
          setState(() {
            _videoPath = rep.data["data"];
          });
      }).catchError((e) {
        if (mounted) showToast(context, e.message);
      });
    } else {
      EasyVideoCompress()
          .easyVideoCompress(video.path, '$download$dateStr')
          .then((bool isOk) {
        if (!isOk) {
          showToast(context, '压缩出现问题，可能权限不足');
          print('压缩出现问题，可能权限不足');
          return;
        }
      });
    }
  }

  postVideoData() {
    videoViewModel
        .postVideoList(
      context,
      dataUrl: _videoPath,
      title: _title,
      summary: jsonEncode(List.from(_controller.document.toJson())),
      cover: thumbnailPath,
    )
        .catchError((e) {
      showToast(context, e.message);
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      EasyVideoCompress().onMessage.listen(handle);
    }
  }

  handle(dynamic onData) async {
    String download = await EasyVideoCompress().getPath;
    String dateStr =
        'video_${d.year}_${d.month}_${d.day}_${d.hour}_${d.minute}_${d.second}.mp4';

    File inFile = File('$download$dateStr');

    if (onData == 'getPlatformVersion') return;
    if (onData == 'start') {
      if (mounted) setState(() => uploadingFlag = UploadingFlag.uploading);
      return;
    } else if (onData.toString().contains('error')) {
      if (mounted)
        setState(() => uploadingFlag = UploadingFlag.uploadingFailed);
      return;
    } else if (onData.toString() == 'onSuccess' && inFile.existsSync()) {
      if (mounted) setState(() => uploadingFlag = UploadingFlag.uploaded);
      systemViewModel
          .testOss(
        context,
        file: inFile,
        isVideo: true,
        second: 360,
        thumbnail: (v) => thumbnailPath = v,
        onSendProgress: (int count, int total) {
          if (mounted)
            setState(() {
              _count = count;
              _total = total;
            });
        },
      )
          .then((rep) {
        if (mounted)
          setState(() {
            _videoPath = rep.data["data"];
          });
      }).catchError((e) {
        if (mounted) showToast(context, e.message);
      });
    } else {
      if (mounted) {
        setState(() {
          uploadingFlag = UploadingFlag.uploading;
          _downloadProgress = (onData).toInt();
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoPlayerController != null) _videoPlayerController.dispose();
  }

//
//  testOss() async {
//    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
//    if (file == null) return;
//    systemViewModel
//        .testOss(
//      context,
//      file: file,
//      second: 360,
//    )
//        .then((rep) {
//      print('图片地址::${rep.data['data']}');
//    }).catchError((e) {
//      if (mounted) showToast(context, e.message);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(
        leading: InkWell(
          child: new Container(
            width: 60,
            height: 28,
            margin: EdgeInsets.symmetric(vertical: 13),
            child: Image.asset('assets/register/register_back.png',
                color: Color(0xffdcba76)),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.maybePop(context);
            if (_videoPlayerController != null) _videoPlayerController.pause();
          },
        ),
        rightDMActions: <Widget>[
          GestureDetector(
            onTap: () {
              postVideoData();
              if (_videoPlayerController != null)
                _videoPlayerController.pause();
            },
            child: Container(
              child: Image.asset("assets/images/mine/share_icon@3x.png"),
              margin: EdgeInsets.all(14),
            ),
          )
        ],
        title: "发布视频",
      ),
      body: new MainInputBody(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: <Widget>[
              GetLoadingWidget(
                uploadingFlag: uploadingFlag,
                downloadProgress: _downloadProgress,
              ),
              SizedBox(height: 12),
              _video == null
                  ? GestureDetector(
                      onTap: () {
                        _getVideo();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            height: 170,
                            color: Colors.grey[300],
                          ),
                          CachedNetworkImage(
                            imageUrl:
                                "https://lanhu.oss-cn-beijing.aliyuncs.com/xdeff0b1b9-ae4e-4958-8bf1-e9e5daafa906",
                            height: 48,
                            width: 48,
                          )
                        ],
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: new Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Chewie(
                            controller: ChewieController(
                                videoPlayerController: _videoPlayerController,
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio),
                          ),
                          new Visibility(
                            visible: _count != 0 && (_count / _total) != 1,
                            child: new Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          new Positioned(
                            right: 20,
                            top: 20,
                            child: new GestureDetector(
                              child: new CircleAvatar(
                                radius: 15,
                                child: new Icon(CupertinoIcons.delete),
                              ),
                              onTap: () {
                                setState(() => _video = null);
                                _videoPath = null;
                                if (_videoPlayerController != null)
                                  _videoPlayerController.pause();
                              },
                            ),
                          ),
                          new Visibility(
                            visible: _count != 0 && (_count / _total) != 1,
                            child: new CircularProgressIndicator(
                              value: _count / _total,
                              strokeWidth:
                                  _videoPlayerController.value.aspectRatio * 50,
                              valueColor: AlwaysStoppedAnimation(themeColor),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
//                       child: VideoPlayer(_videoPlayerController),
                    ),
              SizedBox(height: 12),
              Text(
                "标题",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.grey[300]))),
                  child: TextField(
                    onChanged: (v) {
                      setState(() {
                        _title = v;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "请填写标题",
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none),
                  )),
              SizedBox(height: 16),
              Text(
                "摘要",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child:
                    new EditRichView(contentC: _controller, hintText: '请输入摘要'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
