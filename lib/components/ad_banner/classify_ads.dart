import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../ad/ad_enum.dart';
import '../ad/ad_utils.dart';

class ClassifyAds extends StatelessWidget {
  final AdApiType? place;
  const ClassifyAds({super.key}) : place = AdApiType.INSERT_ICON;

  Widget _buildItemView(AdInfoModel e, double itemW) => SizedBox(
        width: itemW,
        child: Column(
          children: [
            ImageView(
                src: e.adImage ?? '',
                width: itemW,
                height: itemW,
                borderRadius: BorderRadius.circular(5.w)),
            5.verticalSpaceFromWidth,
            SizedBox(
              width: itemW,
              child: Text(e.adName ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ).onTap(() => kAdjump(e)),
      );

  @override
  Widget build(BuildContext context) {
    final gap = 10.w;
    final gapLR = 12.w;
    final itemW = (Get.width - gapLR * 2 - gap * 4) / 5.0;
    final items = AdUtils().getAdLoadInOrder(place ?? AdApiType.INSERT_ICON);

    Get.log("=============>数据 length  ${items.length}");
    if (items.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: gap,
      runSpacing: gap,
      runAlignment: WrapAlignment.start,
      children: items.map((e) => _buildItemView(e, itemW)).toList(),
    ).marginHorizontal(gapLR).marginTop(5.w);
  }
}
