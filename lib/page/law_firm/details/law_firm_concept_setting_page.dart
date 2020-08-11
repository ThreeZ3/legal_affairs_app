import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/widget/law_firm/editor.dart';
/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-04-28
///
/// 律所详情(律师)-律所理念设置
class LawFirmConceptSettingPage extends StatefulWidget {
  @override
  _LawFirmConceptSettingPageState createState() => _LawFirmConceptSettingPageState();
}

class _LawFirmConceptSettingPageState extends State<LawFirmConceptSettingPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EditorPage(
      text: '律所理念',
      hintText: '律所理念',
      textController: textController,
      
    );
  }
}