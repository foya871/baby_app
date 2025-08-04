import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../utils/extension.dart';

class NoDataSliverGrid extends StatelessWidget {
  final bool noData;
  final int itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final SliverGridDelegate? gridDelegate;
  final Widget? emptyWidget;
  // count
  final int? crossAxisCount;
  // extent
  final double? maxCrossAxisExtent;
  //
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? childAspectRatio;
  final List<Widget>? children;

  const NoDataSliverGrid.builder({
    super.key,
    required this.itemCount,
    required this.gridDelegate,
    required this.itemBuilder,
    this.emptyWidget,
    this.noData = true,
  })  : assert(gridDelegate != null, 'gridDelegate not be null'),
        assert(itemBuilder != null, 'itemBuilder not be null'),
        crossAxisCount = null,
        maxCrossAxisExtent = null,
        mainAxisSpacing = null,
        crossAxisSpacing = null,
        childAspectRatio = null,
        children = null;

  NoDataSliverGrid.count({
    super.key,
    required this.crossAxisCount,
    required this.children,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.emptyWidget,
    this.noData = true,
  })  : assert(crossAxisCount != null, 'crossAxisCount not be null'),
        assert(children != null, 'children not be null'),
        assert(mainAxisSpacing != null, 'mainAxisSpacing not be null'),
        assert(crossAxisSpacing != null, 'crossAxisSpacing not be null'),
        assert(childAspectRatio != null, 'childAspectRatio not be null'),
        maxCrossAxisExtent = null,
        itemCount = children!.length,
        itemBuilder = null,
        gridDelegate = null;

  NoDataSliverGrid.extent({
    super.key,
    required this.maxCrossAxisExtent,
    required this.children,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.emptyWidget,
    this.noData = true,
  })  : assert(maxCrossAxisExtent != null, 'maxCrossAxisExtent not be null'),
        assert(children != null, 'children not be null'),
        assert(mainAxisSpacing != null, 'mainAxisSpacing not be null'),
        assert(crossAxisSpacing != null, 'crossAxisSpacing not be null'),
        assert(childAspectRatio != null, 'childAspectRatio not be null'),
        crossAxisCount = null,
        itemCount = children!.length,
        itemBuilder = null,
        gridDelegate = null;

  @override
  Widget build(BuildContext context) {
    if (noData && itemCount == 0) {
      return emptyWidget?.sliver ?? const NoData.empty().sliver;
    }
    if (children == null) {
      return SliverGrid.builder(
        gridDelegate: gridDelegate!,
        itemBuilder: itemBuilder!,
        itemCount: itemCount,
      );
    }
    if (crossAxisCount != null) {
      return SliverGrid.count(
        crossAxisCount: crossAxisCount!,
        mainAxisSpacing: mainAxisSpacing!,
        crossAxisSpacing: crossAxisSpacing!,
        childAspectRatio: childAspectRatio!,
        children: children!,
      );
    }
    return SliverGrid.extent(
      maxCrossAxisExtent: maxCrossAxisExtent!,
      mainAxisSpacing: mainAxisSpacing!,
      crossAxisSpacing: crossAxisSpacing!,
      childAspectRatio: childAspectRatio!,
      children: children!,
    );
  }
}
