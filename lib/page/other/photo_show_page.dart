import 'dart:io';

import 'package:flutter/material.dart';

import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget_common/view/image_photo.dart';

class PhotoShowPage extends StatefulWidget {
  final File file;
  final VoidCallback onPressed;

  PhotoShowPage(
    this.file, {
    @required this.onPressed,
  });

  @override
  _PhotoShowPageState createState() => _PhotoShowPageState();
}

class _PhotoShowPageState extends State<PhotoShowPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NavigationBar(
        title: '图片预览',
        rightDMActions: <Widget>[
          new SizedBox(
            width: 60,
            child: new FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 5),
              onPressed: () {
                pop();
                widget.onPressed();
              },
              child: new Text(
                '确定',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: new ImagePhoto(FileImage(widget.file), false),
    );
  }
}
