import 'package:flutter/material.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/extension.dart';
import '../no_more/no_data_list_view.dart';
import '../no_more/no_data_sliver_list.dart';

/// 根据行元素自适应高度
/// 不是瀑布流，同行高度是相同的
class HeightedGridView extends StatelessWidget {
  final int itemCount;
  final Axis scrollDirection;
  final int crossAxisCount;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? rowSepratorBuilder;
  final double? columnSpacing; // 一行中间的列之间的间隙
  final bool _sliver;
  final bool noData;
  // 非sliver才需要
  final bool inScrollWidget;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  const HeightedGridView({
    super.key,
    this.scrollDirection = Axis.vertical,
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
    this.inScrollWidget = false,
    this.rowSepratorBuilder,
    this.rowMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.columnSpacing,
    this.scrollController,
    this.physics,
    this.noData = true,
  }) : _sliver = false;

  const HeightedGridView.sliver({
    super.key,
    this.scrollDirection = Axis.vertical,
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
    this.rowSepratorBuilder,
    this.rowMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.columnSpacing,
    this.noData = true,
  })  : inScrollWidget = false,
        scrollController = null,
        physics = null,
        _sliver = true;

  Tuple2<int, int> _rowInfo() {
    final remainder = itemCount % crossAxisCount;
    int rowCount = itemCount ~/ crossAxisCount;
    if (remainder != 0) {
      rowCount += 1;
    }
    return Tuple2(rowCount, remainder); // <总行数，最后一行item数>
  }

  Widget _buildGridRow(
    bool hasRowSeprator,
    int buildRowIndex,
    Tuple2<int, int> rowInfo,
    BuildContext context,
  ) {
    late final int contentRowIndex;
    if (hasRowSeprator) {
      contentRowIndex = buildRowIndex ~/ 2;
      if (buildRowIndex % 2 == 1) {
        // 偶数行(index为奇数)是分隔行
        return rowSepratorBuilder!(context, contentRowIndex);
      }
    } else {
      contentRowIndex = buildRowIndex;
    }
    final isLastRow = contentRowIndex == rowInfo.item1 - 1;
    int columnCount = crossAxisCount;
    if (isLastRow && rowInfo.item2 > 0) {
      columnCount = rowInfo.item2;
    }
    List<Widget> rowChildren = List.generate(columnCount, (columnIndex) {
      final itemIndex = (contentRowIndex * crossAxisCount) + columnIndex;
      return itemBuilder(context, itemIndex);
    });
    if (scrollDirection == Axis.vertical) {
      return Row(
        mainAxisAlignment: rowMainAxisAlignment,
        crossAxisAlignment: rowCrossAxisAlignment,
        children: rowChildren.joinWidth(columnSpacing),
      );
    } else {
      return Column(
        mainAxisAlignment: rowMainAxisAlignment,
        crossAxisAlignment: rowCrossAxisAlignment,
        children: rowChildren.joinWidth(columnSpacing),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (crossAxisCount == 1) {
      if (_sliver) {
        if (rowSepratorBuilder != null) {
          return NoDataSliverList.separated(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: rowSepratorBuilder!,
            noData: noData,
          );
        } else {
          return NoDataSliverList.builder(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            noData: noData,
          );
        }
      } else {
        if (rowSepratorBuilder != null) {
          return NoDataListView.separated(
            scrollDirection: scrollDirection,
            controller: scrollController,
            itemBuilder: itemBuilder,
            separatorBuilder: rowSepratorBuilder!,
            itemCount: itemCount,
            noData: noData,
          );
        } else {
          return NoDataListView.builder(
            scrollDirection: scrollDirection,
            controller: scrollController,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            noData: noData,
          );
        }
      }
    }

    final contentRowInfo = _rowInfo();
    final hasRowSeprator = rowSepratorBuilder != null;
    final sepRowCount = (hasRowSeprator && contentRowInfo.item1 > 0)
        ? contentRowInfo.item1 - 1
        : 0;
    final totalRowCount = contentRowInfo.item1 + sepRowCount;
    if (_sliver) {
      return NoDataSliverList.builder(
        noData: noData,
        itemCount: totalRowCount,
        itemBuilder: (context, buildRowIndex) {
          return _buildGridRow(
            hasRowSeprator,
            buildRowIndex,
            contentRowInfo,
            context,
          );
        },
      );
    }
    final p = (inScrollWidget && physics == null)
        ? const NeverScrollableScrollPhysics()
        : physics;

    return NoDataListView.builder(
      noData: noData,
      scrollDirection: scrollDirection,
      controller: scrollController,
      physics: p,
      itemCount: totalRowCount,
      itemBuilder: (context, buildRowIndex) {
        return _buildGridRow(
          hasRowSeprator,
          buildRowIndex,
          contentRowInfo,
          context,
        );
      },
    );
  }
}
