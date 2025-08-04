import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../model/mine/record_model.dart';
import 'recharge_record_page_controller.dart';

class RechargeRecordPage extends GetView<RechargeRecordPageController> {
  const RechargeRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(() => Text(controller.type.value == 2 ? "购买记录" : "金币记录"))),
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
          builderDelegate: PagedChildBuilderDelegate<RecordModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, value, index) => _buildItemView(value),
          ),
          separatorBuilder: (context, index) => 10.verticalSpace,
        ));
  }

  _buildItemView(RecordModel item) {
    String payIcon = AppImagePath.app_default_pay_balance;
    switch (item.payType) {
      case 0:
        payIcon = AppImagePath.app_default_pay_balance;
        break;
      case 1:
        payIcon = AppImagePath.app_default_pay_ali;
        break;
      case 2:
        payIcon = AppImagePath.app_default_pay_wechat;
        break;
      case 3:
        payIcon = AppImagePath.app_default_pay_ysf;
        break;
      default:
        payIcon = AppImagePath.app_default_pay_balance;
    }
    return AppBgView(
      height: 80.w,
      radius: 6.w,
      backgroundColor: COLOR.white.withValues(alpha: 0.1),
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(src: payIcon, width: 36.w, height: 36.w),
          10.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.title ?? "",
                  fontSize: 15.w,
                  color: COLOR.white,
                  fontWeight: FontWeight.w500,
                ),
                TextView(
                  text: '订单编号：${item.tradeNo ?? ""}',
                  fontSize: 11.w,
                  color: COLOR.white.withValues(alpha: 0.6),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                text: "${item.amount ?? 0}",
                fontSize: 16.w,
                color: COLOR.white,
                fontWeight: FontWeight.w600,
              ),
              5.verticalSpace,
              TextView(
                text:
                    Utils.dateFormat(item.createdAt ?? "", precision: 'minute'),
                fontSize: 11.w,
                color: COLOR.color_999999,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
