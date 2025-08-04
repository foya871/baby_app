import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_multiple_view.dart';
import 'package:baby_app/utils/app_utils.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../components/app_bg_view.dart';
import '../../components/image_view.dart';
import '../../components/text_view.dart';
import '../../generate/app_image_path.dart';
import 'mine_page_controller.dart';

class MinePage extends GetView<MinePageController> {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.scaffoldBg,
      body: Column(
        children: [
          SizedBox(
            child: VisibilityDetector(
              key: const ValueKey("mine_page"),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 1.0) {
                  controller.userService.updateAll();
                }
              },
              child: Container(height: 1, color: COLOR.transparent),
            ),
          ),
          Expanded(child: _buildView()),
        ],
      ),
      floatingActionButton: ImageView(
        src: AppImagePath.mine_icon_ai,
        width: 80.w,
      ).onOpaqueTap(() => controller.onClick("AI")),
    );
  }

  _buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeadView(),
          10.verticalSpace,
          Column(
            children: [
              ///我的帖子、我的收藏、我的关注、原创入驻
              _buildCenterView(),
              10.verticalSpace,
              const AdMultipleView.smallIcons(
                type: AdApiType.INSERT_ICON,
              ),
              10.verticalSpace,

              ///底部
              _buildBottomView(),
              10.verticalSpace,
              // Obx(() => TextView(
              //       text: "我的邀请码：${controller.userService.user.inviteCode}",
              //       fontSize: 13.w,
              //       color: COLOR.white,
              //     )),
              // 5.verticalSpace,
              // Obx(() => TextView(
              //       text: "永久官方地址：${controller.permanentAddress.value}",
              //       fontSize: 11.w,
              //       color: COLOR.white.withValues(alpha: 0.5),
              //     )),
            ],
          ).marginHorizontal(10.w),
          35.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildHeadView() {
    return AppBgView(
      imagePath: AppImagePath.mine_head_bg,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: COLOR.transparent,
            shadowColor: COLOR.transparent,
            actions: [
              const Spacer(),
              ImageView(
                src: AppImagePath.mine_message,
                width: 30.w,
                height: 30.w,
              ).onOpaqueTap(() => controller.onClick("消息中心")),
              15.horizontalSpace,
              ImageView(
                src: AppImagePath.mine_icon_setting,
                width: 30.w,
                height: 30.w,
              ).onOpaqueTap(() => controller.onClick("设置")),
            ],
          ),

          ///用户信息
          _buildUserInfoView(),
          20.verticalSpace,

          ///VIP
          // Obx(() =>
          AppBgView(
            width: double.infinity,
            height: 70.w,
            imagePath: AppImagePath.mine_vip_bg,
            fit: BoxFit.fill,
            onTap: () => controller.onClick("VIP"),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 15.w),
            // child: ImageView(
            //   src: controller.userService.isVIP
            //       ? AppImagePath.mine_vip_open_buy_button
            //       : AppImagePath.mine_vip_open_buy_button,
            //   height: 26.w,
            // ),
            // ),
          ),
          10.verticalSpace,

          ///金币、分享、任务
          Row(
            children: [
              Obx(() => _buildTopItemView(AppImagePath.mine_icon_gold, "金币充值",
                  "当前余额:${controller.userService.assets.gold ?? 0}")),
              6.horizontalSpace,
              _buildTopItemView(
                  AppImagePath.mine_icon_share, "分享邀请", "邀请好友可领VIP"),
              6.horizontalSpace,
              _buildTopItemView(AppImagePath.mine_icon_task, "福利任务", "每日签到赚积分"),
            ],
          ),
        ],
      ),
    );
  }

  ///用户信息
  _buildUserInfoView() {
    return Row(
      children: [
        Obx(() => ImageView(
              src: "${controller.userService.user.logo}",
              width: 65.w,
              height: 65.w,
              borderRadius: BorderRadius.circular(33.w),
              defaultPlace: AppImagePath.app_default_avatar,
            )),
        10.horizontalSpace,
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(() => TextView(
                      text: controller.userService.user.nickName ?? '游客0000',
                      fontSize: 16.w,
                      color: COLOR.white,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                5.horizontalSpace,
                Obx(() => AppUtils.getVipTypeToImagePath(
                            controller.userService.user.vipType ?? 0)
                        .isEmpty
                    ? const SizedBox.shrink()
                    : ImageView(
                        src: AppUtils.getVipTypeToImagePath(
                            controller.userService.user.vipType ?? 0),
                        height: 16.w,
                        borderRadius: BorderRadius.circular(33.w),
                        defaultPlace: AppImagePath.app_default_avatar,
                      )),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Obx(() => TextView(
                      text: "ID:${controller.userService.user.userId}",
                      fontSize: 12.w,
                      color: COLOR.white.withValues(alpha: 0.5),
                    )),
                5.horizontalSpace,
                // ImageView(
                //   src: AppImagePath.mine_icon_copy,
                //   width: 15.w,
                //   height: 15.w,
                // ).onOpaqueTap(() => controller.onClick("复制")),
              ],
            ),
          ],
        )),
        15.horizontalSpace,
        Obx(() => controller.userService.user.account != null &&
                controller.userService.user.account!.isNotEmpty
            ? Container(
                padding: EdgeInsets.all(5.w),
                color: Colors.transparent,
                child: Row(
                  children: [
                    TextView(
                        text: "账号凭证",
                        fontSize: 13.w,
                        color: COLOR.color_f5e5bf),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 13.w,
                      color: COLOR.color_f5e5bf,
                    ),
                  ],
                ),
              ).onOpaqueTap(() {
                controller.onClick("账号凭证");
              })
            : const SizedBox.shrink()),
      ],
    ).onOpaqueTap(() => controller.onClick("编辑资料"));
  }

  _buildTopItemView(String imagePath, String title, String text) {
    return Expanded(
      child: AppBgView(
        height: 141.w,
        imagePath: AppImagePath.mine_gold_share_task_bg,
        fit: BoxFit.fill,
        child: Column(
          children: [
            ImageView(
              src: imagePath,
              width: 78.w,
            ),
            3.verticalSpace,
            TextView(
              text: title,
              fontSize: 13.w,
              color: COLOR.white,
              fontWeight: FontWeight.w500,
            ),
            2.verticalSpace,
            TextView(
              text: text,
              fontSize: 11.w,
              color: COLOR.color_f5e5bf,
            ),
          ],
        ),
        onTap: () => controller.onClick(title),
      ),
    );
  }

  ///我的帖子、我的收藏、我的关注、原创入驻
  _buildCenterView() {
    return AppBgView(
      backgroundColor: COLOR.color_161e2c,
      radius: 8.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Row(
        children: controller.list1.map((item) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageView(
                  src: item.item1,
                  width: 35.w,
                  height: 35.w,
                ),
                5.verticalSpace,
                TextView(
                  text: item.item2,
                  fontSize: 12.w,
                  color: COLOR.white,
                ),
              ],
            ).onOpaqueTap(() => controller.onClick(item.item2)),
          );
        }).toList(),
      ),
    );
  }

  _buildBottomView() {
    return AppBgView(
      radius: 12.w,
      backgroundColor: COLOR.white.withValues(alpha: 0.05),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        itemCount: controller.list2.length,
        itemBuilder: (context, index) {
          final item = controller.list2[index];
          return _buildBottomItemView(item);
        },
        separatorBuilder: (context, index) => Container(
          color: COLOR.white.withValues(alpha: 0.1),
          height: 1,
        ),
      ),
    );
  }

  _buildBottomItemView(Tuple2 item) {
    return SizedBox(
      height: 50.w,
      child: Row(
        children: [
          ImageView(src: item.item1, width: 30.w, height: 30.w),
          7.horizontalSpace,
          Expanded(
            child: TextView(
              text: item.item2,
              fontSize: 13.w,
              color: COLOR.white,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15.w,
            color: COLOR.color_999999,
          ),
        ],
      ).onOpaqueTap(() => controller.onClick(item.item2)),
    );
  }
}
