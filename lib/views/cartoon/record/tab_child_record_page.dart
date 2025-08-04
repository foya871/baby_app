import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tuple/tuple.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/model/ai/ai_models.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'item_view.dart';
import 'tab_child_record_page_controller.dart';

class TabChildRecordPage extends GetView<TabChildRecordPageController> {
  final int tabIndex;

  const TabChildRecordPage({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _buildBodyView(controller.tabs[0].item2).keepAlive,
          _buildBodyView(controller.tabs[1].item2).keepAlive,
          _buildBodyView(controller.tabs[2].item2).keepAlive,
        ],
      ),
    );
  }

  /// 构建 AppBar
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Row(
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: List.generate(controller.tabs.length, (index) {
              return Obx(() => _buildTabItemView(controller.tabs[index].item1,
                  controller.checkedStatus.value == index));
            }),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            dividerHeight: 0,
            automaticIndicatorColorAdjustment: false,
            physics: const NeverScrollableScrollPhysics(),
            labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
            indicator: EasyFixedIndicator(width: 0.w, height: 0.w),
            onTap: (index) {
              controller.checkedStatus.value = index;
            },
          ),
          const Spacer(),
          TextView(
            text: "删除",
            fontSize: 14.w,
          ).onOpaqueTap(() {
            showAlertDialog(
              Get.context!,
              title: "确定删除所有记录吗",
              onRightButton: () {
                controller.deleteAiRecord(
                  tabIndex,
                  controller.tabs[controller.checkedStatus.value].item2,
                );
              },
            );
          }),
        ],
      ),
    );
  }

  /// 构建 Tab 选项
  Widget _buildTabItemView(String title, bool isChecked) {
    return AppBgView(
      width: 77.w,
      height: 30.w,
      radius: 15.w,
      text: title,
      textSize: 14.w,
    );
  }

  /// 构建列表 Body
  Widget _buildBodyView(String tabStatus) {
    return EasyRefresh(
        controller: controller.refreshController,
        refreshOnStart: true,
        onRefresh: () async => controller.getHttpDatas(
            tabIndex: tabIndex, tabStatus: tabStatus, isRefresh: true),
        onLoad: () async => controller.getHttpDatas(
            tabIndex: tabIndex, tabStatus: tabStatus, isRefresh: false),
        child: PagedMasonryGridView(
          pagingController: controller.getPagingController(tabIndex, tabStatus),
          gridDelegateBuilder: (childCount) =>
              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
          addAutomaticKeepAlives: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
          builderDelegate: PagedChildBuilderDelegate<AiRcRecordV2Model>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, value, index) {
              return ItemView(
                status: tabStatus,
                coverImageUrl: '',
                title: "",
                useCount: index,
                isBig: index == 0 || index == 3,
                onTap: () {
                  if (tabStatus == 'success') {
                    if (tabIndex == 0 || tabIndex == 2 || tabIndex == 3) {
                    } else {
                      // Get.toVideoBoxByURL(url: option.videoUrl);
                    }
                  }
                },
                onSaveTap: () {},
                onAppealTap: () {
                  controller.appealAiRecord(value.tradeNo ?? "");
                },
                onDeleteTap: () {
                  controller.delOneAiRecord(
                    tabIndex,
                    controller.tabs[controller.checkedStatus.value].item2,
                    value.tradeNo ?? "",
                  );
                },
              );
            },
          ),
        ));
  }
}
