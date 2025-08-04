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
import '../../common/ai_cost_tips.dart';
import '../../common/ai_make_button.dart';
import '../../common/ai_picker_icon.dart';
import '../../controllers/tabs/ai_tab_cloth_page_controller.dart';

class AiTabClothPage extends StatelessWidget {
  const AiTabClothPage({super.key});

  Widget _buildPick(AiTabClothPageController _) {
    return Container(
      width: 118.w,
      height: 118.w,
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius.all(8.w),
        color: COLOR.white.withValues(alpha: 0.1),
      ),
      clipBehavior: Clip.hardEdge,
      child: Obx(
        () {
          final image = _.pickedImage.value;
          if (image.isEmpty) {
            return Center(child: AiPickerIcon(onTap: _.onTapPicker));
          } else {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.memory(
                  image.bytes,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  right: 5.w,
                  top: 5.w,
                  child: Obx(
                    () {
                      if (_.step.value == AiPickImageStep.submitted) {
                        return const SizedBox.shrink();
                      }
                      return Image.asset(
                        AppImagePath.ai_home_upload_close,
                        width: 15.w,
                        height: 15.w,
                        fit: BoxFit.cover,
                      ).onTap(_.onTapClear);
                    },
                  ),
                ),
                Positioned(
                  child: Obx(
                    () {
                      if (_.step.value == AiPickImageStep.submitted) {
                        return Center(
                          child: Image.asset(
                            AppImagePath.ai_home_submitted,
                            width: 40.w,
                            height: 40.w,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  // Widget _buildPickTips() {
  //   return Obx(() {
  //     final userService = Get.find<UserService>();
  //     final freeCount = "${userService.user.aiNum ?? 0}";
  //     const size = '2M';
  //     const interval = '60s';

  //     return EasyRichText(
  //       '图片不可超过$size，上传间隔时间为$interval，您的免费次数$freeCount',
  //       defaultStyle: TextStyle(
  //         fontSize: 13.w,
  //         color: COLOR.color_333333,
  //       ),
  //       patternList: [
  //         EasyRichTextPattern(
  //           targetString: size,
  //           style: TextStyle(fontSize: 13.w, color: COLOR.themeSelectedColor),
  //         ),
  //         EasyRichTextPattern(
  //           targetString: interval,
  //           style: TextStyle(fontSize: 13.w, color: COLOR.themeSelectedColor),
  //         ),
  //         EasyRichTextPattern(
  //           targetString: freeCount,
  //           stringBeforeTarget: "次数",
  //           matchWordBoundaries: false,
  //           style: TextStyle(fontSize: 13.w, color: COLOR.themeSelectedColor),
  //         )
  //       ],
  //     );
  //   });
  // }

  Widget _buildTips() {
    final titleStyle = TextStyle(
      fontSize: 14.w,
      color: COLOR.primaryText,
    );
    final tipsStyle = TextStyle(
      fontSize: 12.w,
      color: COLOR.primaryText.withValues(alpha: 0.8),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      children: [
        Text('注意事项：', style: titleStyle),
        Text('1.照片尽量提供人物正面脸部照片', style: tipsStyle),
        Text('2.照片清晰度和光度不能太低', style: tipsStyle),
        Text('3.不支持多人照片，禁止未成年人照片', style: tipsStyle),
      ],
    );
  }

  Widget _buildCaseTitle() {
    return Text(
      '示例：',
      style: TextStyle(fontSize: 13.w, color: COLOR.color_9B9B9B),
    );
  }

  Widget _buildCase() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppImagePath.ai_cloth_case_1,
          width: 162.w,
          height: 224.w,
        ),
        Image.asset(
          AppImagePath.ai_cloth_case_2,
          width: 162.w,
          height: 224.w,
        ),
      ],
    );
  }

  Widget _buildButtons(AiTabClothPageController _) {
    return AiMakeButton(
      '生成',
      width: 240.w,
      onTap: _.onTapMake,
    );
    // return Obx(() {
    //   final step = _.step.value;
    //   if (step == AiPickImageStep.waitSelect) {
    //     return AiMakeButton(
    //       '上传',
    //       width: double.infinity,
    //       textColor: COLOR.themeSelectedColor,
    //       onTap: _.onTapMake,
    //     );
    //   } else if (step == AiPickImageStep.waitSubmit) {
    //     final costType = Get.find<UserService>().checkAiCost(
    //       costGold: Consts.aiClothCostGold,
    //       costAiNum: Consts.aiClothCostCount,
    //     );
    //     double? gold;
    //     if (costType == AiCostType.gold) {
    //       gold = Consts.aiClothCostGold;
    //     }
    //     return AiMakeButton(
    //       '一键去衣',
    //       gold: gold,
    //       width: double.infinity,
    //       textColor: COLOR.white,
    //       backgroundColor: COLOR.themeSelectedColor,
    //       onTap: _.onTapMake,
    //     );
    //   } else if (step == AiPickImageStep.submitted) {
    //     return AiMakeButton(
    //       '再次上传',
    //       width: double.infinity,
    //       textColor: COLOR.themeSelectedColor,
    //       onTap: _.onTapClear,
    //     );
    //   } else {
    //     return const SizedBox.shrink();
    //   }
    // });
  }

  Widget _buildCosts() => Obx(
        () => AiCostTips(
          gold: Consts.aiClothCostGold,
          freeCount: Get.find<UserService>().user.aiNum,
          style: AiCostTipsStyle.per,
        ),
      );

  Widget _buildResultTips() {
    final titleStyle = TextStyle(
      fontSize: 14.w,
      color: COLOR.primaryText,
    );
    final tipsStyle = TextStyle(
      fontSize: 12.w,
      color: COLOR.primaryText.withValues(alpha: 0.8),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      children: [
        Text('注意事项：', style: titleStyle),
        Text('1.素材仅供AI使用，绝无外泄风险，请放心使用。', style: tipsStyle),
        Text('2.素材需清晰，小于2Mb，上传间隔大于60S', style: tipsStyle),
        Text('3.本功能不支持多人图片', style: tipsStyle),
        Text('4.生成失败返回免费次数，免费次数若违规则作废', style: tipsStyle),
        Text('5.禁止使用未成年人图片', style: tipsStyle),
      ],
    );
  }

  Widget _buildBody(AiTabClothPageController _) {
    return CustomScrollView(
      slivers: [
        SizedBox(height: 15.w).sliver,
        Row(spacing: 5.w, children: [_buildPick(_), _buildTips()]).sliver,
        SizedBox(height: 15.w).sliver,
        _buildCaseTitle().sliver,
        SizedBox(height: 9.w).sliver,
        _buildCase().sliver,
        20.verticalSpaceFromWidth.sliver,
        _buildCosts().center.sliver,
        22.verticalSpaceFromWidth.sliver,
        _buildButtons(_).center.sliver,
        20.verticalSpaceFromWidth.sliver,
        _buildResultTips().sliver,
        SizedBox(height: 20.w).sliver,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<AiTabClothPageController>();
    return _buildBody(_);
  }
}
