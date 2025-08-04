import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';

class NoDataListView extends ListView {
  NoDataListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.itemExtent,
    super.itemExtentBuilder,
    super.prototypeItem,
    required NullableIndexedWidgetBuilder itemBuilder,
    super.findChildIndexCallback,
    required int itemCount,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
    Widget? emptyWidget,
    bool noData = true,
  }) : super.builder(
          itemCount: noData ? (itemCount == 0 ? 1 : itemCount) : itemCount,
          itemBuilder: (ctx, index) {
            if (noData && itemCount == 0) {
              return emptyWidget ?? const NoData.empty();
            } else {
              return itemBuilder(ctx, index);
            }
          },
        );

  NoDataListView.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required NullableIndexedWidgetBuilder itemBuilder,
    super.findChildIndexCallback,
    required super.separatorBuilder,
    required int itemCount,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
    Widget? emptyWidget,
    bool noData = true,
  }) : super.separated(
          itemCount: noData ? (itemCount == 0 ? 1 : itemCount) : itemCount,
          itemBuilder: (ctx, index) {
            if (noData && itemCount == 0) {
              return emptyWidget ?? const NoData.empty();
            } else {
              return itemBuilder(ctx, index);
            }
          },
        );
}
