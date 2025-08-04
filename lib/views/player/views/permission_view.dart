/*
 * @Author: wangdazhuang
 * @Date: 2024-12-03 09:12:34
 * @LastEditTime: 2025-06-06 20:38:39
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /51luanlun_app/lib/views/player/views/permission_view.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/enum.dart';
import '../controllers/video_play_controller.dart';

class PermissionView extends StatelessWidget {
  final VideoPlayController vc;
  const PermissionView({super.key, required this.vc});

  @override
  Widget build(BuildContext context) {
    final video = vc.video.value;
    if (video.canWatch == true) return const SizedBox.shrink();
    final type = video.reasonType;
    final ispay = type == VideoReasonTypeValueEnum.NeedPay;
    final txt = ispay ? '${video.price ?? 0}金币 解锁' : '开通VIP观看完整版';
    return Positioned(
      right: 14.w,
      top: 20.w,
      child: EasyButton(
        txt,
        height: 30.w,
        textStyle:
            kTextStyle(Colors.white, fontsize: 14.w, weight: FontWeight.bold),
        backgroundColor: COLOR.themeSelectedColor,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        borderRadius: BorderRadius.circular(15.w),
        onTap: () {
          if (ispay) {
            vc.showBuyVideoPermissionSheet();
          } else {
            Get.toVip();
          }
        },
      ),
    );
  }
}
