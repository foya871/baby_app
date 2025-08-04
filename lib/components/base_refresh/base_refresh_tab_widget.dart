import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/components/base_refresh/base_refresh_style.dart';
import 'package:baby_app/components/base_refresh/base_refresh_tab_key.dart';
import 'package:flutter/material.dart';

import 'base_refresh_tab_controller.dart';

///
/// see: [BaseRefreshTabController]
/// see: [BaseRefreshDefaultTabController]
///

class BaseRefreshTabWidget extends EasyRefresh {
  BaseRefreshTabWidget(
    BaseRefreshDefaultTabController baseController, {
    super.key,
    super.refreshOnStart = true,
    bool enableLoad = true,
    bool enableCheckNoMoreOnRefresh = false, // 是否在refresh的时候使用no_more
    bool enableScorllController = false,
    bool useRefreshLocator = false,
    Color? headerFootColor,
    required BaseRefreshTabKey tabKey,
    required super.child,
  }) : super(
          header: useRefreshLocator
              ? BaseRefreshStyle.locatorHeaderBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                )
              : BaseRefreshStyle.defaultHeaderBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                ),
          footer: useRefreshLocator
              ? BaseRefreshStyle.locatorFooterBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                )
              : BaseRefreshStyle.defaultFooterBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                ),
          onRefresh: () =>
              baseController.onRefresh(tabKey, enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? () => baseController.onLoad(tabKey) : null,
          controller: baseController.getRefreshController(tabKey),
          scrollController: enableScorllController
              ? baseController.getScrollController(tabKey)
              : null,
          triggerAxis: Axis.vertical,
        );

  BaseRefreshTabWidget.builder(
    BaseRefreshDefaultTabController baseController, {
    super.key,
    super.refreshOnStart = true,
    bool enableLoad = true,
    bool enableCheckNoMoreOnRefresh = false, // 是否在refresh的时候使用no_more
    bool enableScorllController = false,
    bool useRefreshLocator = false,
    Color? headerFootColor,
    required BaseRefreshTabKey tabKey,
    required super.childBuilder,
  }) : super.builder(
          header: useRefreshLocator
              ? BaseRefreshStyle.locatorHeaderBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                )
              : BaseRefreshStyle.defaultHeaderBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                ),
          footer: useRefreshLocator
              ? BaseRefreshStyle.locatorFooterBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                )
              : BaseRefreshStyle.defaultFooterBuilder(
                  iconColor: headerFootColor,
                  textColor: headerFootColor,
                ),
          onRefresh: () =>
              baseController.onRefresh(tabKey, enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? () => baseController.onLoad(tabKey) : null,
          controller: baseController.getRefreshController(tabKey),
          scrollController: enableScorllController
              ? baseController.getScrollController(tabKey)
              : null,
          triggerAxis: Axis.vertical,
        );
}
