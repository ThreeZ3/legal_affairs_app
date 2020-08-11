import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/data/notice.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
typedef Widget StoreBuilder<T>(T item);

final _storeMap = <String, dynamic>{};

class Store<T> {
  final String _action;

  const Store(this._action);

  T get value => _storeMap[_action];

  set value(T v) {
    if (!(v is List) && !(v is Set) && !(v is Map) && v == _storeMap[_action])
      return;

    _storeMap[_action] = v;
    Notice.send('Store::$_action', v);
  }

  clear() => dispose(_action);

  notifyListeners() => Notice.send('Store::$_action', _storeMap[_action]);

  static dispose(String action) {
    for (final key in _storeMap.keys.toList(growable: false)) {
      if (key.startsWith(action)) {
        final v = _storeMap.remove(key);

        Notice.send('Store::$key', null);
        Notice.send('Store::$key::dispose', v);
      }
    }
  }
}

class CacheWidget<T> extends StatefulWidget {
  final String action;
  final StoreBuilder<T> builder;
  final data;

  CacheWidget(this.action, this.builder, {Key key, this.data})
      : super(key: key);

  @override
  _CacheWidgetState createState() => new _CacheWidgetState<T>();
}

class _CacheWidgetState<T> extends State<CacheWidget<T>> with BusStateMixin {
  T item;

  void init() {
    final action = widget.action;

    item = _storeMap[action] as T;

    bus('Store::$action', onData);
  }

  @override
  void initState() {
    super.initState();
    init();
    widget.builder(item);
  }

  @override
  void didUpdateWidget(CacheWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    busDel(onData);

    init();
  }

  void onData(_) {
    if (mounted) Timer.run(() => setState(() => item = _));
  }

  @override
  Widget build(BuildContext context) => widget.builder(item);
}

storeString(String k, v) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(k, v);
}

storeClean() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

storeBool(String k, v) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(k, v);
}

Future<String> getStoreValue(String k) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(k);
}

Future<bool> getStoreBool(String k) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(k);
}
