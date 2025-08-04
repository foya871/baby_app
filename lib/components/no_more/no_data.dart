/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-27 14:36:38
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2025-02-20 15:42:12
 * @FilePath: /baby_app/lib/components/no_more/no_data.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class NoData extends StatelessWidget {
  final String tips;

  const NoData({super.key, this.tips = '空空如也～～～'});

  const NoData.empty({super.key}) : tips = '空空如也～～～';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImagePath.app_default_empty, width: 100.w),
          12.w.verticalSpace,
          Text(
            tips,
            style: TextStyle(color: COLOR.hexColor('#666666'), fontSize: 14.w),
          ).paddingTop(12.w)
        ],
      ),
    );
  }
}
