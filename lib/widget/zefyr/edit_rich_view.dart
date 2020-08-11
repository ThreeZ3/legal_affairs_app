import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/zefyr/images.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class EditRichView extends StatefulWidget {
  final ZefyrController contentC;
  final String hintText;
  final Callback callImg;
  final ZefyrMode mode;

  EditRichView({
    this.contentC,
    this.hintText,
    this.callImg,
    this.mode = ZefyrMode.edit,
  });

  @override
  _EditRichViewState createState() => _EditRichViewState();
}

class _EditRichViewState extends State<EditRichView> {
  final FocusNode _focusNode = FocusNode();
  StreamSubscription<NotusChange> _sub;

  bool _editing = true;

  @override
  void initState() {
    super.initState();
    Notice.addListener(JHActions.changeZe(), (v) {
      FocusScope.of(context).requestFocus(new FocusNode());
    });

    _sub = widget.contentC.document.changes.listen((change) {
      try {
        List list = change.change.toList();
        Map<String, dynamic> json =
            list[change.change.length - 1].toJson()['attributes']['embed'];
        if (json['type'] == 'image') {
          if (widget.callImg != null) widget.callImg(json['source']);
        }
      } catch (e) {
        debugPrint('change.change::${change.change}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: ThemeColors.colorDivider,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      height: winKeyHeight(context) == 0
          ? winHeight(context) - 100
          : (winHeight(context) - 90) - winKeyHeight(context),
      child: ZefyrScaffold(
        child: ZefyrField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '${widget.hintText}',
            contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          ),
          controller: widget.contentC,
          focusNode: _focusNode,
          mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
          imageDelegate: CustomImageDelegate(),
          keyboardAppearance: Brightness.light,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    Notice.removeListenerByEvent(JHActions.changeZe());
    super.dispose();
  }
}

class EditRichShow extends StatefulWidget {
  final String json;

  EditRichShow({this.json});

  @override
  _EditRichShowState createState() => _EditRichShowState();
}

class _EditRichShowState extends State<EditRichShow> {
  @override
  Widget build(BuildContext context) {
    List jsonResult = new List();
    bool canOk = false;

    try {
      jsonResult = json.decode(widget.json) as List;
      canOk = true;
    } catch (e) {}

    if (canOk) {
      return ZefyrView(
        document:
            ZefyrController(NotusDocument.fromDelta(Delta.fromJson(jsonResult)))
                .document,
        imageDelegate: CustomImageDelegate(),
      );
    } else {
      return new Text(
        '${widget.json}',
        style: TextStyle(color: Colors.grey),
      );
    }
  }
}

class EditRichShowText extends StatefulWidget {
  final String json;
  final int maxLines;
  final TextStyle style;

  EditRichShowText({
    this.json,
    this.maxLines = 2,
    this.style = const TextStyle(color: Colors.grey, fontSize: 12),
  });

  @override
  _EditRichShowTextState createState() => _EditRichShowTextState();
}

class _EditRichShowTextState extends State<EditRichShowText> {
  @override
  Widget build(BuildContext context) {
    List jsonResult = new List();
    bool canOk = false;

    try {
      jsonResult = json.decode(widget.json) as List;
      canOk = true;
    } catch (e) {}

    if (canOk) {
      return Text(
        ZefyrController(NotusDocument.fromDelta(Delta.fromJson(jsonResult)))
            .plainTextEditingValue
            .text,
        style: widget.style,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return new Text(
        '${widget.json}',
        style: widget.style,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
