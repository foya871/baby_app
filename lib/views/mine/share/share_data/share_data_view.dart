import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/image_view.dart';
import '../../../../components/text_view.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/user/Proxy_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import 'share_data_controller.dart';

class ShareDataPage extends StatelessWidget {
  ShareDataPage({super.key});

  final ShareDataController controller = Get.put(ShareDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('推广数据'),
        actions: [
          TextView(
            text: '明细',
            color: COLOR.white,
            fontSize: 14.w,
          ).onOpaqueTap(() => Get.toNamed(Routes.minePromotion)),
          10.horizontalSpace,
        ],
      ),
      body: GetBuilder<ShareDataController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Container(
                height: 128.w,
                padding: EdgeInsets.only(top: 20.w, left: 10.w, right: 10.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImagePath.ann_share_top_bg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextView(
                                text: '可提现金额',
                                color: COLOR.color_6b2020,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600),
                            1.verticalSpace,
                            TextView(
                                text: '${controller.proxyData.value.bala}',
                                color: COLOR.color_6b2020,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.w,
                        height: 46.w,
                        color: COLOR.color_8d4a41,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextView(
                                text: '总收益金额',
                                color: COLOR.color_6b2020,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600),
                            1.verticalSpace,
                            TextView(
                                text:
                                    '${controller.proxyData.value.promoteBalanceTotal}',
                                color: COLOR.color_6b2020,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                    ]),
                    16.verticalSpace,
                    ImageView(
                            src: AppImagePath.ann_tixian_cur,
                            width: 235.w,
                            height: 34.w,
                            fit: BoxFit.fill)
                        .onOpaqueTap(() => Get.toNamed(Routes.withdraw)),
                  ],
                ),
              ),
              _buildTwoInfo(),
              _buildBottomView(),
            ],
          ),
        );
      }),
    );
  }

  _buildTwoInfo() {
    ProxyModel model = controller.proxyData.value;
    return Container(
      height: 160.w,
      padding: EdgeInsets.only(top: 16.w, bottom: 24.w),
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        color: COLOR.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _buildDataView(
                      '当月收益(元)', model.monthPromoteBalanceTotal)),
              Expanded(
                  child: _buildDataView('当月推广数', model.monthPromotePersonNum)),
            ],
          ),
          // 26.verticalSpace,
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: _buildDataView(
                      '今日收益(元)', model.todayPromoteBalanceTotal)),
              Expanded(
                  child: _buildDataView('今日推广数', model.todayPromotePersonNum)),
            ],
          ),
        ],
      ),
    );
  }

  _buildBottomView() {
    return Container(
      height: 100.w,
      padding: EdgeInsets.only(top: 24.w),
      decoration: BoxDecoration(
        color: COLOR.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        children: [
          Expanded(
              child: _buildDataView(
                  '累计推广用户', controller.proxyData.value.promoteTotalPersonNum)),
          Expanded(
              child: _buildDataView(
                  '累计付费用户', controller.proxyData.value.promotePersonPayNum)),
        ],
      ),
    );
  }

  _buildDataView(String title, int? value) {
    return Column(
      children: [
        TextView(
          text: value?.toString() ?? '0',
          color: COLOR.white,
          fontSize: 20.w,
          fontWeight: FontWeight.bold,
        ),
        TextView(
          text: title,
          color: COLOR.white.withValues(alpha: 0.6),
          fontSize: 14.w,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
