import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

enum AiCostTipsStyle { per, price }

class AiCostTips extends StatelessWidget {
  final double gold;
  final int? freeCount;
  final AiCostTipsStyle style;

  const AiCostTips({
    super.key,
    required this.gold,
    this.freeCount,
    this.style = AiCostTipsStyle.price,
  });

  @override
  Widget build(BuildContext context) {
    final highlightStyle = TextStyle(
      fontSize: 12.w,
    );
    final normalStyle = TextStyle(
      fontSize: 12.w,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (style == AiCostTipsStyle.per) ...[
          Text('${gold.toStringAsShort()}金币', style: highlightStyle),
          Text('/张', style: normalStyle),
        ] else ...[
          Text('金币价:', style: normalStyle),
          3.horizontalSpace,
          Text(gold.toStringAsShort(), style: highlightStyle)
        ],
        10.horizontalSpace,
        if (freeCount != null) ...[
          Text('免费次数:', style: normalStyle),
          3.horizontalSpace,
          Text('$freeCount', style: highlightStyle)
        ]
      ],
    );
  }
}
