import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/community/list/community_list_page.dart';
import 'package:baby_app/views/community/topic/topic_detail_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class TopicDetailPage extends GetView<TopicDetailPageController> {
  const TopicDetailPage({super.key});

  AppBar _buildAppBar() => AppBar(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        iconTheme: const IconThemeData(color: COLOR.white),
        backgroundColor: COLOR.transparent,
        title: Obx(() {
          return Text(
            '#${controller.topic.value}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: COLOR.white,
              fontSize: 17.w,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        centerTitle: true,
      );

  _buildTop() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ImageView(
                  src: controller.communityTopic.value.logo ?? '',
                  width: 113.w,
                  height: 113.w,
                  borderRadius: BorderRadius.circular(4.w),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.communityTopic.value.name ?? '',
                        style: TextStyle(
                          color: COLOR.white,
                          fontSize: 16.w,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        '${Utils.numFmtCh(controller.communityTopic.value.postNum ?? 0)}个帖子',
                        style: TextStyle(
                          color: COLOR.color_999999,
                          fontSize: 12.w,
                        ),
                      ),
                      Text(
                        '${Utils.numFmtCh(controller.communityTopic.value.fakeWatchTimes ?? 0)}浏览',
                        style: TextStyle(
                          color: COLOR.color_999999,
                          fontSize: 12.w,
                        ),
                      ),
                    ],
                  ).marginOnly(left: 10.w),
                ),
              ],
            ),
          ),
          Image.asset(
            controller.communityTopic.value.subscribe == true
                ? AppImagePath.community_attention
                : AppImagePath.community_attention_no,
            width: 62.w,
            height: 28.w,
          ).marginOnly(left: 10.w, right: 10.w).onOpaqueTap(() {
            controller.subscribe(controller.communityTopic.value.id ?? '',
                controller.communityTopic.value.subscribe ?? false);
          })
        ],
      ).marginOnly(left: 10.w, right: 10.w);
    });
  }

  _buildTabBar(BuildContext context) {
    final List<String> tags = ['推荐', '最新', '最热', '精华', '视频'];

    return Obx(() {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 16.w),
        height: 28.w,
        child: Theme(
          data: Theme.of(context).copyWith(
            tabBarTheme: const TabBarTheme(
              indicator: BoxDecoration(),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          child: TabBar(
            controller: controller.tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: const BoxDecoration(),
            indicatorPadding: EdgeInsets.zero,
            overlayColor: WidgetStateProperty.all(COLOR.transparent),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(right: 10.w),
            tabs: tags.asMap().entries.map((e) {
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
                  ).marginOnly(top: 2.w),
                ),
              );
            }).toList(),
          ),
        ),
      ).marginOnly(top: 20.w);
    });
  }

  _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: <Widget>[
        CommunityListPage(
          dataType: 5,
          loadType: 0,
          topicId: controller.topic.value,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 6,
          loadType: 1,
          topicId: controller.topic.value,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 7,
          loadType: 2,
          topicId: controller.topic.value,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 8,
          loadType: 3,
          topicId: controller.topic.value,
        ).marginOnly(top: 10.w),
        CommunityListPage(
          dataType: 9,
          loadType: 4,
          topicId: controller.topic.value,
        ).marginOnly(top: 10.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTop(),
          _buildTabBar(context),
          Expanded(
            child: _buildTabBarView(),
          ),
        ],
      ),
    );
  }
}
