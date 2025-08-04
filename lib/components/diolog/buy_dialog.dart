import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/mine/vip_wallet/vip_page.dart';
import 'package:baby_app/views/mine/vip_wallet/wallet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../views/mine/vip_wallet/vip_page_controller.dart';
import '../../views/mine/vip_wallet/wallet_page_controller.dart';
import '../image_view.dart';
import '../text_view.dart';

enum BuyType {
  vip, // VIP对话框
  gold, // 金币对话框
}

showBuyVIPWattleDialog({
  required BuyType type,
}) {
  if (type == BuyType.vip) {
    Get.lazyPut(() => VipPageController());
  } else if (type == BuyType.gold) {
    Get.lazyPut(() => WalletPageController());
  }

  if (Get.isBottomSheetOpen == true) return;
  Get.bottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: COLOR.color_13141F,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.w),
            topRight: Radius.circular(12.w),
          ),
        ),
        child: Column(
          children: [
            20.verticalSpace,
            Row(
              children: [
                14.horizontalSpace,
                Icon(
                  CupertinoIcons.clear,
                  size: 20.w,
                  color: COLOR.transparent,
                ),
                const Spacer(),
                Row(
                  children: [
                    ImageView(
                        src: type == BuyType.vip
                            ? AppImagePath.mine_vip_icon_vip
                            : AppImagePath.mine_vip_gold,
                        width: 22.w,
                        height: 22.w),
                    TextView(
                      text: type == BuyType.vip ? "请开通会员卡" : "请购买金币",
                      fontSize: 17.w,
                      color: COLOR.color_fee900,
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.clear,
                  size: 20.w,
                  color: COLOR.color_999999,
                ).onOpaqueTap(() {
                  Get.back();
                }),
                14.horizontalSpace,
              ],
            ),
            if (type == BuyType.gold) ...[
              30.verticalSpace,
              TextView(
                text:
                    "当前余额：${Get.find<WalletPageController>().userService.assets.gold ?? 0}",
                fontSize: 15.w,
                color: COLOR.white,
                fontWeight: FontWeight.w500,
              ),
              24.verticalSpace,
              Container(
                width: double.infinity,
                height: 1.w,
                color: COLOR.white.withValues(alpha: 0.1),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
              ),
            ],
            20.verticalSpace,
            Expanded(
                child: type == BuyType.vip
                    ? const VipPage(isDialog: true)
                    : const WalletPage(isDialog: true)),
          ],
        ),
      ));
}
