import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/rich_text_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/pay/model/gold_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/ad_jump.dart';
import '../../../utils/color.dart';
import 'wallet_page_controller.dart';

class WalletPage extends GetView<WalletPageController> {
  final bool isDialog;

  const WalletPage({super.key, this.isDialog = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDialog ? null : _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  if (!isDialog) ...[
                    _buildAppBarView(),
                    20.verticalSpace,
                  ],
                  _buildBodyView(),
                  50.verticalSpace,
                ],
              ),
            ),
          ),
          _buildBottomView(),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: COLOR.color_0e141e,
      title: TextView(
        text: "金币充值",
        fontSize: 18.w,
        color: COLOR.white,
      ),
      actions: [
        TextView(
          text: "记录",
          fontSize: 14.w,
          color: COLOR.white,
        ).onOpaqueTap(() {
          Get.toNamed(Routes.mineRechargeRecord, arguments: 3);
        }),
        15.horizontalSpace,
      ],
    );
  }

  _buildAppBarView() {
    return AppBgView(
      radius: 12.w,
      backgroundColor: COLOR.white.withValues(alpha: 0.09),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.verticalSpace,
          TextView(
            text: "我的余额",
            color: COLOR.white,
            fontSize: 15.w,
          ).paddingHorizontal(15.w),
          15.verticalSpace,
          Row(
            children: [
              ImageView(
                src: AppImagePath.mine_vip_gold,
                width: 24.w,
                height: 24.w,
              ),
              5.horizontalSpace,
              Obx(() => TextView(
                    text: "${controller.userService.assets.gold ?? 0}",
                    color: COLOR.white,
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              AppBgView(
                width: 76.w,
                height: 34.w,
                radius: 17.w,
                backgroundColor: COLOR.themeSelectedColor,
                text: "提现",
                textColor: COLOR.white,
                textSize: 14.w,
                onTap: () => Get.toNamed(Routes.withdraw),
              )
            ],
          ).paddingHorizontal(15.w),
          20.verticalSpace,
          AppBgView(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.w),
              bottomRight: Radius.circular(12.w),
            ),
            backgroundColor: COLOR.white.withValues(alpha: 0.2),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            onTap: () => Get.toNamed(Routes.mineMyIncome),
            child: Row(
              children: [
                ImageView(
                  src: AppImagePath.mine_vip_icon_income,
                  width: 20.w,
                  height: 20.w,
                ),
                5.horizontalSpace,
                TextView(text: "我的收益", color: COLOR.white, fontSize: 15.w),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: COLOR.white,
                  size: 12.w,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBodyView() {
    return Column(
      children: [
        Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.goldList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14.w,
                crossAxisSpacing: 7.w,
                childAspectRatio: 106.w / 130.w,
              ),
              itemBuilder: (context, index) {
                final item = controller.goldList[index];
                return _buildItemView(item);
              },
            )),
        20.verticalSpace,
        RichTextView(
          text: "温馨提示：\n"
              "如提示 *交易失败* 和 *账户风险* 等，可重新发起订单，或在15分钟后重新支付，如支付未到帐，请反馈 在线客服",
          specifyTexts: const ["在线客服"],
          style: TextStyle(fontSize: 12.w, color: COLOR.color_999999),
          highlightStyle:
              TextStyle(fontSize: 12.w, color: COLOR.themeSelectedColor),
          onTap: (value) => kOnLineService(),
          maxLines: 4,
        ),
      ],
    ).marginHorizontal(15.w);
  }

  _buildItemView(GoldModel item) {
    return Obx(
      () => AppBgView(
        width: 106.w,
        height: 130.w,
        radius: 10.w,
        imagePath: controller.currentGoldCard.value == item
            ? AppImagePath.mine_vip_wallet_check_bg
            : AppImagePath.mine_vip_wallet_uncheck_bg,
        fit: BoxFit.fill,
        onTap: () {
          controller.currentGoldCard.value = item;
        },
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageView(
                    src: AppImagePath.mine_vip_gold,
                    width: 24.w,
                    height: 24.w,
                  ),
                  7.verticalSpace,
                  TextView(
                    text: "${item.goldNum ?? 0}金币",
                    fontSize: 14.w,
                    color: COLOR.white,
                  ),
                  5.verticalSpace,
                  TextView(
                    text: "售价${item.price ?? 0}",
                    fontSize: 12.w,
                    color: COLOR.white.withValues(alpha: 0.5),
                  ),
                ],
              ),
              if (item.freeGoldNum != null && item.freeGoldNum! > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: AppBgView(
                    height: 18.w,
                    backgroundColor: COLOR.themeSelectedColor,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w),
                    ),
                    text: '送${item.freeGoldNum ?? 0}金币',
                    textColor: COLOR.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomView() {
    return Column(
      children: [
        Obx(() => AppBgView(
              backgroundColor: COLOR.themeSelectedColor,
              height: 40.w,
              radius: 20.w,
              text: "¥${controller.currentGoldCard.value.price ?? 0} 立即支付",
              onTap: () {
                controller.statPay();
              },
            )),
        15.verticalSpace,
        RichTextView(
          text: "如有问题请联系 在线客服",
          specifyTexts: const ["在线客服"],
          style: TextStyle(fontSize: 12.w, color: COLOR.color_999999),
          highlightStyle:
              TextStyle(fontSize: 12.w, color: COLOR.themeSelectedColor),
          onTap: (value) => kOnLineService(),
        ),
        30.verticalSpace,
      ],
    ).marginHorizontal(15.w);
  }
}
