import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';

class NoDataGridView extends GridView {
  final bool noData;
  final int itemCount;
  final Widget? emptyWidget;
  NoDataGridView.builder({
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
    super.findChildIndexCallback,
    required this.itemCount,
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
    this.emptyWidget,
    this.noData = true,
  }) : super.builder(itemCount: itemCount);

  NoDataGridView.count({
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
    super.childAspectRatio,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    super.children,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
    this.emptyWidget,
    this.noData = true,
  })  : itemCount = children.length,
        super.count();

  NoDataGridView.extent({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required super.maxCrossAxisExtent,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    super.childAspectRatio,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    super.children,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
    this.emptyWidget,
    this.noData = true,
  })  : itemCount = children.length,
        super.extent();

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
