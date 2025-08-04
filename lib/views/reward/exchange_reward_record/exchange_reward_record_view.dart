import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/model/reward/reward_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data_list_view.dart';
import 'exchange_reward_record_controller.dart';

class ExchangeRewardRecordPage extends GetView<ExchangeRewardRecordController> {
  const ExchangeRewardRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('兑换记录'),
      ),
      body: BaseRefreshSimpleWidget(
        controller,
        child: Obx(() {
          return NoDataListView.builder(
              noData: controller.dataInited,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                var model = controller.data[index];
                return recordCell(model);
              });
        }),
      ),
    );
  }

  Widget recordCell(RewardModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: COLOR.white_10, borderRadius: BorderRadius.circular(8.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: model.rewardName ?? "",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.white,
                ),
                2.verticalSpace,
                TextView(
                  text: Utils.dateFmt(model.rewardTime ?? ""),
                  fontSize: 12.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.color_999999,
                ),
              ],
            ),
          ),
          TextView(
            text: model.giftNumTrans,
            fontSize: 15.w,
            fontWeight: FontWeight.w500,
            color: COLOR.white,
          ),
        ],
      ),
    ).marginBottom(10.w);
  }
}
