import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/community/release/community_release_page_controller.dart';
import 'package:baby_app/views/community/release/community_release_topic_page.dart';
import 'package:baby_app/views/community/release/community_release_video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityReleasePage extends GetView<CommunityReleasePageController> {
  const CommunityReleasePage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      shadowColor: const Color.fromRGBO(0, 0, 0, 0),
      iconTheme: const IconThemeData(color: COLOR.white),
      backgroundColor: COLOR.transparent,
      centerTitle: true,
      title: _buildTabBar(),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            width: 62.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: COLOR.color_009FE8,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Center(
              child: Text(
                '发布',
                style: TextStyle(
                  color: COLOR.white,
                  fontSize: 14.w,
                ),
              ),
            ),
          ).onOpaqueTap(() {
            if (controller.tabController.index == 0) {
              controller.release();
            } else {
              controller.release02();
            }
          }),
        ),
      ],
    );
  }

  _buildTabBar() {
    var selectedColor = COLOR.white;
    var unselectedColor = COLOR.white_50;

    final selectedStyle = TextStyle(
      color: selectedColor,
      fontSize: 17.w,
      fontWeight: FontWeight.w500,
    );
    final unselectedStyle = TextStyle(
      color: unselectedColor,
      fontSize: 17.w,
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
        labelPadding: EdgeInsets.only(right: 30.w),
        indicator: const BoxDecoration(),
        indicatorPadding: EdgeInsets.zero,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: const [
          Tab(text: '发图文'),
          Tab(text: '发视频'),
        ],
      ),
    );
  }

  _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: const <Widget>[
        CommunityReleaseTopicPage(),
        CommunityReleaseVideoPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildTabBarView(),
    ).onOpaqueTap(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
