library jh_legal_affairs;

import 'package:amap_location/amap_location.dart';
import 'package:jh_legal_affairs/api/ad/ad_model.dart';
import 'package:jh_legal_affairs/widget_common/view/show_toast.dart';
export 'package:jh_legal_affairs/common/check.dart';
export 'package:jh_legal_affairs/data/data.dart';
export 'package:jh_legal_affairs/http/base_request.dart';
export 'package:jh_legal_affairs/http/http.dart';
export 'package:jh_legal_affairs/widget_common/data/loading_view.dart';
export 'package:jh_legal_affairs/widget_common/data/no_data_view.dart';
export 'package:jh_legal_affairs/common/win_media.dart';
export 'package:jh_legal_affairs/common/ui.dart';
export 'package:jh_legal_affairs/common/global_variable.dart';
export 'package:jh_legal_affairs/widget_common/bar/navigation_bar.dart';
export 'package:jh_legal_affairs/widget_common/view/show_toast.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:jh_legal_affairs/widget_common/button/small_button.dart';
export 'package:jh_legal_affairs/widget_common/data/data_view.dart';
export 'package:jh_legal_affairs/widget_common/dialog/confirm_alert.dart';
export 'package:jh_legal_affairs/widget_common/tile/label_tile.dart';
export 'package:jh_legal_affairs/widget_common/view/field_view.dart';
export 'package:jh_legal_affairs/widget_common/view/main_input.dart';
export 'package:jh_legal_affairs/widget_common/theme_colors.dart';
export 'package:jh_legal_affairs/http/base_view_model.dart';
export 'package:jh_legal_affairs/widget_common/dialog/theme_dialog.dart';
export 'package:jh_legal_affairs/common/inputFor.dart';
export 'package:jh_legal_affairs/page/register/common/register_button_widget.dart';
export 'package:jh_legal_affairs/common/date.dart';
export 'package:nav_router/nav_router.dart';
export 'package:jh_legal_affairs/common/handle.dart';
export 'package:jh_legal_affairs/widget/zefyr/edit_rich_view.dart';

/// 回调
typedef Callback(data);
typedef VoidCallbackConfirm = void Function(bool isOk);

/// 跳转到Im
void routerIm(context) async {
  showToast(context, '敬请期待');
//  routePush(JhImApp.getApp());
}

const int maxTitleLength = 30;
const int maxContentLength = 20000;
const defCover =
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592569806876&di=6ea7f1429499809743949b00fe0db68c&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd1a20cf431adcbefe30c97d9aeaf2edda3cc9f31.jpg";
AMapLocation location;

// 测试环境地址
const serviceUrl = 'http://112.74.200.88:21808';
// jun
//const serviceUrl = 'http://lijun-web.natapp1.cc';
// test 1
//const serviceUrl = 'http://192.168.0.167:21808';
// pro
//const serviceUrl = 'http://47.107.232.51:21808';

List<AdSysModel> defBanner = [
  new AdSysModel(
    contentUrl: 'assets/images/home/祝贺视频.png',
    isVideo: true,
    urls:
        'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/%E7%A5%9D%E8%B4%BA%E8%A7%86%E9%A2%91.mp4',
  ),
  new AdSysModel(
    contentUrl: 'assets/images/home/电视播放封面.png',
    isVideo: true,
    urls:
        'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/%E6%B3%95%CF%80%E7%94%B5%E8%A7%86%E6%92%AD%E6%94%BE.mp4',
  ),
  new AdSysModel(
    contentUrl: 'assets/images/home/法π动画.png',
    isVideo: true,
    urls:
        'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/%E6%B3%95%CF%80%E5%8A%A8%E7%94%BB6.2%E6%88%90%E7%89%87.mp4',
  ),
  new AdSysModel(
    contentUrl: 'assets/images/home/开场视频.png',
    isVideo: true,
    urls:
        'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/%E5%BC%80%E5%9C%BA%E8%A7%86%E9%A2%91%20-%20%E5%A4%8D%E4%BB%B6.mp4',
  ),
  new AdSysModel(
    contentUrl: 'assets/images/home/京视网.jpg',
    isVideo: true,
    urls:
        'https://netx-dev-strategymall.oss-cn-shenzhen.aliyuncs.com/legal-file/%E4%BA%AC%E8%A7%86%E7%BD%91.mp4',
  ),
];
