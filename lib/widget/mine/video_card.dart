import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final File video;
  final GestureTapCallback onTap;
  final GestureTapCallback clean;
  final VideoPlayerController videoPlayerController;
  final double height;

  VideoCard(
    this.video, {
    this.onTap,
    this.clean,
    this.videoPlayerController,
    this.height,
  });

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return widget.video == null
        ? GestureDetector(
      onTap: widget.onTap,
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
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      child: new Stack(
        children: <Widget>[
          Chewie(
            controller: ChewieController(
                videoPlayerController: widget.videoPlayerController,
                aspectRatio:
                widget.videoPlayerController.value.aspectRatio),
          ),
          new Positioned(
            right: 20,
            top: 20,
            child: new GestureDetector(
              child: new CircleAvatar(
                radius: 15,
                child: new Icon(CupertinoIcons.delete),
              ),
              onTap: widget.clean,
            ),
          ),
        ],
      ),
    );
  }
}
