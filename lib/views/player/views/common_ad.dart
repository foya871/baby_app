/*
 * @Author: wangdazhuang
 * @Date: 2025-02-20 19:13:43
 * @LastEditTime: 2025-07-05 13:31:32
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/common_ad.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommonAd extends StatefulWidget {
  const CommonAd({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CommonAd> {
  AdInfoModel? ad;

  @override
  void initState() {
    // ad = initWeightAdvertisementInfo(AdApiType.VIDEO_DETAIL);
    if (mounted && ad != null) {
      setState(() {});
    }
    super.initState();
  }

  void tapAd() {
    if (ad == null) return;
    jumpExternalURL(ad!.adJump);
  }

  @override
  Widget build(BuildContext context) {
    if (ad == null) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w)),
      clipBehavior: Clip.hardEdge,
      height: 100.w,
      child: ImageView(
        src: ad!.adImage ?? '',
        height: 100.w,
      ),
    ).onTap(tapAd);
  }
}
