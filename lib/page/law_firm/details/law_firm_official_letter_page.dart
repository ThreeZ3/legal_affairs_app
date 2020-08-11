import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jh_legal_affairs/widget/law_firm/editor.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-07
///
/// 律所详情(律师)-详细资料-律所公函
///

class LawFirmOfficialLetterPage extends StatefulWidget {
  @override
  _LawFirmOfficialLetterPageState createState() =>
      _LawFirmOfficialLetterPageState();
}

class _LawFirmOfficialLetterPageState extends State<LawFirmOfficialLetterPage> {
  TextEditingController textOfficialLetter = TextEditingController();
  File localImages = new File('');

  @override
  Widget build(BuildContext context) {
    return EditorPage(
      text: '律所公函',
      hintText: '公函内容',
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
