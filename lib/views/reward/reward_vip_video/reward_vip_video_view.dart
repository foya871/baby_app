import 'package:baby_app/components/short_widget/video_base_cell.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data_grid_view.dart';
import '../../../utils/enum.dart';
import 'reward_vip_video_controller.dart';

class RewardVipVideoPage extends GetView<RewardVipVideoController> {
  const RewardVipVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('金币视频VIP限免专区'),
      ),
      body: Column(
        children: [
          buildTitle(),
          11.verticalSpace,
          Expanded(
            child: BaseRefreshSimpleWidget(
              controller,
              child: Obx(() {
                return NoDataGridView.builder(
                  noData: controller.dataInited,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7.w,
                      childAspectRatio: 174 / 160),
                  itemCount: controller.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = controller.data[index];
                    return VideoBaseCell.small(
                      video: model,
                      isFree: true,
                    );
                  },
                ).marginSymmetric(horizontal: 10.w);
              }),
            ),
          ),
        ],
      ),
    );
  }

  buildTitle() {
    return Container(
      height: 30.w,
      width: 140.w,
      decoration: BoxDecoration(
          color: COLOR.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.w)),
      child: Obx(() {
        return Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30.w,
              width: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: controller.type.value == RewardVideoRuleType.news
                      ? COLOR.color_009FE8
                      : Colors.transparent),
              child: TextView(
                text: '最新',
                fontSize: 14.w,
                color: controller.type.value == RewardVideoRuleType.news
                    ? COLOR.white
                    : COLOR.white.withValues(alpha: 0.6),
              ),
            ).onOpaqueTap(
                () => controller.switchType(RewardVideoRuleType.news)),
            Container(
              alignment: Alignment.center,
              height: 30.w,
              width: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: controller.type.value == RewardVideoRuleType.hot
                      ? COLOR.color_009FE8
                      : Colors.transparent),
              child: TextView(
                text: '最热',
                fontSize: 14.w,
                color: controller.type.value == RewardVideoRuleType.hot
                    ? COLOR.white
                    : COLOR.white.withValues(alpha: 0.6),
              ),
            ).onOpaqueTap(() => controller.switchType(RewardVideoRuleType.hot)),
          ],
        );
      }),
    );
  }
}
