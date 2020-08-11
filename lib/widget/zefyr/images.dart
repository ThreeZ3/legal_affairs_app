// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/system/system_view_model.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:zefyr/zefyr.dart';

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    Notice.send(JHActions.changeZe(), false);
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    ResponseModel rep = await systemViewModel.uploadFile(null, file: file);
    return rep.data['data'].toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    if (key.startsWith('asset://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else if (key.startsWith('file://')) {
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image);
    } else {
      return new InkWell(
        child: new Hero(
          tag: "avatar$key",
          child: CachedNetworkImage(
            imageUrl: key,
            width: winWidth(context),
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
            return new FadeTransition(
              opacity: animation,
              child: HeroAnimationRouteB(key),
            );
          }));
        },
      );
    }
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  final String img;
  final List<dynamic> photos;
  final String tagAdd;

  HeroAnimationRouteB(this.img, [this.tagAdd = '', this.photos]);

  HeroAnimationRouteB.builder(this.photos, [this.tagAdd, this.img]);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Scaffold(
        body: new Center(
          child: new Hero(
            tag: "avatar$img$tagAdd",
            child: new CachedNetworkImage(imageUrl: img),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
