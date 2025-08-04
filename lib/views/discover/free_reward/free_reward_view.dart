import 'package:baby_app/views/mine/share/share_data/share_conten/share_conten_view.dart';
import 'package:baby_app/views/reward/reward_task/reward_task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../utils/color.dart';
import '../sys_partner_app_list/view.dart';
import 'free_reward_controller.dart';

class FreeRewardPage extends StatelessWidget {
  const FreeRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FreeRewardController controller = Get.put(FreeRewardController());

    return Column(
      children: [
        _buildTabBar(controller),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              ShareContenPage(),
              const RewardTaskPage(),
              const SysPartnerAppListView(hideAppBar: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(FreeRewardController controller) {
    return TabBar(
      controller: controller.tabController,
      tabs: controller.tabs
          .map((v) => Tab(
                text: v,
              ))
          .toList(),
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      // labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
          color: COLOR.color_009FE8),
      unselectedLabelStyle: TextStyle(
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
          color: COLOR.white.withValues(alpha: 0.6)),
      indicator: EasyFixedIndicator(
          color: COLOR.transparent, width: 10.w, height: 4.w),
      dividerHeight: 0,
    );
  }
}
