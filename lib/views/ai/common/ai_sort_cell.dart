import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';

enum AiStenceilSortType { time, price, usedCount }

class AiStencilSortArgs {
  final AiStenceilSortType type;
  final bool asc;

  AiStencilSortArgs({required this.type, required this.asc});
}

class AiSortCell extends StatelessWidget {
  final String text;
  final bool? asc;
  final VoidCallback? onTap;

  const AiSortCell(
      {required this.text, required this.asc, this.onTap, super.key});

  String get _icon => switch (asc) {
        true => AppImagePath.ai_home_sort_asc,
        false => AppImagePath.ai_home_sort_desc,
        null => AppImagePath.ai_home_sort_none,
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.w),
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius.all(4.w),
          border: Border.all(
            color: COLOR.white.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Text(text),
            Image.asset(_icon, width: 12.w, height: 12.w),
          ],
        ),
      ).onOpaqueTap(onTap);
}
