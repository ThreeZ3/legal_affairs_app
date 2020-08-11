import 'package:flutter/material.dart';

class PageMini {
  ScrollController pageScrollController = new ScrollController();
  bool isPageLoading = false;

  initPage() {
    if(pageScrollController != null){
      pageScrollController.addListener(() {
        if (pageScrollController.position.pixels >=
            pageScrollController.position.maxScrollExtent - 100 && !isPageLoading) {
          isPageLoading = true;
          loadMoreData();
        }
        if (pageScrollController.position.pixels ==
            pageScrollController.position.minScrollExtent && !isPageLoading) {
          isPageLoading = true;
          refreshData();
        }
      });
    }
  }


  @protected
  refreshData() {}

  @protected
  loadMoreData() {}
}