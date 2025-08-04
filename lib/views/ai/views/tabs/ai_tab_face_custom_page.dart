import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/color.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../../common/ai_make_button.dart';
import '../../common/ai_picker_icon.dart';
import '../../controllers/tabs/ai_tab_face_custom_page_controller.dart';

class AiTabFaceCustomPage extends GetView<AiTabFaceCustomPageController> {
  const AiTabFaceCustomPage({super.key});

  Widget _buildPickTargetTips() {
    return Text(
      '上传您需要换脸的图片',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15.w,
        color: COLOR.color_111316,
      ),
    );
  }

  Widget _buildPickTarget() {
    return Container(
      height: 190.w,
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius.all(8.w),
        color: COLOR.color_f3f5f8,
      ),
      clipBehavior: Clip.hardEdge,
      child: Obx(
        () {
          final image = controller.targetImage.value;
          if (image.isEmpty) {
            return Center(
                child: AiPickerIcon(onTap: controller.onTapTargetPicker));
          } else {
            return Stack(
              children: [
                const SizedBox.expand(),
                Positioned.fill(
                  child: Center(
                    child: Image.memory(
                      image.bytes,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  right: 6.w,
                  top: 6.w,
                  child: Obx(
                    () {
                      if (controller.targetStep.value ==
                          AiPickImageStep.submitted) {
                        return const SizedBox.shrink();
                      }
                      return Image.asset(
                        AppImagePath.ai_home_upload_close,
                        width: 15.w,
                        height: 15.w,
                      ).onTap(controller.onTapTargetClear);
                    },
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Obx(() {
                      if (controller.targetStep.value !=
                          AiPickImageStep.submitted) {
                        return const SizedBox.shrink();
                      }
                      return Image.asset(
                        AppImagePath.ai_home_submitted,
                        width: 40.w,
                        height: 40.w,
                      );
                    }),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildZhuYiShiXiang() {
    final titleStyle = TextStyle(
        fontSize: 14.w, fontWeight: FontWeight.w500, color: COLOR.color_333333);
    final tipStyle = TextStyle(fontSize: 14.w, color: COLOR.color_666666);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('注意事项', style: titleStyle),
        Text('1、照片只含一名人物', style: tipStyle),
        Text('2、图片不能过暗', style: tipStyle),
        Text('3、图片尽量清晰，否则会出现失败或者影响效果', style: tipStyle),
      ].joinHeight(7.w),
    );
  }

  Widget _buildPickStencilTips() => Text(
        '上传脸部信息',
        style: TextStyle(
            fontSize: 15.w,
            fontWeight: FontWeight.w600,
            color: COLOR.color_111316),
      );

  Widget _buildPickStencil() => Container(
        height: 190.w,
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius.all(8.w),
          color: COLOR.color_f3f5f8,
        ),
        clipBehavior: Clip.hardEdge,
        child: Obx(
          () {
            final image = controller.stencilImage.value;
            if (image.isEmpty) {
              return Center(
                child:
                    AiPickerIcon.example(onTap: controller.onTapStencilPicker),
              );
            } else {
              return Stack(
                children: [
                  const SizedBox.expand(),
                  Positioned.fill(
                    child: Center(
                      child: Image.memory(
                        image.bytes,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 6.w,
                    top: 6.w,
                    child: Obx(
                      () {
                        if (controller.stencilStep.value ==
                            AiPickImageStep.submitted) {
                          return const SizedBox.shrink();
                        }
                        return Image.asset(
                          AppImagePath.ai_home_upload_close,
                          width: 15.w,
                          height: 15.w,
                        ).onTap(controller.onTapStencilClear);
                      },
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: Obx(() {
                        if (controller.stencilStep.value !=
                            AiPickImageStep.submitted) {
                          return const SizedBox.shrink();
                        }
                        return Image.asset(
                          AppImagePath.ai_home_submitted,
                          width: 40.w,
                          height: 40.w,
                        );
                      }),
                    ),
                  )
                ],
              );
            }
          },
        ),
      );

  Widget _buildStencilMakeButton() {
    return Obx(() {
      final targetStep = controller.targetStep.value;
      final stencilStep = controller.stencilStep.value;
      if (targetStep == AiPickImageStep.waitSubmit &&
          stencilStep == AiPickImageStep.waitSubmit) {
        final costType = Get.find<UserService>().checkAiCost(
          costGold: Consts.aiFaceCustomCostGold,
          costAiNum: Consts.aiFaceCustomCostCount,
        );
        double? gold;
        if (costType == AiCostType.gold) {
          gold = Consts.aiFaceCustomCostGold;
        }
        return AiMakeButton(
          '一键换脸',
          gold: gold,
          width: double.infinity,
          textColor: COLOR.white,
          backgroundColor: COLOR.themeSelectedColor,
          onTap: controller.onTapMake,
        );
      } else if (targetStep == AiPickImageStep.submitted &&
          stencilStep == AiPickImageStep.submitted) {
        return AiMakeButton(
          '再次上传',
          width: double.infinity,
          textColor: COLOR.themeSelectedColor,
          onTap: () {
            controller.onTapStencilClear();
            controller.onTapTargetClear();
          },
        );
      } else {
        return AiMakeButton(
          '上传',
          width: double.infinity,
          textColor: COLOR.themeSelectedColor,
          onTap: controller.onTapMake,
        );
      }
    });
  }

  // Widget _buildMakeRow() => Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Obx(
  //           () => AiCostTips(
  //             gold: Consts.aiFaceCustomCostGold,
  //             freeCount: Get.find<UserService>().user.aiNum ?? 0,
  //           ),
  //         ),
  //         AiUtils.buildMakeButton(onTap: controller.onTapMake)
  //       ],
  //     );

  Widget _buildBody() => CustomScrollView(
        slivers: [
          10.verticalSpaceFromWidth.sliver,
          _buildPickTargetTips().sliver,
          12.verticalSpaceFromWidth.sliver,
          _buildPickTarget().sliver,
          // 11.verticalSpaceFromWidth.sliver,
          // const AiImageLimitTips().sliver,
          20.verticalSpaceFromWidth.sliver,
          _buildPickStencilTips().sliver,
          6.verticalSpaceFromWidth.sliver,
          _buildPickStencil().sliver,
          20.verticalSpaceFromWidth.sliver,
          // _buildMakeRow().sliver,
          _buildStencilMakeButton().sliver,
          20.verticalSpaceFromWidth.sliver,
          _buildZhuYiShiXiang().sliver,
          80.verticalSpaceFromWidth.sliver
        ],
      );

  @override
  Widget build(BuildContext context) => _buildBody();
}
