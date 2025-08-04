import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../model/classify/classify_models.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';

class ShiPinRankEntryCell extends StatelessWidget {
  final ClassifyModel classify;
  const ShiPinRankEntryCell(this.classify, {super.key});

  Widget _buildOne(String text, ShiPinRankType rankType) => Container(
        decoration: BoxDecoration(
            borderRadius: Styles.borderRadius.all(4.w),
            color: const Color(0xffff6699)),
        alignment: Alignment.center,
        width: 76.w,
        height: 36.w,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.w,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).onOpaqueTap(() => Get.toRank(classify, rankType, text));

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOne('日榜精选', ShiPinRankTypeEnum.day),
          _buildOne('周榜精选', ShiPinRankTypeEnum.week),
          _buildOne('月榜精选', ShiPinRankTypeEnum.month),
          _buildOne('总榜精选', ShiPinRankTypeEnum.total),
        ],
      );
}
