import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';

class FavoritesPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  EasyRefreshController refreshController = EasyRefreshController();
  late TabController tabController;
  List<(String, int)> tabs = [
    ('视频', 1),
    ('帖子', 2),
  ];
  final Map<int, PagingController<int, dynamic>> pagingControllers = {
    1: PagingController(firstPageKey: 1),
    2: PagingController(firstPageKey: 1),
  };
  Map<int, int> pageIndex = {
    1: 1,
    2: 1,
  };

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  getHttpData({required bool isRefresh, required int tabIndex}) {
    if (isRefresh) {
      pageIndex[tabIndex] = 1;
      pagingControllers[tabIndex]!.refresh();
    }
    if (tabIndex == 1) {
      Api.fetchFavOrBuyVideoList(pageSize: 20, page: pageIndex[tabIndex]!)
          .then((response) {
        if (response != null) {
          if (response.isNotEmpty) {
            pagingControllers[tabIndex]!.appendPage(response, pageIndex[tabIndex]!);
            pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
          } else {
            pagingControllers[tabIndex]!.appendLastPage([]);
          }
        } else {
          pagingControllers[tabIndex]!.appendLastPage([]);
        }
      });
    } else {
      Api.fetchFavOrBuyCommunityList(pageSize: 20, page: pageIndex[tabIndex]!)
          .then((response) {
        if (response != null) {
          if (response.isNotEmpty) {
            pagingControllers[tabIndex]!.appendPage(response, pageIndex[tabIndex]!);
            pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
          } else {
            pagingControllers[tabIndex]!.appendLastPage([]);
          }
        } else {
          pagingControllers[tabIndex]!.appendLastPage([]);
        }
      });

    }
  }
}
