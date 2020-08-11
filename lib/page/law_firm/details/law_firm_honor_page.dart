import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/widget/law_firm/editor.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-07
///
/// 律所详情(律师)-详细资料-社会荣誉
///

class LawFirmHonorPage extends StatefulWidget {
  @override
  _LawFirmHonorPageState createState() => _LawFirmHonorPageState();
}

class _LawFirmHonorPageState extends State<LawFirmHonorPage> {
  TextEditingController textOfficialLetter = TextEditingController();
  File localImages = new File('');

  @override
  Widget build(BuildContext context) {
    return EditorPage(
      text: '社会荣誉',
      hintText: '文字内容',
      textController: textOfficialLetter,
      picOnTap: () => _openGallery(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.start,
          children: [
            ImagePicked(
              images: localImages,
//              index: index,
              valueChanged: (index) {
//                setState(() {
//                  localImages.removeAt(index);
//                });
              },
            ),
          ],
        ),
      ),
    );
  }

  _openGallery() async {
    File image = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      localImages = image;
    });
  }
}
