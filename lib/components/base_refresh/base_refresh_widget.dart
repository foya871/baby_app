import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'base_refresh_controller.dart';

/// see: [BaseRefreshController]

@Deprecated('使用BaseRefreshSimpleWidget+BaseRefreshSimpleController')
class BaseRefreshWidget extends StatelessWidget {
  final BaseRefreshController baseController;
  final bool refreshOnStart;
  final bool enableLoad;
  final Widget child;
  final ScrollController? scrollController;
  const BaseRefreshWidget(
    this.baseController, {
    super.key,
    this.refreshOnStart = true,
    this.enableLoad = true,
    required this.child,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: baseController.refreshController,
      onRefresh: baseController.onRefresh,
      onLoad: enableLoad ? baseController.onLoad : null,
      triggerAxis: Axis.vertical,
      refreshOnStart: refreshOnStart,
      scrollController: scrollController,
      child: child,
    );
  }
}
