import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/model/mine/redeem_vip_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';

import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/text_view.dart';
import '../../../utils/color.dart';
import 'exchange_record_page_controller.dart';

class ExchangeRecordPage extends GetView<ExchangeRecordPageController> {
  const ExchangeRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('兑换记录'),
      ),
      body: Column(
        children: [
          15.verticalSpace,
          _buildTitleView('兑换日期', '到期日期', '兑换奖品'),
          8.verticalSpace,
          Container(height: 1, color: COLOR.white.withValues(alpha: 0.1)),
          10.verticalSpace,
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
          padding: EdgeInsets.zero,
          builderDelegate: PagedChildBuilderDelegate<RedeemVipModel>(
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

  _buildTitleView(String item1, String item2, String item3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildTitleItemView(item1)),
        Expanded(child: _buildTitleItemView(item2)),
        Expanded(child: _buildTitleItemView(item3)),
      ],
    ).marginHorizontal(15.w);
  }

  _buildItemView(RedeemVipModel item) {
    return Row(
      children: [
        Expanded(child: _buildItemTextView(Utils.dateFmt(item.usedTime ?? ""))),
        Expanded(
            child: _buildItemTextView(Utils.dateFmt(item.enableEndTime ?? ""))),
        Expanded(child: _buildItemTextView(item.cardName ?? "")),
      ],
    );
  }

  _buildTitleItemView(String text) {
    return Center(
      child: TextView(
        text: text,
        fontSize: 14.w,
        color: COLOR.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _buildItemTextView(String text) {
    return Center(
      child: TextView(
        text: text,
        fontSize: 13.w,
        color: COLOR.white,
      ),
    );
  }
}
