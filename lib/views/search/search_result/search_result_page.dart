import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import '../../community/list/community_cell.dart';
import 'search_result_page_controller.dart';

class SearchResultPage extends GetView<SearchResultPageController> {
  const SearchResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: GestureDetector(
        onTap: Get.back,
        child: Container(
          decoration: BoxDecoration(
            color: COLOR.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.w),
          ),
          height: 32.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              ImageView(
                src: AppImagePath.home_ic_grey_search,
                width: 15.w,
              ),
              Expanded(
                child: SizedBox(
                  height: 30.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextView(
                        text: controller.keyWord,
                        fontSize: 14.w,
                        color: COLOR.white,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
            ],
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          height: 35.w,
          width: 28.w,
          margin: EdgeInsets.only(right: 15.w, left: 10),
          child: const SizedBox(),
        ),
      ],
    );
  }

  _buildTabBar() {
    final style = TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500);
    final unLabelStyle = TextStyle(fontSize: 15.w, fontWeight: FontWeight.w400);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 32.w,
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs.map((e) {
          return Tab(text: e.$1);
        }).toList(),
        isScrollable: true,
        indicatorColor: COLOR.themeSelectedColor,
        indicatorPadding: EdgeInsets.only(bottom: 0.w, left: 7.w, right: 7.w),
        tabAlignment: TabAlignment.center,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        labelStyle: style,
        unselectedLabelColor: COLOR.white.withValues(alpha: 0.8),
        unselectedLabelStyle: unLabelStyle,
        indicator: EasyFixedIndicator(
          width: 10.w,
          height: 4.w,
          borderRadius: BorderRadius.circular(2.w),
          color: COLOR.themeSelectedColor,
        ),
        // indicatorPadding: EdgeInsets.zero,
        dividerHeight: 0,
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
