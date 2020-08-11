import 'package:flutter/services.dart';

List<TextInputFormatter> numFormatter = [
  WhitelistingTextInputFormatter(new RegExp(r'[0-9]'))
];

List<TextInputFormatter> numAddFormatter = [
  WhitelistingTextInputFormatter(new RegExp(r'[0-9.]'))
];

List<TextInputFormatter> testFormatter = [
  new WhitelistingTextInputFormatter(RegExp(r'[0-9¬]'))
];

List<TextInputFormatter> emailFormatter = [
  new WhitelistingTextInputFormatter(RegExp(
      r'[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]'))
];

/// 价格
List<TextInputFormatter> priceFormatter = [
  new WhitelistingTextInputFormatter(RegExp(r'^\d*\.{0,2}\d{0,2}'))
];

///不允许中文
List<TextInputFormatter> notWordFormatter = [
  BlacklistingTextInputFormatter(new RegExp(r"[^\x00-\xff]"))
];
