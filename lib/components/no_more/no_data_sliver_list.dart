import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';

class NoDataSliverList extends SliverList {
  final bool noData;
  NoDataSliverList.builder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    Widget? emptyWidget,
    this.noData = true,
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

  NoDataSliverList.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    Widget? emptyWidget,
    this.noData = true,
  }) : super.separated(
          itemCount: noData ? (itemCount == 0 ? 1 : itemCount) : itemCount,
          itemBuilder: (ctx, index) {
            if (noData && itemCount == 0) {
              return emptyWidget ?? const NoData.empty();
            } else {
              return itemBuilder(ctx, index);
            }
          },
          separatorBuilder: separatorBuilder,
        );
}
