import 'package:flutter/material.dart';

import 'ai_record_cell.dart';

///
/// 三个record,左1右2, 超过3个后面的不会生效
///

class AiRecordCellBlock extends StatelessWidget {
  static const int recordMax = 3;
  final List<AiRecordCellOption> options;

  const AiRecordCellBlock({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }
    final first = AiRecordCell.vertical(option: options.first);
    Widget? second = options.length >= 2
        ? AiRecordCell.horizontal(option: options[1])
        : null;
    Widget? third = options.length >= 3
        ? AiRecordCell.horizontal(option: options[2])
        : null;
    final columnChildren = <Widget>[];
    if (second != null) columnChildren.add(second);
    if (third != null) columnChildren.add(third);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          first,
          if (columnChildren.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: columnChildren,
            )
        ],
      ),
    );
  }
}
