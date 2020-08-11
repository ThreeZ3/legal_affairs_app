import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<int>> compressFile(File file) async {
  try {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 200,
      minHeight: 300,
      quality: 95,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  } catch (e) {
    print('e => ${e.toString()}');
    return null;
  }
}

launchURL(context, [url = 'http://exmaple.com/']) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showToast(context, 'Could not launch $url');
  }
}

launchTel(context, tel) async {
  String url = 'tel$tel';
  if (await canLaunch(url)) {
    launch(url);
  } else {
    Clipboard.setData(ClipboardData(text: url));
    showToast(context, "复制成功");
  }
}
