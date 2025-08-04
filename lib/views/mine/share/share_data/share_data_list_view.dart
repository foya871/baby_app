import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/image_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../components/text_view.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/mine/proxy_record_model.dart';
import '../../../../model/mine/share_record_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/utils.dart';
import 'share_data_list_controller.dart';

class ShareDataListPage extends GetView<ShareDataListController> {
  const ShareDataListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('推广明细')),
      body: Column(
        children: [
          10.verticalSpace,
          Row(
            children: [
              TextView(
                text: '我的推广人数：',
                fontSize: 14.w,
                color: COLOR.white,
                fontWeight: FontWeight.w600,
              ),
              Obx(() => TextView(
                    text: '${controller.userService.user.inviteUserNum ?? 0}',
                    fontSize: 16.w,
                    color: COLOR.themeSelectedColor,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ).marginHorizontal(10.w),
          20.verticalSpace,
          Expanded(child: _buildBodyView()),
        ],
      ),
    );
  }

  _buildBodyView() {
    return EasyRefresh(
        controller: controller.refreshController,
        refreshOnStart: true,
        onRefresh: () async {
          controller.getHttpData(isRefresh: true);
        },
        onLoad: () async {
          controller.getHttpData(isRefresh: false);
        },
        child: PagedListView.separated(
          pagingController: controller.pagingController,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          builderDelegate: PagedChildBuilderDelegate<ProxyRecordModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, value, index) => _buildItemView(value),
          ),
          separatorBuilder: (context, index) => 15.verticalSpace,
        ));
  }

  _buildItemView(ProxyRecordModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageView(
          src: item.ownerLogo ?? "",
          width: 54.w,
          height: 54.w,
          borderRadius: BorderRadius.circular(27.5.w),
          defaultPlace: AppImagePath.app_default_avatar,
        ),
        7.horizontalSpace,
        TextView(
          text: item.ownerNickName ?? "",
          color: COLOR.white,
          fontSize: 15.w,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        TextView(
          text: Utils.dateFmtWith(
            item.createdAt ?? "",
            ['yyyy', '.', 'mm', '.', 'dd'],
          ),
          fontSize: 14.w,
          color: COLOR.white.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}
