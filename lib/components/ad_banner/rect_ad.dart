import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import '../../utils/ad_jump.dart';
import '../../utils/extension.dart';
import '../image_view.dart';

class RectAd extends StatelessWidget {
  final AdInfoModel ad;
  final double width;
  final double height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const RectAd(
    this.ad, {
    required this.width,
    required this.height,
    this.borderRadius,
    this.fit,
    super.key,
  });

  const RectAd.square(this.ad,
      {required double size, super.key, this.borderRadius, this.fit})
      : width = size,
        height = size;

  @override
  Widget build(BuildContext context) => ImageView(
        src: ad.adImage ?? '',
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius ?? Styles.borderRadius.all(8.w),
      ).onTap(() => kAdjump(ad));
}
