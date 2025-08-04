import 'package:baby_app/components/short_widget/video_base_cell.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:baby_app/app_prepare.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/rich_text_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/reward/reward_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../utils/enum.dart';
import 'reward_task_controller.dart';

class RewardTaskPage extends StatelessWidget {
  const RewardTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardTaskController controller = Get.put(RewardTaskController());
    return VisibilityDetector(
      key: const ValueKey("RewardTaskPage"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1.0) {
          controller.refreshTop();
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOpenVip(controller),
              _buildBottomVip(controller),
              _buildTask(controller),
              _buildPoint(controller),
              _buildVideo(controller),
              26.verticalSpace,
            ],
          );
        }),
      ),
    );
  }

  _buildOpenVip(RewardTaskController controller) {
    return Obx(() {
      return controller.haveDuct.value
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Container(
                    width: 1.sw,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
                    decoration: BoxDecoration(
                        border: Border.all(color: COLOR.color_b48857),
                        borderRadius: BorderRadius.circular(8.w),
                        color: COLOR.color_161a34),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                                text: '新人限时特惠',
                                fontSize: 14.w,
                                fontWeight: FontWeight.w500,
                                color: COLOR.color_e3c890),
                            Obx(() {
                              return TextView(
                                  text: controller.countDownTime.value,
                                  fontSize: 11.w,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR.white);
                            }),
                          ],
                        ),
                        const Spacer(),
                        ImageView(
                          src: AppImagePath.reward_icon_open_vip,
                          height: 26.w,
                          width: 82.w,
                        )
                      ],
                    ),
                  ),
                  6.verticalSpace,
                ],
              ).onOpaqueTap(Get.toVip),
            )
          : const SizedBox.shrink();
    });
  }

  _buildBottomVip(RewardTaskController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
            decoration: BoxDecoration(
                border: Border.all(color: COLOR.color_b48857),
                borderRadius: BorderRadius.circular(8.w),
                color: COLOR.color_161a34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ImageView(
                      src: AppImagePath.reward_icon_open_vip_top,
                      width: 24.w,
                      height: 18.w,
                    ),
                    4.horizontalSpace,
                    RichTextView(
                      text: "开通至尊全网通会员预计年省2000元",
                      specifyTexts: const ['至尊全网通会员', '2000元'],
                      style: TextStyle(fontSize: 14.w, color: COLOR.white),
                      highlightStyle:
                          TextStyle(fontSize: 14.w, color: COLOR.color_e3c890),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: RewardTopVip.values
                        .map((item) => _buildTop(item, controller))
                        .toList()),
                10.verticalSpace,
              ],
            ),
          ),
        ],
      ).onOpaqueTap(Get.toVip),
    );
  }

  _buildTask(RewardTaskController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        TextView(
          text: '日常任务',
          fontSize: 16.w,
          fontWeight: FontWeight.w500,
        ),
        8.verticalSpace,
        RichTextView(
          text: "邀请人数${controller.userInviteNum}人，我的积分${controller.userPoints}",
          specifyTexts: [
            controller.userInviteNum.toString(),
            controller.userPoints.toString()
          ],
          style: TextStyle(fontSize: 13.w, color: COLOR.white),
          highlightStyle: TextStyle(fontSize: 13.w, color: COLOR.color_009FE8),
        ),
        10.verticalSpace,
        Obx(() {
          return Column(
            children: List.generate(controller.rewardList.length, (index) {
              return _buildTaskItem(index, controller);
            }).toList(),
          );
        })
      ],
    ).paddingSymmetric(horizontal: 14.w);
  }

  _buildPoint(RewardTaskController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Row(
          children: [
            TextView(
              text: '积分兑换',
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            TextView(
              text: '兑换记录',
              fontSize: 13.w,
              fontWeight: FontWeight.w500,
              color: COLOR.color_999999,
            ),
            Icon(
              Icons.chevron_right,
              size: 14.w,
              color: COLOR.color_999999,
            )
          ],
        ).onOpaqueTap(controller.exchangeDetail),
        10.verticalSpace,
        Obx(() {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.w,
              crossAxisSpacing: 6.w,
              childAspectRatio: 173 / 122,
            ),
            itemCount: controller.pointList.value.length,
            itemBuilder: (context, index) {
              return _buildPointItem(index, controller);
            },
          );
        })
      ],
    ).paddingSymmetric(horizontal: 14.w);
  }

  _buildVideo(RewardTaskController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Row(
          children: [
            TextView(
              text: '金币视频VIP限免专区',
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            TextView(
              text: '更多',
              fontSize: 13.w,
              fontWeight: FontWeight.w500,
              color: COLOR.color_999999,
            ),
            Icon(
              Icons.chevron_right,
              size: 14.w,
              color: COLOR.color_999999,
            )
          ],
        ).onOpaqueTap(controller.toVideoFree),
        10.verticalSpace,
        Obx(() {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7.w,
                childAspectRatio: 174 / 137),
            itemCount: controller.videoList.value.length,
            itemBuilder: (context, index) {
              var video = controller.videoList.value[index];
              return VideoBaseCell.smallOnlyName(video: video,isFree: true,);
            },
          );
        })
      ],
    ).paddingSymmetric(horizontal: 14.w);
  }

  Widget _buildTaskItem(int index, RewardTaskController controller) {
    return Obx(() {
      var item = controller.rewardList[index];
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        alignment: Alignment.center,
        height: 64.w,
        width: 1.sw,
        decoration: BoxDecoration(
          color: COLOR.white_10,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          children: [
            ImageView(
              src: item.loge ?? "",
              height: 44.w,
              width: 44.w,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        text: item.dailyBenefitName ?? "",
                        fontSize: 13.w,
                        fontWeight: FontWeight.w500,
                        color: COLOR.white,
                      ),
                      9.horizontalSpace,
                      TextView(
                        text: item.giftNumCheckInString,
                        fontSize: 12.w,
                        fontWeight: FontWeight.w500,
                        color: COLOR.color_009FE8,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  TextView(
                    text: item.bottomDes,
                    fontSize: 12.w,
                    color: COLOR.white_60,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 28.w,
              width: 60.w,
              decoration: BoxDecoration(
                  color: item.rightButtonColor,
                  borderRadius: BorderRadius.circular(20.w)),
              child: TextView(
                text: item.rightButtonText,
                fontSize: 12.w,
                color: item.rightTextColor,
              ),
            ).onOpaqueTap(() => controller.toTask(
                item.dailyBenefitNum, item.dailyFitDesc ?? ""))
          ],
        ),
      );
    }).marginBottom(8.w);
  }

  Widget _buildPointItem(int index, RewardTaskController controller) {
    return Obx(() {
      var item = controller.pointList.value[index];
      return Container(
        padding: EdgeInsets.all(8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: COLOR.white_10,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          children: [
            ImageView(
              src: item.bonusImage ?? "",
              height: 71.w,
              width: 156.w,
            ),
            8.verticalSpace,
            Row(
              children: [
                TextView(
                  text: '花费${item.redemptionIntegral}积分',
                  fontSize: 11.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.white_60,
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 24.w,
                  width: 56.w,
                  decoration: BoxDecoration(
                      color: COLOR.color_009FE8,
                      borderRadius: BorderRadius.circular(20.w)),
                  child: TextView(
                    text: "立即兑换",
                    color: COLOR.white,
                    fontSize: 10.w,
                  ),
                ).onOpaqueTap(() => controller.exchangePoint(item))
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTop(RewardTopVip item, RewardTaskController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 14.w),
          width: 100.w,
          height: 112.w,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(AppImagePath.reward_bg_vip_top)),
              borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            children: [
              ImageView(
                src: item.image,
                width: 48.w,
                height: 48.w,
              ),
              6.verticalSpace,
              TextView(
                text: item.title,
                fontSize: 13.w,
                color: COLOR.white,
              ),
              2.verticalSpace,
              TextView(
                text: '价值${item.price}元',
                fontSize: 10.w,
                color: COLOR.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
        7.verticalSpace,
        Container(
          width: 54.w,
          height: 28.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.w),
              color: controller.isVip
                  ? COLOR.white.withValues(alpha: 0.1)
                  : COLOR.color_ffd5a8),
          child: TextView(
            text: controller.isVip ? "已领取" : "待领取",
            fontSize: 11.w,
            color: controller.isVip
                ? COLOR.white.withValues(alpha: 0.6)
                : COLOR.color_763708,
          ),
        )
      ],
    );
  }
}
