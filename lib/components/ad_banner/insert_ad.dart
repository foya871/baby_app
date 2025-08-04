import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/assets/styles.dart';

import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../utils/ad_jump.dart';
import '../../utils/ad_utils.dart';
import '../../utils/color.dart';
import '../../utils/enum.dart';
import '../../utils/extension.dart';
import '../ad/ad_enum.dart';
import '../ad/ad_utils.dart';
import '../image_view.dart';

class InsertAd extends StatelessWidget {
  final AdApiType adress;
  final double? height;
  final double? width;
  final bool showMark;
  final bool showName;
  final EdgeInsets? margin;
  InsertAd(
      {super.key,
      required this.adress,
      double? width,
      double? height,
      this.showName = false,
      this.showMark = true,
      this.margin})
      : height = height ?? 120.w,
        width = width ?? 372.w;

  InsertAd.fromPlaceholder(
    InsertAdPlaceHolderModel placeholder, {
    super.key,
    this.width = double.infinity,
    required this.height,
    this.showMark = true,
    this.showName = false,
    this.margin,
  }) : adress = placeholder.place;

  Widget _buildMark() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.w,
        ),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(3.w)),
        child: Text(
          '广告',
          style: TextStyle(color: const Color(0xff18191c), fontSize: 10.w),
        ),
      );

  Widget _buildCover(AdInfoModel ad) => Stack(
        children: [
          ClipRRect(
            borderRadius: Styles.borderRadius.all(8.w),
            child: ImageView(
              src: ad.adImage ?? '',
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          if (showMark)
            Positioned(bottom: 5.w, right: 5.w, child: _buildMark()),
        ],
      );

  Widget _buildName(AdInfoModel ad) => Text(
        maxLines: 2,
        '${ad.adName}',
        style: TextStyle(color: const Color(0xffffffff), fontSize: 12.w),
      );

  @override
  Widget build(BuildContext context) {
    final ad = AdUtils().getAdInfo(adress);
    if (ad == null) return const SizedBox.shrink();
    return Container(
      width: width,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCover(ad),
          if (showName) ...[
            8.verticalSpaceFromWidth,
            _buildName(ad),
          ],
        ],
      ),
    ).onOpaqueTap(() => kAdjump(ad));
  }
}
