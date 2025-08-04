import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/components/base_refresh/base_refresh_style.dart';
import 'package:flutter/material.dart';

import 'base_refresh_share_tab_controller.dart';

///
/// see: [BaseRefreshShareTabController]
///
class BaseRefreshShareTabWidget extends EasyRefresh {
  BaseRefreshShareTabWidget(
    BaseRefreshShareTabController baseController, {
    super.key,
    super.refreshOnStart = true,
    bool enableLoad = true,
    bool enableCheckNoMoreOnRefresh = false, // 是否在refresh的时候使用no_more
    bool enableScorllController = false,
    bool useRefreshLocator = false,
    required super.child,
  }) : super(
          header: useRefreshLocator
              ? BaseRefreshStyle.locatorHeaderBuilder()
              : null,
          footer: useRefreshLocator
              ? BaseRefreshStyle.locatorFooterBuilder()
              : null,
          onRefresh: () => baseController.onRefresh(enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? baseController.onLoad : null,
          controller: baseController.refreshController,
          scrollController:
              enableScorllController ? baseController.scrollController : null,
          triggerAxis: Axis.vertical,
        );

  BaseRefreshShareTabWidget.builder(
    BaseRefreshShareTabController baseController, {
    super.key,
    super.refreshOnStart = true,
    bool enableLoad = true,
    bool enableCheckNoMoreOnRefresh = false, // 是否在refresh的时候使用no_more
    bool enableScorllController = false,
    bool useRefreshLocator = false,
    required super.childBuilder,
  }) : super.builder(
          header: useRefreshLocator
              ? BaseRefreshStyle.locatorHeaderBuilder()
              : null,
          footer: useRefreshLocator
              ? BaseRefreshStyle.locatorFooterBuilder()
              : null,
          onRefresh: () => baseController.onRefresh(enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? baseController.onLoad : null,
          controller: baseController.refreshController,
          scrollController:
              enableScorllController ? baseController.scrollController : null,
          triggerAxis: Axis.vertical,
        );
}
