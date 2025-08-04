/*
 * @Author: wangdazhuang
 * @Date: 2024-12-03 09:12:34
 * @LastEditTime: 2025-07-05 13:36:03
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/stop_ad.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/image_view.dart';
import '../../../utils/ad_jump.dart';
import '../controllers/video_play_controller.dart';

class StopAd extends StatelessWidget {
  final VideoPlayController vc;
  const StopAd({super.key, required this.vc});

  Widget _buildAd() {
    final ad = vc.stopAd;
    final w = 200.w;
    final h = (189.0 / 340) * w;
    return SizedBox(
      width: w,
      height: h,
      child: ImageView(
        src: ad.adImage,
        fit: BoxFit.fill,
      ),
    ).onTap(() => kAdjump(ad));
  }

  Widget _buldClose() {
    return Icon(
      Icons.cancel_outlined,
      color: Colors.white,
      size: 20.w,
    ).onTap(() {
      vc.showStopAd.value = false;
      vc.update();
    }).marginLeft(12.w);
  }

  @override
  Widget build(BuildContext context) {
    if (!vc.showStopAd.value) return const SizedBox.shrink();
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildAd(), _buldClose()],
        ),
      ),
    );
  }
}
