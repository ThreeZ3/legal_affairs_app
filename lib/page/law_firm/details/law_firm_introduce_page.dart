import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/widget/law_firm/editor.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-23
///
/// 律所详情(律师)-律所简介设置
/// 
class LawFirmIntroducePage extends StatefulWidget {
  @override
  _LawFirmIntroducePageState createState() => _LawFirmIntroducePageState();
}

class _LawFirmIntroducePageState extends State<LawFirmIntroducePage> {
  TextEditingController introduceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return EditorPage(text: '律所简介',hintText: '律所简介',textController: introduceController,);
  }
}