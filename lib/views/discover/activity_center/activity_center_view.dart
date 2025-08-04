/*
 * @Author: wdz
 * @Date: 2025-07-04 17:18:36
 * @LastEditTime: 2025-07-05 11:59:57
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/discover/activity_center/activity_center_view.dart
 */
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/no_more/no_data_list_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/model/announcement/activity_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../utils/ad_jump.dart';
import 'activity_center_controller.dart';

class ActivityCenterPage extends StatelessWidget {
  const ActivityCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityCenterController controller =
        Get.put(ActivityCenterController());
    return BaseRefreshSimpleWidget(
      controller,
      child: Obx(() {
        return NoDataListView.builder(
          noData: controller.dataInited,
          itemCount: controller.data.length,
          itemBuilder: (BuildContext context, int index) {
            var model = controller.data[index];
            return buildItem(model);
          },
        ).marginSymmetric(horizontal: 10.w);
      }),
    );
  }

  buildItem(ActivityModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageView(
          src: item.coverPicture ?? "",
          width: 355.w,
          borderRadius: BorderRadius.circular(12.w),
          height: 170.w,
        ),
        6.verticalSpace,
        TextView(
          text: item.actTitle ?? "",
          fontSize: 14.w,
          color: COLOR.white,
          maxLines: 2,
        ),
        2.verticalSpace,
        TextView(
          text: item.activityTime ?? "",
          fontSize: 12.w,
          color: COLOR.white.withValues(alpha: 0.6),
          maxLines: 1,
        ),
      ],
    ).onOpaqueTap(() => jumpExternalURL(item.actUrl ?? '', adId: item.id));
  }
}
