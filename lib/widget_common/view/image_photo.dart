import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:flutter/rendering.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePhoto extends StatelessWidget {
  final ImageProvider imageProvider;
  final bool isPop;

  ImagePhoto(this.imageProvider, [this.isPop = true]);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new PhotoView(
          imageProvider: imageProvider, maxScale: 3.0, minScale: 0.15),
      onTap: () {
        if (isPop) Navigator.of(context).pop();
      },
    );
  }
}

class ImageModel {
  String img;
  String value;
  String title;
  int index;
  String id;
}

class PhotoPage extends StatefulWidget {
  final List pics;
  final int index;

  PhotoPage(this.pics, this.index);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() => currentIndex = widget.index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        children: <Widget>[
          new InkWell(
            child: new PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                ImageModel model = widget.pics[index];
                return new PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(model.img),
                  initialScale: PhotoViewComputedScale.contained * 0.9,
                  maxScale: 3.0,
                  minScale: 0.1,
                );
              },
              itemCount: widget.pics.length,
              pageController: new PageController(initialPage: widget.index),
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          new Positioned(
            bottom: 20.0,
            child: new Container(
              width: winWidth(context),
              height: 25.0,
              alignment: Alignment.center,
              child: new Wrap(
                spacing: mainSpace,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: widget.pics.map((item) {
                  ImageModel model = item;
                  return new Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0)),
                      color: item.index == currentIndex
                          ? themeColor
                          : Color(0xffDCDCDC),
                    ),
                    height: model.index == currentIndex ? 5.0 : 8.0,
                    width: model.index == currentIndex ? 20.0 : 8.0,
                  );
                }).toList(growable: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
