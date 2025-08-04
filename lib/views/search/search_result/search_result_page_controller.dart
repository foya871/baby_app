import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/http/api/api.dart';

import '../../../model/community/community_model.dart' show CommunityModel;
import '../../../model/video_base_model.dart' show VideoBaseModel;
import '../../../services/storage_service.dart';

class SearchResultPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  EasyRefreshController refreshController = EasyRefreshController();
  final service = Get.find<StorageService>();
  String keyWord = "";
  late TabController tabController;

  List<(String, int)> tabs = [
    ('视频', 1),
    ('帖子', 2),
  ];
  final Map<int, PagingController<int, dynamic>> pagingControllers = {
    1: PagingController(firstPageKey: 1),
    2: PagingController(firstPageKey: 1),
    // 3: PagingController(firstPageKey: 1),
    // 4: PagingController(firstPageKey: 1),
    // 5: PagingController(firstPageKey: 1),
    // 6: PagingController(firstPageKey: 1),
  };
  Map<int, int> pageIndex = {
    1: 1,
    2: 1,
    // 3: 1,
    // 4: 1,
    // 5: 1,
    // 6: 1,
  };

  @override
  void onInit() {
    keyWord = Get.arguments['keyWord'];
    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging) return;
        // getHttpData(isRefresh: true, tabIndex: tabController.index);
      });
    super.onInit();
  }

  List<VideoBaseModel> list1 = [];

  // List<VideoBaseModel> list2 = [];
  List<CommunityModel> list3 = [];

  getHttpData({required bool isRefresh, required int tabIndex}) {
    if (isRefresh) {
      pageIndex[tabIndex] = 1;
      pagingControllers[tabIndex]!.refresh();
    }
    Api.fetchSearchKeyWord(
            page: pageIndex[tabIndex] ?? 1,
            pageSize: 30,
            searchType: tabIndex,
            searchWord: keyWord)
        .then((response) {
      Get.log("===========>返回数据 ${response}");

      list1 = ((response["videoList"] ?? []) as List)
          .map((e) => VideoBaseModel.fromJson(e))
          .toList();
      list3 = ((response["dynamicList"] ?? []) as List)
          .map((e) => CommunityModel.fromJson(e))
          .toList();

      if (tabIndex == 1) {
        if (list1.isNotEmpty) {
          pagingControllers[tabIndex]!.appendPage(list1, pageIndex[tabIndex]!);
          pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
        } else {
          pagingControllers[tabIndex]!.appendLastPage([]);
        }
      }
      if (tabIndex == 2) {
        if (list3.isNotEmpty) {
          pagingControllers[tabIndex]!
              .appendPage(list3 ?? [], pageIndex[tabIndex]!);
          pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
        } else {
          pagingControllers[tabIndex]!.appendLastPage([]);
        }
      }
    });
  }
}
