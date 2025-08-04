import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/extension.dart';
import '../../../shi_pin/common/shi_pin_tab/shi_pin_tab_factory.dart';
import '../../controllers/shi_pin_tab_controller.dart';

class ShiPinTab extends GetView<ShiPinTabController> {
  const ShiPinTab({super.key});

  Widget _buildTabBar() {
    return SizedBox(
      height: 28.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TabBar(
              tabs: controller.tabs
                  .map((e) => Tab(text: e.classifyTitle))
                  .toList(),
              isScrollable: true,
              controller: controller.tabController,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(
                left: 6.w,
                right: 6.w,
                bottom: 0.w,
              ),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(1.5.w),
                borderSide: BorderSide(
                  color: const Color(0xffff6699),
                  width: 3.w,
                ),
              ),
              // labelPadding: EdgeInsets.symmetric(vertical: 2.w),
              labelStyle: TextStyle(
                fontSize: 17.w,
                fontWeight: FontWeight.w500,
                color: const Color(0xffff6699),
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 17.w,
                fontWeight: FontWeight.w500,
                color: const Color(0xff676c73),
              ),
            ),
          ),
          5.w.horizontalSpace,
          Image.asset(
            AppImagePath.app_default_search,
            width: 22.w,
            height: 22.w,
          ).onTap(() {
            final classifyId =
                controller.tabs[controller.tabController.index].classifyId;
            Get.toSearchPage(classifyId: classifyId);
          }),
          12.w.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    final views = controller.tabs
        .map((e) => ShiPinTabFactory.create(e.classifyId, e.type).keepAlive)
        .toList();
    return TabBarView(controller: controller.tabController, children: views);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        title: _buildTabBar().baseMarginL,
      ),
      body: Column(
        children: [Expanded(child: _buildTabBarView())],
      ),
    );
  }
}
