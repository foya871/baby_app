import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_multiple_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/community/community_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import 'community_page_child_controller.dart';
import 'list/community_list_page.dart';

class CommunityChildPage extends GetView<CommunityPageController> {
  const CommunityChildPage({
    super.key,
    required this.classify,
  });

  CommunityPageChildController get logic =>
      Get.find<CommunityPageChildController>(tag: classify);

  final String classify;

  _buildTopic() {
    return Obx(() {
      return logic.topics.isNotEmpty
          ? Wrap(
              spacing: 8.w,
              runSpacing: 8.w,
              children: logic.topics.asMap().entries.map((e) {
                var topic = e.value;
                return Stack(
                  children: <Widget>[
                    ImageView(
                      src: topic.backgroundImg ?? '',
                      width: ((ScreenUtil().screenWidth - 36.w) / 3),
                      height: 50.w,
                      borderRadius: Styles.borderRadius.m,
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        AppImagePath.community_topic_shadow,
                        width: ((ScreenUtil().screenWidth - 36.w) / 3),
                        height: 50.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              topic.name ?? '',
                              style: TextStyle(
                                color: COLOR.white,
                                fontSize: 13.w,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${Utils.numFmtCh(topic.postNum ?? 0)}个帖子',
                              style: TextStyle(
                                color: COLOR.color_cecece,
                                fontSize: 12.w,
                              ),
                            ).marginOnly(top: 1.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).onOpaqueTap(() {
                  Get.toTopicDetail(
                      topic: topic.name ?? '', id: topic.id ?? '');
                });
              }).toList(),
            ).marginOnly(left: 10.w, top: 10.w, bottom: 10.w).sliver
          : const SizedBox.shrink().sliver;
    });
  }

  _buildTabBar(BuildContext context) {
    return TabBar(
      controller: controller.childTabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicator: const BoxDecoration(),
      indicatorPadding: EdgeInsets.zero,
      overlayColor: WidgetStateProperty.all(COLOR.transparent),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.only(right: 10.w),
      tabs: controller.tags.asMap().entries.map((e) {
        final isSelected = e.key == controller.tabIndex.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 60.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: isSelected ? COLOR.color_009FE8 : COLOR.transparent,
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? COLOR.white : COLOR.white_60,
                fontSize: 14.w,
              ),
              child: Text(e.value),
            ).marginOnly(top: 0.w),
          ),
        );
      }).toList(),
    );
  }

  _buildTabBarView() {
    return TabBarView(
      controller: controller.childTabController,
      children: <Widget>[
        CommunityListPage(
          dataType: 0,
          loadType: 0,
          classify: classify,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 1,
          loadType: 1,
          classify: classify,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 2,
          loadType: 2,
          classify: classify,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 3,
          loadType: 3,
          classify: classify,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 4,
          loadType: 4,
          classify: classify,
        ).marginOnly(top: 10.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AdMultipleView.smallIcons(
                type: AdApiType.INSERT_ICON,
                spacing: 11.w,
              ).marginSymmetric(horizontal: 10.w, vertical: 10.w).sliver,
              // Obx(() {
              //   return controller.ads.isNotEmpty
              //       ? CommunityAd(ads: controller.ads)
              //           .marginOnly(left: 10.w, top: 10.w, bottom: 10.w)
              //           .sliver
              //       : const SizedBox.shrink().sliver;
              // }),
              _buildTopic(),
              SliverAppBar(
                title: Obx(() {
                  return _buildTabBar(context);
                }),
                automaticallyImplyLeading: false,
                pinned: true,
              ),
            ];
          },
          body: _buildTabBarView(),
        ),
        Positioned(
          right: 10.w,
          bottom: 10.w,
          child: Image.asset(
            AppImagePath.community_release,
            width: 50.w,
            height: 50.w,
          ).onOpaqueTap(() {
            Get.toCommunityRelease();
          }),
        ),
      ],
    );
  }
}
