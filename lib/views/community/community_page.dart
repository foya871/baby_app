import 'package:baby_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/community/community_child_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/views/community/community_page_controller.dart';

import 'community_page_child_controller.dart';

class CommunityPage extends GetView<CommunityPageController> {
  const CommunityPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      shadowColor: const Color.fromRGBO(0, 0, 0, 0),
      iconTheme: const IconThemeData(color: COLOR.transparent),
      title: Row(
        children: <Widget>[
          Container(
            width: 300.w,
            height: 32.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImagePath.community_search_bg),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  AppImagePath.community_search,
                  width: 18.w,
                  height: 18.w,
                ).marginOnly(left: 18.w),
                Text(
                  '请输入搜索关键词',
                  style: TextStyle(
                    color: COLOR.white_30,
                    fontSize: 13.w,
                  ),
                ).marginOnly(left: 10.w),
              ],
            ),
          ).marginOnly(left: 10.w).onOpaqueTap(() {
            Get.toSearchPage(classifyId: 0);
          }),
        ],
      ),
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image.asset(
            AppImagePath.community_vip,
            width: 34.w,
            height: 34.w,
          ).onOpaqueTap(() {
            Get.toVip();
          }),
        ),
      ],
    );
  }

  _buildTabBar() {
    var selectedColor = COLOR.color_009FE8;
    var unselectedColor = COLOR.white_60;

    final selectedStyle = TextStyle(
      color: selectedColor,
      fontSize: 15.w,
      fontWeight: FontWeight.w600,
    );
    final unselectedStyle = TextStyle(
      color: unselectedColor,
      fontSize: 15.w,
    );

    return SizedBox(
      height: 28.w,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelStyle: selectedStyle,
        unselectedLabelStyle: unselectedStyle,
        dividerHeight: 0,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.symmetric(horizontal: 11.w),
        indicator: EasyFixedIndicator(
          color: COLOR.color_009fe8,
          width: 10.w,
          height: 4.w,
          borderRadius: BorderRadius.circular(3.w),
        ),
        indicatorPadding: EdgeInsets.zero,
        overlayColor: MaterialStateProperty.all(COLOR.transparent),
        tabs: controller.tabs.asMap().entries.map((e) {
          var model = e.value;
          Get.put(CommunityPageChildController(model: model), tag: model.name);
          return Tab(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(model.name ?? ''),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: controller.tabs.map((v) {
        return initTemplate(
          v.name ?? '',
        );
      }).toList(),
    );
  }

  Widget initTemplate(String name) {
    return CommunityChildPage(classify: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            return controller.tabs.isNotEmpty
                ? _buildTabBar()
                : const SizedBox.shrink();
          }),
          Expanded(
            child: Obx(() {
              return controller.tabs.isNotEmpty
                  ? _buildTabBarView()
                  : const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }
}
