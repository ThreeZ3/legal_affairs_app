import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

showToast(BuildContext context, String msg, {int duration = 2, int gravity}) {
  Toast.show(msg ?? '未知错误', context, duration: duration, gravity: gravity);
}
