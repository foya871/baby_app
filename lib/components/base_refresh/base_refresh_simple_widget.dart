import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/components/base_refresh/base_refresh_style.dart';
import 'package:flutter/material.dart';

import 'base_refresh_simple_controller.dart';

/// see: [BaseRefreshSimpleController]

class BaseRefreshSimpleWidget extends EasyRefresh {
  BaseRefreshSimpleWidget(
    BaseRefreshSimpleController simpleController, {
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
          onRefresh: () =>
              simpleController.onRefresh(enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? simpleController.onLoad : null,
          controller: simpleController.refreshController,
          scrollController:
              enableScorllController ? simpleController.scrollController : null,
          triggerAxis: Axis.vertical,
        );

  BaseRefreshSimpleWidget.builder(
    BaseRefreshSimpleController simpleController, {
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
          onRefresh: () =>
              simpleController.onRefresh(enableCheckNoMoreOnRefresh),
          onLoad: enableLoad ? simpleController.onLoad : null,
          controller: simpleController.refreshController,
          scrollController:
              enableScorllController ? simpleController.scrollController : null,
          triggerAxis: Axis.vertical,
        );
}
