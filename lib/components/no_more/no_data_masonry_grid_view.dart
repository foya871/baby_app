import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoDataMasonryGridView extends MasonryGridView {
  final bool noData;
  final int itemCount;
  final Widget? emptyWidget;
  NoDataMasonryGridView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required super.gridDelegate,
    required super.itemBuilder,
    required this.itemCount,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    super.cacheExtent,
    super.restorationId,
    super.clipBehavior,
    this.noData = true,
    this.emptyWidget,
  }) : super.builder(itemCount: itemCount);

  NoDataMasonryGridView.count({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required super.crossAxisCount,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    required super.itemBuilder,
    required this.itemCount,
    super.cacheExtent,
    super.restorationId,
    super.clipBehavior,
    this.noData = true,
    this.emptyWidget,
  }) : super.count(itemCount: itemCount);

  NoDataMasonryGridView.extent({
    super.key,
    super.scrollDirection,
    super.reverse = false,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap = false,
    super.padding,
    required super.maxCrossAxisExtent,
    super.mainAxisSpacing = 0.0,
    super.crossAxisSpacing = 0.0,
    required super.itemBuilder,
    required this.itemCount,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.semanticChildCount,
    super.restorationId,
    super.clipBehavior,
    this.noData = true,
    this.emptyWidget,
  }) : super.extent(itemCount: itemCount);

  @override
  Widget build(BuildContext context) {
    if (noData && itemCount == 0) {
      return ListView(
        controller: controller,
        physics: physics,
        children: [emptyWidget ?? const NoData.empty()],
      );
    }
    return super.build(context);
  }
}
