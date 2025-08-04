import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/app_bg_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../components/text_view.dart';
import '../../../../model/mine/buy_dynamic.dart';
import '../../../../utils/color.dart';
import '../../../../utils/utils.dart';
import 'income_details_page_controller.dart';

class IncomeDetailsPage extends GetView<IncomeDetailsPageController> {
  const IncomeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("购买详情")),
      body: _buildBodyView(),
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
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          builderDelegate: PagedChildBuilderDelegate<BuyDynamic>(
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

  _buildItemView(BuyDynamic item) {
    return AppBgView(
      height: 69.w,
      radius: 6.w,
      backgroundColor: COLOR.white_10,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.nickName ?? "",
                  fontSize: 13.w,
                  color: COLOR.white,
                  maxLines: 1,
                ),
                4.verticalSpace,
                TextView(
                  text: Utils.dateFmtWith(
                    item.createdAt ?? "",
                    [
                      'yyyy',
                      '-',
                      'mm',
                      '-',
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
              ],
            ),
          ),
          15.horizontalSpace,
          TextView(
            text: "+${item.amount ?? 0}",
            fontSize: 16.w,
            color: COLOR.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
