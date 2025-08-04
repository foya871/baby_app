import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../utils/color.dart';
import '../../community/list/community_cell.dart';

import 'history_page_controller.dart';

class HistoryPage extends GetView<HistoryPageController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("历史记录")),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildBodyView(1).keepAlive,
                _buildBodyView(2).keepAlive,
                _buildBodyView(3).keepAlive,
                _buildBodyView(4).keepAlive,
                _buildBodyView(5).keepAlive,
                _buildBodyView(6).keepAlive,
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTabBar() {
    return Container(
      height: 28.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      margin: EdgeInsets.only(top: 10.w),
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs.map((e) => Tab(text: e.$1)).toList(),
        labelStyle: TextStyle(
          color: COLOR.white,
          fontSize: 13.w,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.w,
          color: COLOR.color_8e8e93,
        ),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicator: EasyFixedIndicator(
          widthExtra: 20.w,
          height: 25.w,
          borderRadius: BorderRadius.circular(12.5.w),
          color: COLOR.themeSelectedColor,
        ),
        indicatorPadding: EdgeInsets.only(bottom: 2.w),
        padding: EdgeInsets.zero,
        indicatorWeight: 0,
        dividerColor: COLOR.transparent,
        dividerHeight: 0,
        labelPadding: EdgeInsets.only(right: 20.w),
      ),
    );
  }

  Widget _buildBodyView(int tabIndex) {
    return EasyRefresh(
      controller: controller.refreshController,
      refreshOnStart: true,
      onRefresh: () async {
        controller.getHttpData(isRefresh: true, tabIndex: tabIndex);
      },
      onLoad: null,
      child:
          tabIndex == 3 ? _buildListView(tabIndex) : _buildGridView(tabIndex),
    );
  }

  _buildListView(int tabIndex) {
    return PagedListView.separated(
      pagingController: controller.pagingControllers[tabIndex]!,
      padding: EdgeInsets.symmetric(vertical: 10.w),
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        noMoreItemsIndicatorBuilder: (context) => const NoMore(),
        noItemsFoundIndicatorBuilder: (context) => const NoData(),
        itemBuilder: (context, value, index) => CommunityCell(model: value),
      ),
      separatorBuilder: (context, index) => 10.verticalSpace,
    );
  }

  _buildGridView(int tabIndex) {
    return PagedGridView(
      pagingController: controller.pagingControllers[tabIndex]!,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        noMoreItemsIndicatorBuilder: (context) => const NoMore(),
        noItemsFoundIndicatorBuilder: (context) => const NoData(),
        itemBuilder: (context, value, index) {
          if (tabIndex == 1) {
            //长视频
            return VideoBaseCell.small(video: value);
          }
          if (tabIndex == 2) {
            //短视频
            return VideoBaseCell.bigVertical(video: value);
          }
          if (tabIndex == 4) {
            //漫画
          }
          if (tabIndex == 5) {
            //写真
          }
          if (tabIndex == 6) {
            //小说
          }
          return const SizedBox.shrink();
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: tabIndex == 1 || tabIndex == 2 ? 2 : 3,
        mainAxisSpacing: 5.w,
        crossAxisSpacing: 5.w,
        childAspectRatio: tabIndex == 1 ? VideoBaseCell.smallAsp() : 0.6,
      ),
    );
  }
}
