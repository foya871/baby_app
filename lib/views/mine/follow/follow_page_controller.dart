import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/mine/fans_follower_model.dart';

import '../../../model/mine/topic_item_model.dart';

class FollowPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  EasyRefreshController refreshController = EasyRefreshController();
  late TabController tabController;
  List<(String, int)> tabs = [
    ('用户', 1),
    ('话题', 2),
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

  @override
  void onReady() {
    super.onReady();
  }

  getHttpData({required bool isRefresh, required int tabIndex}) {
    if (isRefresh) {
      pageIndex[tabIndex] = 1;
      pagingControllers[tabIndex]!.refresh();
    }
    if (tabIndex == 1) {
      Api.getFansFollowers(isFans: false, page: pageIndex[tabIndex]!)
          .then((response) {
        if (response.isNotEmpty) {
          pagingControllers[tabIndex]!
              .appendPage(response, pageIndex[tabIndex]!);
          pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
        } else {
          pagingControllers[tabIndex]!.appendLastPage(response);
        }
      });
    } else {
      Api.getSubscribeTopicList(page: pageIndex[tabIndex]!).then((response) {
        if (response.isNotEmpty) {
          pagingControllers[tabIndex]!
              .appendPage(response, pageIndex[tabIndex]!);
          pageIndex[tabIndex] = pageIndex[tabIndex]! + 1;
        } else {
          pagingControllers[tabIndex]!.appendLastPage(response);
        }
      });
    }
  }

  toggleFollow(FansFollowerModel item) {
    LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          await Api.followOrUnfollow(
                  toUserId: item.userId ?? 0,
                  isAttention: item.attention ?? false)
              .then((value) {
            if (value) {
              item.attention = !(item.attention ?? false);
              update();
            }
          });
        });
  }

  toggleSubscribe(TopicSubscribeItemModel item) {
    LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          await Api.subscribe(id: item.id ?? "", isSubscribe: item.isSubscribe)
              .then((value) {
            if (value) {
              item.isSubscribe = !item.isSubscribe;
              update();
            }
          });
        });
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }
}
