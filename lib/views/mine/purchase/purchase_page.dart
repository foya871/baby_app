import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../utils/color.dart';
import '../../community/list/community_cell.dart';
import 'purchase_page_controller.dart';

class PurchasePage extends GetView<PurchasePageController> {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的购买")),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildBodyView(1).keepAlive,
                _buildBodyView(2).keepAlive,
                // _buildBodyView(3).keepAlive,
                // _buildBodyView(4).keepAlive,
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTabBar() {
    return Container(
      height: 40.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      // margin: EdgeInsets.only(top: 10.w),
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs.map((e) => Tab(text: e.$1)).toList(),
        labelStyle: TextStyle(
          color: COLOR.white,
          fontSize: 15.w,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 15.w,
          color: COLOR.color_8e8e93,
        ),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicator: EasyFixedIndicator(
          width: 12.w,
          height: 4.w,
          borderRadius: BorderRadius.circular(2.w),
          color: COLOR.themeSelectedColor,
        ),
        // indicatorPadding: EdgeInsets.only(bottom: 2.w),
        padding: EdgeInsets.only(bottom: 5.w),
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
      onLoad: () async {
        controller.getHttpData(isRefresh: false, tabIndex: tabIndex);
      },
      child:
          tabIndex == 2 ? _buildListView(tabIndex) : _buildGridView(tabIndex),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        noMoreItemsIndicatorBuilder: (context) => const NoMore(),
        noItemsFoundIndicatorBuilder: (context) => const NoData(),
        itemBuilder: (context, value, index) {
          return VideoBaseCell.small(video: value);
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 7.w,
        childAspectRatio: 1.11,
      ),
    );
  }
}
