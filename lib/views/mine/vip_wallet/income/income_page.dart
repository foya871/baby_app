import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../model/community/community_model.dart';
import '../../../../model/mine/profit_dynamic_item_model.dart';
import '../../../../routes/routes.dart';
import 'income_page_controller.dart';

class IncomePage extends GetView<IncomePageController> {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的收益')),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        _buildHeadView(),
        20.verticalSpace,
        TextView(
          text: "帖子收益",
          color: COLOR.white,
          fontSize: 16.w,
          fontWeight: FontWeight.w500,
        ),
        10.verticalSpace,
        Expanded(child: _buildListView()),
      ],
    ).marginHorizontal(10.w);
  }

  _buildHeadView() {
    return AppBgView(
      height: 90.w,
      radius: 6.w,
      backgroundColor: COLOR.white.withValues(alpha: 0.09),
      border: Border.all(color: COLOR.white.withValues(alpha: 0.21), width: 1),
      child: Obx(() => Row(
            children: [
              Expanded(
                  child: _buildHeadItemView(
                      '今日收益 (金币)',
                      (controller.promoteIncomeStat.value
                                  .todayPromoteBalanceTotal ??
                              0)
                          .toDouble())),
              Container(
                color: COLOR.color_F5F5F5,
                height: 60.w,
                width: 1,
              ),
              Expanded(
                  child: _buildHeadItemView(
                      '总收益 (金币)',
                      (controller.promoteIncomeStat.value.promoteBalanceTotal ??
                              0)
                          .toDouble())),
            ],
          )),
    );
  }

  _buildHeadItemView(String title, double number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
          text: title,
          color: COLOR.white,
          fontSize: 13.w,
        ),
        10.verticalSpace,
        TextView(
          text: Utils.numFmt(number.toInt()),
          color: COLOR.white,
          fontSize: 20.w,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  _buildListView() {
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
          padding: EdgeInsets.zero,
          builderDelegate: PagedChildBuilderDelegate<ProfitDynamicItemModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, value, index) => _buildItemView(value),
          ),
          separatorBuilder: (context, index) => 8.verticalSpace,
        ));
  }

  _buildItemView(ProfitDynamicItemModel item) {
    return AppBgView(
      height: 79.w,
      radius: 6.w,
      backgroundColor: COLOR.white_10,
      onTap: () => Get.toNamed(Routes.mineIncomeDetails, arguments: item.id),
      padding: EdgeInsets.all(8.3.w),
      child: Row(
        children: [
          ImageView(
            src: item.image ?? '',
            width: 62.w,
            height: 62.w,
            borderRadius: BorderRadius.circular(4.w),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.name ?? '',
                  fontSize: 13.w,
                  color: COLOR.white,
                  maxLines: 1,
                ),
                4.verticalSpace,
                TextView(
                  text: Utils.dateFmt(
                    item.createdAt ?? "",
                    [
                      'yyyy',
                      '.',
                      'mm',
                      '.',
                      'dd',
                      ' ',
                      'HH',
                      ':',
                      'nn',
                      ':',
                      'ss'
                    ],
                  ),
                  fontSize: 11.w,
                  color: COLOR.white_60,
                ),
                3.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextView(
                      text: "收益：",
                      fontSize: 11.w,
                      color: COLOR.white_60,
                    ),
                    TextView(
                      text: "${item.gold ?? 0}",
                      fontSize: 11.w,
                      color: COLOR.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.horizontalSpace,
          TextView(
            text: "购买详情>",
            fontSize: 12.w,
            color: COLOR.white,
          ),
        ],
      ),
    );
  }
}
