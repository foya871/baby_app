/*
 * @Author: wangdazhuang
 * @Date: 2024-12-03 09:12:34
 * @LastEditTime: 2025-07-05 13:35:37
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/start_ad.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/image_view.dart';
import '../../../utils/ad_jump.dart';
import '../controllers/video_play_controller.dart';

class StartAd extends StatelessWidget {
  final VideoPlayController vc;
  const StartAd({super.key, required this.vc});

  AdInfoModel get _ad => vc.startAd;

  void _tapAd() {
    jumpExternalURL(_ad.adJump);
  }

  @override
  Widget build(BuildContext context) {
    if (!vc.showStartAd.value) return const SizedBox.shrink();
    final count = vc.startTimerAdCount;
    final txt = "${count}s";
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageView(src: _ad.adImage).onTap(() => _tapAd()),
          ),
          Positioned(
            right: 14.w,
            bottom: 20.w,
            child: EasyButton(
              txt,
              backgroundColor: Colors.black.withValues(alpha: 0.8),
              textStyle: kTextStyle(Colors.white, fontsize: 14.w),
              height: 30.w,
              borderRadius: BorderRadius.circular(15.w),
              // onTap: () {
              //   if (count > 0) {
              //     _tapAd();
              //   } else {
              //     ///跳过
              //     vc.showStartAd.value = false;
              //     vc.startAdTimer?.cancel();
              //     vc.update();
              //     vc.player?.play();
              //   }
              // },
            ),
          )
        ],
      ),
    );
  }
}
