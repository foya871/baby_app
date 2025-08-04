import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad_banner/insert_ad.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/rich_text_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/ad_jump.dart';
import '../../../utils/color.dart';
import 'vip_page_controller.dart';

class VipPage extends GetView<VipPageController> {
  final bool isDialog;

  const VipPage({super.key, this.isDialog = false});

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
                  if (!isDialog) _buildHeadView(),
                  10.verticalSpace,
                  _buildCardView(),
                  15.verticalSpace,
                  Container(
                      color: COLOR.white.withValues(alpha: 0.1), height: 1),
                  15.verticalSpace,
                  InsertAd(
                    height: 70.w,
                    adress: AdApiType.INSERT_ICON,
                  ),
                  20.verticalSpace,
                  TextView(text: "会员特权", fontSize: 15.w, color: COLOR.white),
                  10.verticalSpace,
                  _buildVipDescView(),
                  20.verticalSpace,
                  if (!isDialog) _buildPointsRedemptionView(),
                ],
              ).marginHorizontal(15.w),
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
        text: "会员中心",
        fontSize: 18.w,
        color: COLOR.white,
      ),
      actions: [
        TextView(
          text: "记录",
          fontSize: 14.w,
          color: COLOR.white,
        ).onOpaqueTap(() {
          Get.toNamed(Routes.mineRechargeRecord, arguments: 2);
        }),
        15.horizontalSpace,
      ],
    );
  }

  _buildHeadView() {
    return Column(
      children: [
        10.verticalSpace,
        Obx(() => Row(
              children: [
                ImageView(
                  src: controller.userService.user.logo ?? '',
                  width: 56.w,
                  height: 56.w,
                  defaultPlace: AppImagePath.app_default_avatar,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: controller.userService.user.nickName ?? '',
                      fontSize: 16.w,
                      color: COLOR.white,
                      fontWeight: FontWeight.w500,
                    ),
                    5.verticalSpace,
                    TextView(
                      text: controller.userService.isVIP
                          ? "剩余可下载次数 ${controller.userService.user.downloadNum ?? 0}"
                          : "开通会员免费看大片 剩余可下载次数 ${controller.userService.user.downloadNum ?? 0}",
                      fontSize: 12.w,
                      color: COLOR.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ],
            )),
        20.verticalSpace,
        Row(
          children: [
            TextView(
              text: "开通VIP享特权",
              fontSize: 15.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            TextView(
              text: "早买早享受",
              fontSize: 15.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }

  _buildCardView() {
    return SizedBox(
      height: 150.h,
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: controller.vipList.length,
          itemBuilder: (context, index) {
            final item = controller.vipList[index];
            return Obx(() => Stack(
                  children: [
                    ImageView(
                      src: item.activityImg ?? '',
                      width: 128.w,
                      height: 150.h,
                      borderRadius: BorderRadius.circular(8.w),
                      fit: BoxFit.fill,
                    ),
                    if (controller.currentVipCard.value != item)
                      ImageView(
                        src: AppImagePath.mine_vip_card_uncheck_bg,
                        width: 128.w,
                        height: 150.h,
                        borderRadius: BorderRadius.circular(8.w),
                        fit: BoxFit.fill,
                      ),
                  ],
                ).onOpaqueTap(() {
                  controller.currentVipCard.value = item;
                  controller.currentIndex = index;
                }));
          },
          separatorBuilder: (context, index) => 10.horizontalSpace,
        ),
      ),
    );
  }

  _buildVipDescView() {
    return Obx(() => ImageView(
          src: controller.currentVipCard.value.activityImg1 ?? "",
          width: double.infinity,
          defaultPlace: AppImagePath.app_default_placeholder_v,
        ));
  }

  _buildPointsRedemptionView() {
    return Column(
      children: [
        Row(
          children: [
            TextView(
              text: "积分兑换",
              fontSize: 15.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            TextView(
              text: "当前积分${controller.userService.user.userPoints ?? 0}",
              fontSize: 15.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        10.verticalSpace,
        SizedBox(
          height: 120.h,
          child: Obx(() => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.pointList.length,
                itemBuilder: (context, index) {
                  final item = controller.pointList[index];
                  return Column(
                    children: [
                      AppBgView(
                        width: 84.w,
                        height: 78.h,
                        radius: 8.w,
                        imagePath: AppImagePath.mine_vip_integral_bg,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextView(
                              text: item.desc ?? "",
                              fontSize: 13.w,
                              color: COLOR.color_6c2a2a,
                              fontWeight: FontWeight.w500,
                            ),
                            3.verticalSpace,
                            TextView(
                              text: "${item.redemptionIntegral ?? 0}积分",
                              fontSize: 15.w,
                              color: COLOR.color_6c2a2a,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      AppBgView(
                        width: 62.w,
                        height: 28.w,
                        radius: 14.w,
                        backgroundColor: COLOR.white.withValues(alpha: 0.2),
                        text: "兑换",
                        textColor: COLOR.white,
                        onTap: () {
                          controller.exchangePoint(item);
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => 8.horizontalSpace,
              )),
        ),
        20.verticalSpace,
      ],
    );
  }

  _buildBottomView() {
    return Column(
      children: [
        Obx(() => AppBgView(
              backgroundColor: COLOR.themeSelectedColor,
              height: 40.w,
              radius: 20.w,
              text: "¥${controller.currentVipCard.value.disPrice ?? 0} 立即支付",
              onTap: () => controller.statPay(),
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
