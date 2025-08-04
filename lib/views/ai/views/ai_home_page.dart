import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/ai_app_bar.dart';
import '../controllers/ai_home_page_controller.dart';
import 'tabs/ai_tab_cloth_page.dart';
import 'tabs/ai_tab_face_image_page.dart';
import 'tabs/ai_tab_face_video_page.dart';

class AiPage extends GetView<AiHomePageController> {
  const AiPage({super.key});

  AppBar _buildAppBar() => AiAppBar();

  Widget _buildTab(int index) => Obx(
        () => SizedBox(
          width: 106.w,
          height: 50.w,
          child: Tab(
            child: controller.currentIndex.value == index
                ? Image.asset(
                    AiHomePageController.tabs[index].item1,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AiHomePageController.tabs[index].item2,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      );

  Widget _buildTabBar() => TabBar(
        controller: controller.tabController,
        tabs: [
          _buildTab(AiHomePageController.tabClothIndex),
          _buildTab(AiHomePageController.tabFaceImageIndex),
          _buildTab(AiHomePageController.tabFaceVideoIndex),
          // _buildTab(AiHomePageController.tabFaceCustomIndex),
        ],
        dividerHeight: 0,
        indicatorColor: COLOR.transparent,
        labelPadding: EdgeInsets.zero,
      );

  // Widget _buildFloatingTips() {
  //   return Image.asset(AppImagePath.ai_home_wxts, width: 50.w, height: 50.w)
  //       .onTap(() => AiWxtsKfDialog().show());
  // }

  Widget _buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  const AiTabClothPage().keepAlive,
                  const AiTabFaceImagePage().keepAlive,
                  const AiTabFaceVideoPage().keepAlive,
                  // const AiTabFaceCustomPage().keepAlive,
                ],
              ),
            )
          ],
        ).marginHorizontal(10.w),
        // Positioned.fill(
        //     child: Align(
        //   alignment: const Alignment(1, 0.55),
        //   child: _buildFloatingTips(),
        // ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
