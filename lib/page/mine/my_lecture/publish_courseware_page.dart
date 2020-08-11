import 'package:chewie/chewie.dart';
import 'package:easy_video_compress/easy_video_compress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/api/lecture/lecture_view_model.dart';
import 'package:jh_legal_affairs/api/system/system_model.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/dialog/update_dialog.dart';
import 'package:jh_legal_affairs/widget/law_firm/dialog.dart';
import 'package:jh_legal_affairs/widget/mine/video_card.dart';
import 'package:jh_legal_affairs/widget/other/get_loading_widget.dart';
import 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
import 'package:jh_legal_affairs/widget_common/button/maginc_bt.dart';
import 'package:jh_legal_affairs/widget_common/theme_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

/// 我的课件-发布课件(待优化)

class PublishCourseWarePage extends StatefulWidget {
  @override
  _PublishCourseWarePageState createState() => _PublishCourseWarePageState();
}

class _PublishCourseWarePageState extends State<PublishCourseWarePage> {
  TextEditingController _titleC = new TextEditingController();
  /*TextEditingController priceC = new TextEditingController();*/
  double priceC;
  TextEditingController _contentC = new TextEditingController();
  List<CategoryModel> _categoryList = new List();
  CategoryModel currentCategory = new CategoryModel();
  bool value = false;
  int charge;
  int isCharge = 0;
  String imageFileUrl;
  Future<File> _imageFile;
  String thumbnailPath = '';
  File _video;
  VideoPlayerController _videoPlayerController;
  int _count = 0;
  int _total = 0;
  String _videoPath;
  int _downloadProgress = 0;
  UploadingFlag uploadingFlag = UploadingFlag.idle;
  DateTime d = DateTime.now();
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    getCategory();
    if (Platform.isAndroid) {
      EasyVideoCompress().onMessage.listen(handle);
    }
  }

  ///调用系统相册
  _selectedImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return null;
    systemViewModel.uploadFile(context, file: imageFile).then((rep) {
      print("上传文件成功,最终地址为：：${rep.data['data']}");
      setState(() {
        imageFileUrl = rep.data['data'];
      });
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///新增课件
  void lectureAdd() {
    if (!strNoEmpty(_contentC.text) && isShow) {
      showToast(context, '请输入内容');
      return;
    }
    lectureViewModel
        .lectureAdd(
          context,
          category: currentCategory.id,
          title: _titleC.text,
          isCharge: isCharge,
          content: _contentC.text,
          cover: thumbnailPath,
//          videoUrl: _videoPath1,
          videoUrl: _videoPath,
          charges: priceC,
        )
        .catchError((e) => showToast(context, e.message));
  }

  //是否收费      0不收费，1收费
  _onChanged() {
    setState(() {
      if (value = !value) {
        isCharge = 1;
        value = true;
      } else {
        isCharge = 0;
        priceC = 0.0;
      }
      /*if (value == false) {
        value = true;
      } else {
        isCharge = 1;
        value = false;
      }*/
    });
  }

  ///判断是否不为空的正浮点数并返回一个int值
  isNoEmptyMoney(value) {
    if (strNoEmpty(value)) {
      if (isMoney(value)) {
        return charge = int.parse(value);
      }
    }
  }

  // 获取图库视频
//  File _video1;
//  VideoPlayerController _videoPlayerController1;
//  String _videoPath1;

//  _getVideo() async {
//    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
//    if (video == null) return;
//    setState(() {
//      _video1 = video;
//      _videoPlayerController1 = VideoPlayerController.file(_video1)
//        ..initialize().then((_) {
//          setState(() {});
//        });
//    });
//    systemViewModel
//        .uploadFile(
//      context,
//      file: video,
//      isVideo: true,
//      second: 180,
//      thumbnail: (v) => thumbnailPath = v,
//    )
//        .then((rep) {
//      setState(() {
//        _videoPath1 = rep.data["data"];
//      });
//    }).catchError((e) {
//      showToast(context, e.message);
//    });
//  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(title: '发布课件'),
      body: MainInputBody(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 14),
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.4, color: ThemeColors.color999),
                ),
              ),
              child: TextField(
                controller: _titleC,
                textAlign: TextAlign.start,
                style: TextStyle(color: ThemeColors.color666, fontSize: 14),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    icon: Text(
                      '标题',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hintText: "请输入标题(限制30字)",
                    hintStyle:
                        TextStyle(color: Color(0xff999999), fontSize: 14),
                    border: InputBorder.none),
              ),
            ),
            new Space(),
            Container(
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "业务类型",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    new InkWell(
                      child: CachedNetworkImage(
                          imageUrl:
                              "https://lanhu.oss-cn-beijing.aliyuncs.com/xd6c9ed5f7-6147-4772-94a4-ead03f7b4aa1",
                          width: 20,
                          height: 20),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                title: '新增类型',
                                hintText: '请输入新增类别名称',
                              );
                            });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 4,
                      childAspectRatio: 8 / 4),
                  children: _categoryList.map((item) {
                    CategoryModel model = item;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (model.isType == false) {
                            currentCategory = model;
                            model.isType = true;
                          } else {
                            return;
                          }
                          _categoryList.forEach((inItem) {
                            CategoryModel inModel = inItem;
                            if (inModel.name != model.name) {
                              inModel.isType = false;
                            }
                          });
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          model.name,
                          style: TextStyle(
                              fontSize: 14,
                              color:
                                  !model.isType ? Colors.grey : Colors.white),
                        ),
                        color: !model.isType
                            ? Colors.grey[300]
                            : Color(0xffFFE1B96B),
                      ),
                    );
                  }).toList(),
                ),
              ],
            )),
            new Space(),
            new HorizontalLine(
              height: 1,
              color: ThemeColors.colorDivider,
            ),
            Container(
              child: Text(
                '视频',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            //视频
            GetLoadingWidget(
              uploadingFlag: uploadingFlag,
              downloadProgress: _downloadProgress,
            ),
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
//            VideoCard(
//              _video1,
//              videoPlayerController: _videoPlayerController1,
//              onTap: () => _getVideo(),
//              clean: () {
//                setState(() => _video1 = null);
//              },
//            ),
            new FlatButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              onPressed: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    '内容',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  new CupertinoSwitch(
                    value: isShow,
                    onChanged: (v) {
                      setState(() {
                        isShow = v;
                        _contentC.text = '';
                      });
                      print('_contentC============>${_contentC.text}');
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isShow,
              child: new Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: new TextField(
                        maxLines: 5,
                        controller: _contentC,
                        style: TextStyle(
                          color: ThemeColors.color666,
                          fontSize: 13,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(30),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入内容(限制30字)',
                          hintStyle: TextStyle(
                            color: ThemeColors.color999,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColors.coloref,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    /*new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '图片:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        new InkWell(
                          onTap: _selectedImage,
                          child: new Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.add_to_photos,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: new CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  width: 60,
                                  height: 60,
                                  imageUrl:
                                      imageFileUrl != null ? imageFileUrl : '',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
            new HorizontalLine(
              height: 2,
              color: ThemeColors.colorDivider,
            ),
            new Space(),
            Row(
              children: <Widget>[
                new Text('是否收费', style: TextStyle(fontSize: 16.0)),
                new Spacer(),
                new Container(
                  child: checkCircle(value: value, onTap: _onChanged),
                ),
              ],
            ),
            new Visibility(
              visible: value,
              child: Row(
                children: <Widget>[
                  Text(
                    "收费标值",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "￥",
                    style: TextStyle(color: ThemeColors.colorRed),
                  ),
                  Container(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: ThemeColors.colorRed),
                        onChanged: (v) {
                          setState(() {
                            priceC = double.parse(v);
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0.00",
                          hintStyle: TextStyle(color: ThemeColors.colorRed),
                        ),
                      ))
                ],
              ),
            ),
            new SizedBox(height: 50),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              child: MagicBt(
                onTap: _isPublish,
                text: '发布',
                radius: 10.0,
                height: 50,
                color: Color.fromRGBO(225, 185, 107, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //是否发布
  _isPublish() {
    themeAlert(context, warmStr: '确认发布该课件？', okFunction: () => lectureAdd());
  }

  ///请求业务类别
  void getCategory() {
    systemViewModel.legalFieldList(context).then((rep) {
      setState(() => _categoryList = List.from(rep.data));
    }).catchError((e) {
      showToast(context, e.message);
    });
  }

  ///调用系统相册并展示在页面上
  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return new Container(
              height: 70,
              width: 70,
              child: Image.file(snapshot.data, fit: BoxFit.cover),
            );
          } else {
            return new Icon(
              Icons.add_to_photos,
              size: 40,
              color: Colors.grey,
            );
          }
        });
  }
}

Widget checkCircle({bool value, Function onTap}) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: value
            ? Icon(
                Icons.check_circle,
                size: 22.0,
                color: ThemeColors.colorOrange,
              )
            : Icon(
                Icons.panorama_fish_eye,
                size: 22.0,
                color: Colors.grey,
              ),
      ),
    ),
  );
}
