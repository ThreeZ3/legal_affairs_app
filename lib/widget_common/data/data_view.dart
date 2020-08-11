import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/http/refresh_view.dart';
import 'package:jh_legal_affairs/util/tools.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-18
class DataView extends StatelessWidget {
  final bool isLoadingOk;
  final List data;
  final String label;
  final Widget child;
  final Widget noDataView;
  final OnRefreshCallback onRefresh;
  final OnLoadCallback onLoad;
  final Color color;

  DataView({
    @required this.isLoadingOk,
    @required this.data,
    @required this.child,
    this.onRefresh,
    this.onLoad,
    this.label = '暂无数据',
    this.noDataView,
    this.color,
  });

  Widget get childBuild {
    if (!isLoadingOk) {
      return new LoadingView();
    } else if (!listNoEmpty(data)) {
      if (noDataView != null) return noDataView;
      return new NoDataView(label: label, onRefresh: onRefresh);
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: onRefresh != null || onLoad != null
          ? new RefreshView(
              child: childBuild,
              footer: ClassicalFooter(extent: 0, float: true),
              header: MaterialHeader(
                valueColor: AlwaysStoppedAnimation(themeColor),
              ),
              onRefresh: onRefresh,
              onLoad: onLoad,
            )
          : childBuild,
    );
  }
}
