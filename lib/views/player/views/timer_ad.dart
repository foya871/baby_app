/*
 * @Author: wangdazhuang
 * @Date: 2024-12-03 09:12:34
 * @LastEditTime: 2025-07-05 13:36:19
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/timer_ad.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../utils/ad_jump.dart';
import '../controllers/video_play_controller.dart';

class TimerAd extends StatelessWidget {
  final VideoPlayController vc;
  const TimerAd({super.key, required this.vc});

  Widget _buildTimerNum(Size size) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.6),
            borderRadius: BorderRadius.circular(size.height / 2.0)),
        child: Text(
          '${vc.timerAdCount}',
          style: kTextStyle(Colors.white, fontsize: 12.w),
        ),
      ),
    );
  }

  Widget _buildAdImage(Size adSize) {
    final ad = vc.timerAd;
    return Positioned(
      bottom: 0,
      left: 0,
      child: ImageView(
        src: ad.adImage,
        fit: BoxFit.fill,
        width: adSize.width,
        height: adSize.height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!vc.showTimerAd.value) return const SizedBox.shrink();
    final size = Size(30.w, 30.w);
    final adSize = Size(160.w, 32.w);
    final ad = vc.timerAd;
    return Positioned(
      left: 12.w,
      bottom: 35.w,
      width: adSize.width + size.height / 2,
      height: adSize.height + size.height / 2,
      child: Stack(
        children: [
          _buildAdImage(adSize),
          _buildTimerNum(size),
        ],
      ).onTap(() => kAdjump(ad)),
    );
  }
}
