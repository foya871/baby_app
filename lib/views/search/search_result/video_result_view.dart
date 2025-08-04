import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/search/search_result/search_result_video_controller.dart';
import 'package:baby_app/views/search/search_result/video_filter_view.dart';

import '../../../components/app_bg_view.dart';
import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/grid_view/heighted_grid_view.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../../home/widget/home_horizontal_cell.dart';
import '../../home/widget/home_horizontal_video_cell.dart';

class VideoResultView extends StatelessWidget {
  late SearchResultVideoController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SearchResultVideoController());

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              BaseRefreshSimpleWidget(
                controller,
                child: Obx(() {
                  return Padding(
                    padding: EdgeInsets.all(15.w),
                    child: HeightedGridView(
                        noData: controller.dataInited,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        rowSepratorBuilder: (ctx, i) => 5.verticalSpace,
                        itemCount: controller.data.length,
                        itemBuilder: (context, index) {
                          var model = controller.data[index];
                          return VideoBaseCell.small(
                              video: model,
                              onTap: () => controller.toVideo(model.videoId));
                        }),
                  );
                }),
              ),
              Positioned.fill(child: Obx(() {
                return IgnorePointer(
                  ignoring: !controller.showFilter.value,
                  child: Container(
                    color: controller.showFilter.value
                        ? COLOR.translucent_46
                        : Colors.transparent,
                  ).onTap(() {
                    controller.showFilter.value = false;
                  }),
                );
              })),
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300), // 动画持续时间
                  curve: Curves.easeIn,
                  top: controller.showFilter.value ? 0 : -253.w,
                  child: VideoFilterView(
                      controller.videoRuleType, controller.filterVideoLongType,
                      (rule, duration) {
                    controller.videoRuleType = rule;
                    controller.filterVideoLongType = duration;
                    controller.showFilter.value = !controller.showFilter.value;
                    controller.onRefresh();
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => TabBar(
                  controller: controller.videoTabController,
                  tabs: controller.videoTabs.asMap().entries.map((v) {
                    return Obx(() {
                      var selected = controller.videoTabIndex.value == v.key;
                      return AppBgView(
                        text: v.value,
                        textSize: 14.w,
                        textColor: selected ? COLOR.white : COLOR.color_8e8e93,
                        // margin: EdgeInsets.only(left: 15.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 2.w),
                        backgroundColor:
                            selected ? COLOR.color_63d2ff : COLOR.color_f3f5f8,
                        borderRadius: BorderRadius.circular(13.w),
                        onTap: () {
                          controller.videoTabIndex.value = v.key;
                          controller.onRefresh();
                        },
                      );
                    });
                  }).toList(),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: const BoxDecoration(),
                  labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  dividerHeight: 0,
                  onTap: (index) {
                    controller.videoTabIndex.value = index;
                    controller.onRefresh();
                  },
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Image.asset(
                  AppImagePath.search_ic_filter,
                  width: 15.w,
                ),
                3.horizontalSpace,
                Text(
                  "筛选",
                  style: TextStyle(fontSize: 14.w, color: COLOR.color_666666),
                ),
              ],
            ),
          ).onTap(
              () => controller.showFilter.value = !controller.showFilter.value),
        ],
      ),
    );
  }
}
