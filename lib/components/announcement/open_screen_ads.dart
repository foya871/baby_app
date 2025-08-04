import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_multiple_view.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generate/app_image_path.dart';

class OpenScreenAds extends StatelessWidget {
  final VoidCallback? dismiss;

  const OpenScreenAds({
    super.key,
    this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 330.w,
        height: 630.w,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.only(
                    top: 120.w, bottom: 12.w, left: 7.w, right: 7.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImagePath.ann_open_ads_bg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10.w, left: 7.w, right: 7.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(
                      12.w,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: AdMultipleView.smallIcons(
                      type: AdApiType.INDEX_POP_ICON,
                      smallIconSize: (330.w - 28.w - 24.w) / 4.0,
                      spacing: 8.w,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 15.w,
              top: 40.w,
              child: Image.asset(
                AppImagePath.ann_cancel,
                width: 29.w,
                height: 29.w,
              ).onTap(dismiss),
            )
          ],
        ));
  }
}
