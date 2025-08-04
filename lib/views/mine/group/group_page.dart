import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/app_bg_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../components/text_view.dart';
import '../../../../utils/color.dart';
import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/mine/official_community_model.dart';
import '../../../utils/ad_jump.dart';
import 'group_page_controller.dart';

class GroupPage extends GetView<GroupPageController> {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("官方交流群")),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return PagedListView.separated(
      pagingController: controller.pagingController,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      builderDelegate: PagedChildBuilderDelegate<OfficialCommunityModel>(
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
        noItemsFoundIndicatorBuilder: (context) => const NoData(),
        itemBuilder: (context, value, index) => _buildItemView(value),
      ),
      separatorBuilder: (context, index) => 10.verticalSpace,
    );
  }

  _buildItemView(OfficialCommunityModel item) {
    return AppBgView(
      height: 70.w,
      radius: 10.w,
      backgroundColor: COLOR.white.withValues(alpha: 0.1),
      padding: EdgeInsets.only(left: 14.w, right: 10.w),
      child: Row(
        children: [
          ImageView(
            src: AppImagePath.app_default_telegram,
            width: 42.w,
            height: 42.w,
            borderRadius: BorderRadius.circular(21.w),
          ),
          10.horizontalSpace,
          Expanded(
            child: TextView(
              text: item.name ?? '',
              fontSize: 14.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
              maxLines: 1,
            ),
          ),
          10.horizontalSpace,
          AppBgView(
            width: 70.w,
            height: 32.w,
            radius: 16.w,
            backgroundColor: COLOR.themeSelectedColor,
            text: "加群",
            textSize: 13.w,
            textColor: COLOR.white,
            onTap: () => jumpExternalURL(item.link ?? ""),
          )
        ],
      ),
    );
  }
}
