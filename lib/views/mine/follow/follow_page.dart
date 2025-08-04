import 'package:baby_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:baby_app/model/mine/fans_follower_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../components/text_view.dart';
import '../../../../utils/color.dart';
import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/mine/topic_item_model.dart';
import 'follow_page_controller.dart';

///话题没写
class FollowPage extends GetView<FollowPageController> {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的关注")),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children:
                  controller.tabs.map((e) => _buildBodyView(e.$2)).toList(),
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
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      margin: EdgeInsets.only(top: 10.w),
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs.map((e) => Tab(text: e.$1)).toList(),
        labelStyle: TextStyle(
            color: COLOR.white, fontSize: 15.w, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            TextStyle(fontSize: 15.w, color: COLOR.color_8e8e93),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicator: EasyFixedIndicator(
          width: 12.w,
          height: 4.w,
          borderRadius: BorderRadius.circular(2.w),
          color: COLOR.themeSelectedColor,
        ),
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
      child: GetBuilder<FollowPageController>(builder: (controller) {
        return PagedListView.separated(
          pagingController: controller.pagingControllers[tabIndex]!,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const NoMore(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, value, index) {
                if (tabIndex == 1) {
                  return _buildItemView(value as FansFollowerModel);
                } else {
                  return _buildTopicItem(value as TopicSubscribeItemModel);
                }
              }),
          separatorBuilder: (context, index) => 15.verticalSpace,
        );
      }),
    );
  }

  _buildItemView(FansFollowerModel item) {
    return Row(
      children: [
        ImageView(
          src: item.logo ?? "",
          width: 50.w,
          height: 50.w,
          borderRadius: BorderRadius.circular(28.w),
          defaultPlace: AppImagePath.app_default_avatar,
        ),
        10.horizontalSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: item.nickName ?? "",
              fontSize: 14.w,
              color: COLOR.white,
            ),
            5.verticalSpace,
            TextView(
              text: "${Utils.numFmt(item.workNum ?? 0, upper: true)}部作品",
              fontSize: 13.w,
              color: COLOR.white.withValues(alpha: 0.6),
            ),
          ],
        ),
        const Spacer(),
        10.horizontalSpace,
        _buildFollowBtn(item.attention ?? false, () {
          controller.toggleFollow(item);
        })
      ],
    ).onOpaqueTap(() {
      Get.toBloggerDetail(userId: item.userId ?? 0);
    });
  }

  Widget _buildTopicItem(TopicSubscribeItemModel item) {
    return Row(
      children: [
        ImageView(
          src: item.logo ?? "",
          width: 113.w,
          height: 113.w,
          borderRadius: BorderRadius.circular(28.w),
          defaultPlace: AppImagePath.app_default_avatar,
        ),
        10.horizontalSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "#${item.name ?? ""}",
              fontSize: 14.w,
              color: COLOR.white,
            ),
            5.verticalSpace,
            TextView(
              text: "${Utils.numFmt(item.postNum ?? 0, upper: true)}个帖子",
              fontSize: 13.w,
              color: COLOR.white.withValues(alpha: 0.6),
            ),
            5.verticalSpace,
            TextView(
              text: "${Utils.numFmt(item.fakeWatchTimes ?? 0, upper: true)}浏览",
              fontSize: 13.w,
              color: COLOR.white.withValues(alpha: 0.6),
            ),
          ],
        ),
        const Spacer(),
        10.horizontalSpace,
        _buildFollowBtn(item.isSubscribe, () {
          controller.toggleSubscribe(item);
        })
      ],
    ).onOpaqueTap(() {
      Get.toTopicDetail(topic: item.name ?? "", id: item.id ?? "");
    });
  }

  Widget _buildFollowBtn(bool isFollow, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 26.w,
        decoration: BoxDecoration(
            color: isFollow ? Colors.white10 : COLOR.color_009FE8,
            borderRadius: BorderRadius.circular(15.w)),
        alignment: Alignment.center,
        child: TextView(
          text: isFollow ? "已关注" : "关注",
          color: isFollow ? Colors.white60 : Colors.white,
          fontSize: 12.w,
        ),
      ),
    );
  }
}
