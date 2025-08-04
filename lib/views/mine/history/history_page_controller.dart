/*
 * @Author: wdz
 * @Date: 2025-05-15 11:23:36
 * @LastEditTime: 2025-06-28 09:18:32
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/mine/history/history_page_controller.dart
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';

class HistoryPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  EasyRefreshController refreshController = EasyRefreshController();
  late TabController tabController;
  List<(String, int)> tabs = [
    ('长视频', 1),
    ('短视频', 2),
    ('帖子', 3),
    ('漫画', 4),
    ('写真', 5),
    ('小说', 6),
  ];
  final Map<int, PagingController<int, dynamic>> pagingControllers = {
    1: PagingController(firstPageKey: 1),
    2: PagingController(firstPageKey: 1),
    3: PagingController(firstPageKey: 1),
    4: PagingController(firstPageKey: 1),
    5: PagingController(firstPageKey: 1),
    6: PagingController(firstPageKey: 1),
  };
  Map<int, int> pageIndex = {
    1: 1,
    2: 1,
    3: 1,
    4: 1,
    5: 1,
    6: 1,
  };

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getHttpData({required bool isRefresh, required int tabIndex}) {
    if (isRefresh) {
      pageIndex[tabIndex] = 1;
      pagingControllers[tabIndex]!.refresh();
    }

    Api.getMyIntegrates(type: 2, sign: tabIndex, page: pageIndex[tabIndex]!)
        .then((response) {
      if (response != null) {
        if (tabIndex == 1 || tabIndex == 2) {
          if (response.videoList != null && response.videoList!.isNotEmpty) {
            pagingControllers[tabIndex]!
                .appendPage(response.videoList ?? [], pageIndex[tabIndex]!);
            pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
          } else {
            pagingControllers[tabIndex]!.appendLastPage([]);
          }
        }
        if (tabIndex == 3) {
          if (response.dynamicList != null &&
              response.dynamicList!.isNotEmpty) {
            pagingControllers[tabIndex]!
                .appendPage(response.dynamicList ?? [], pageIndex[tabIndex]!);
            pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
          } else {
            pagingControllers[tabIndex]!.appendLastPage([]);
          }
        }
      } else {
        pagingControllers[tabIndex]!.appendLastPage([]);
      }
    });
  }
}
