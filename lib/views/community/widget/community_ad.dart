import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommunityAd extends StatelessWidget {
  const CommunityAd({
    super.key,
    required this.ads,
  });

  final List<AdInfoModel> ads;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.w,
      children: ads.asMap().entries.map((e) {
        var ad = e.value;
        return Column(
          children: <Widget>[
            ImageView(
              src: ad.adImage ?? '',
              width: 62.w,
              height: 62.w,
              borderRadius: Styles.borderRadius.l,
            ),
            Text(
              (ad.adName != null && ad.adName!.length > 4)
                  ? ad.adName!.substring(0, 4)
                  : (ad.adName ?? ''),
              style: TextStyle(
                color: COLOR.white,
                fontSize: 11.w,
                fontWeight: FontWeight.w500,
              ),
            ).marginOnly(top: 6.w),
          ],
        ).onOpaqueTap(() {
          kAdjump(ad);
        });
      }).toList(),
    );
  }
}
