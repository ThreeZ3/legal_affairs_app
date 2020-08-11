import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/api/lawyer_info/lawyer_info_view_model.dart';

import 'package:jh_legal_affairs/widget/law_firm/law_firm_url.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

class LawyerPhoto extends StatefulWidget {
  @override
  _LawyerPhotoState createState() => _LawyerPhotoState();
}

class _LawyerPhotoState extends State<LawyerPhoto> {
  File selects = new File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff333333),
        elevation: 0,
        leading: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Image.asset(
              ARROWPIC,
              width: 22.38,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          '律师照片',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Image.asset(
                GoodSelectPic,
                width: 22.38,
              ),
              onPressed: () {
                print('已点击提交');
                lawyerAddPhoto();
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: [
                  ImageList(
                    images: selects,
//                    index: index,
                    valueChanged: (index) {
//                      setState(() {
//                        selects.removeAt(index);
//                      });
                    },
                  ),
                ],
              )),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30),
              child: InkWell(
                  onTap: _openGallery,
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Color.fromRGBO(242, 242, 242, 1),
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Color.fromRGBO(183, 183, 183, 1),
                    ),
                  ))),
        ],
      ),
    );
  }

  _openGallery() async {
    File image = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      selects = image;
    });
  }

  void lawyerAddPhoto() {
    LawyerInFoViewModel()
        .addLawyerPhoto(context,
            title: 'asdasdas',
            lawId: '745f7825eed6856470fd08805663ef34',
            value: '$selects')
        .then((rep) {
      print(rep);
    }).catchError((e) {
      print(e);
    });
  }
}

class ImageList extends StatelessWidget {
  final File images;
  final int index;
  final ValueChanged<int> valueChanged;

  ImageList({this.images, this.index, this.valueChanged});

  void _handleCancel() {
    valueChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.file(
              images,
              width: 80,
              height: 80,
            ),
          )),
        ),
        Positioned(
          top: 30,
          left: 90,
          child: GestureDetector(
            onTap: _handleCancel,
            child: Container(
              child: Image.asset("assets/images/law_firm/minus.png"),
            ),
          ),
        )
      ],
    );
  }
}
