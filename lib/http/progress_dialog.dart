import 'dart:async';

import 'package:flutter/material.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
_ProgressOverlayState _state;

class ProgressOverlay extends StatefulWidget {
  ProgressOverlay();

  static show({hud = '加载中…'}) => _state.show(hud: hud);

  static hidden() => _state.hidden();

  @override
  State<StatefulWidget> createState() {
    _state = _ProgressOverlayState();

    return _state;
  }
}

class _ProgressOverlayState extends State<ProgressOverlay> {
  var offstage = true;

  String _hud = '';

  show({hud}) {
    offstage = false;
    _hud = hud;
    _doRefresh();
  }

  hidden() {
    offstage = true;

    _doRefresh();
  }

  _doRefresh() {
    Timer.run(() {
      if (mounted) setState(() {});
    });
  }

  Widget progress;

  @override
  void initState() {
    super.initState();

    Widget child = Text('$_hud', style: TextStyle(fontSize: 16.0));

    child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
//        Spacing.w12 * 2,
        child,
      ],
    );

    child = ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200.0, height: 64.0),
      child: child,
    );

    child = Card(child: child);

    progress = AbsorbPointer(child: Center(child: child));
  }

  @override
  Widget build(BuildContext context) => offstage ? const Center() : progress;
}
