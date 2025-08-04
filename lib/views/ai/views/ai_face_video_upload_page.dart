import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../env/environment_service.dart';
import '../../../generate/app_image_path.dart';
import '../../../routes/routes.dart';
import '../../../services/user_service.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../common/ai_app_bar.dart';
import '../common/ai_make_button.dart';
import '../common/ai_picker_icon.dart';
import '../controllers/ai_face_video_upload_page_controller.dart';

class AiFaceVideoUploadPage extends GetView<AiFaceVideoUploadPageController> {
  const AiFaceVideoUploadPage({super.key});

  Widget _buildStencil() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                controller.stencil.stencilName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Styles.fontSize.sm,
                    fontWeight: FontWeight.bold,
                    color: COLOR.color_333333),
              ),
            ),
            10.horizontalSpace,
            // Image.asset(
            //   AppImagePath.ai_home_close_popup,
            //   width: 16.w,
            //   height: 16.w,
            // ).onTap(() => Get.back()),
          ],
        ),
        SizedBox(height: 14.w),
        Stack(
          children: [
            ImageView(
              src: controller.stencil.originalImg,
              width: 1.sw,
              height: 190.w,
              borderRadius: Styles.borderRadius.all(8.w),
            ),
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  AppImagePath.app_default_play_white,
                  width: 30.4.w,
                  height: 38.w,
                ),
              ),
            )
          ],
        ).onTap(() {
          String playPath = Environment.buildAuthPlayUrlString(
            videoUrl: controller.stencil.playPath,
            authKey: controller.stencil.authKey,
            id: controller.stencil.cdnRes?.id,
          );

          Get.toVideoBoxByURL(url: playPath);
        })
      ],
    );
  }

  Widget _buildPicker() {
    final _ = controller;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '上传脸部信息',
            style: TextStyle(
                fontSize: Styles.fontSize.sm,
                fontWeight: FontWeight.bold,
                color: COLOR.color_333333),
          ),
        ),
        SizedBox(height: 6.w),
        Obx(() {
          final image = _.pickedImage.value;
          Widget child;
          BorderRadius? borderRadius;
          Color? bgColor;
          if (image.isEmpty) {
            child = Center(
              child: AiPickerIcon.example(onTap: _.onTapPick),
            );
            borderRadius = Styles.borderRadius.all(8.w);
            bgColor = COLOR.color_EEEEEE;
          } else {
            child = Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: Styles.borderRadius.all(8.w),
                  child: Image.memory(
                    image.bytes,
                    width: 1.sw,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 5.w,
                  top: 5.w,
                  child: Image.asset(
                    AppImagePath.ai_home_upload_close,
                    width: 15.w,
                    height: 15.w,
                  ).onTap(_.onTapClear),
                )
              ],
            );
          }
          return Container(
            height: 190.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: bgColor,
            ),
            child: child,
          );
        }),
      ],
    );
  }

  Widget _buildMakeButton() {
    return Obx(() {
      final step = controller.step.value;
      if (step == AiPickImageStep.waitSelect) {
        return AiMakeButton(
          '上传',
          width: double.infinity,
          textColor: COLOR.themeSelectedColor,
          onTap: controller.onTapMake,
        );
      } else if (step == AiPickImageStep.waitSubmit) {
        final costType = Get.find<UserService>().checkAiCost(
          costGold: controller.stencil.amount,
        );
        double? gold;
        if (costType == AiCostType.gold) {
          gold = controller.stencil.amount;
        }
        return AiMakeButton(
          '一键换脸',
          gold: gold,
          width: double.infinity,
          textColor: COLOR.white,
          backgroundColor: COLOR.themeSelectedColor,
          onTap: controller.onTapMake,
        );
      } else if (step == AiPickImageStep.submitted) {
        return const AiMakeButton(
          '已提交',
          width: double.infinity,
          // onTap: controller.onTapMake,
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildBody() {
    final _ = controller;
    return Wrap(children: [
      Container(
        padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
        decoration: BoxDecoration(
          color: COLOR.color_090B16,
          borderRadius: Styles.borderRadius.m,
        ),
        child: Column(
          children: [
            _buildStencil(),
            SizedBox(height: 20.w),
            _buildPicker(),
            SizedBox(height: 29.w),
            _buildMakeButton(),
            SizedBox(height: ScreenUtil().bottomBarHeight + 20.w)
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AiAppBar(),
        body: _buildBody(),
      );
}
