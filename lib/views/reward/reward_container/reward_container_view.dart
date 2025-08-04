import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/reward/app_recommend/app_recommend_view.dart';
import 'package:baby_app/views/reward/reward_task/reward_task_view.dart';

import '../../../components/keep_alive_wrapper.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../utils/color.dart';
import 'reward_container_controller.dart';

class RewardContainerPage extends GetView<RewardContainerController> {
  const RewardContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: [RewardTaskPage().keepAlive, AppRecommendPage().keepAlive],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildTabBar(),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: COLOR.white,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: COLOR.white),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: controller.tabController,
      tabs: controller.tabs
          .map((v) => Tab(
                text: v,
              ))
          .toList(),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      // labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(
          fontSize: 15.w, fontWeight: FontWeight.w600, color: COLOR.white),
      unselectedLabelStyle: TextStyle(
          fontSize: 15.w, fontWeight: FontWeight.w600, color: COLOR.white_60),
      indicator: EasyFixedIndicator(
          color: COLOR.color_1F7CFF, width: 18.w, height: 0.w),
      dividerHeight: 0,
    );
  }
}
