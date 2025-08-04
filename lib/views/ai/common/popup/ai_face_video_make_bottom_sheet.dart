import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../components/get_builder.dart';
import '../../../../components/image_picker/easy_image_picker_file.dart';
import '../../../../components/image_view.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../env/environment_service.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/ai/ai_models.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../ai_bytes_image.dart';
import '../ai_cost_tips.dart';
import '../ai_picker_icon.dart';
import '../ai_utils.dart';
import 'ai_wxts_image_dialog.dart';

class _Controller extends GetxController {
  final pickedImage = AiBytesImage.empty().obs;

  void onTapPick(EasyImagePickerFile? file) async {
    if (file == null) return;
    final bytes = await file.bytes;
    if (bytes == null) return;
    pickedImage.value = AiBytesImage(bytes: bytes);
  }

  void onTapClear() {
    pickedImage.value = AiBytesImage.empty();
  }
}

class AiFaceVideoMakeBottomSheet extends AbstractBottomSheet {
  final AiStencilModel stencil;
  final void Function(AiBytesImage? file)? onTapMake;

  AiFaceVideoMakeBottomSheet({required this.stencil, this.onTapMake})
      : super(isScrolledControlled: true);

  Widget _buildStencil() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                stencil.stencilName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Styles.fontSize.sm,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            10.horizontalSpace,
            Image.asset(
              AppImagePath.ai_home_close_popup,
              width: 16.w,
              height: 16.w,
            ).onTap(() => Get.back()),
          ],
        ),
        SizedBox(height: 14.w),
        Stack(
          children: [
            ImageView(
              src: stencil.originalImg,
              width: 1.sw,
              height: 180.w,
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
            videoUrl: stencil.playPath,
            authKey: stencil.authKey,
            id: stencil.cdnRes?.id,
          );

          Get.toVideoBoxByURL(url: playPath);
        })
      ],
    );
  }

  Widget _buildPicker(_Controller _) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '上传脸部信息',
            style: TextStyle(
              fontSize: Styles.fontSize.sm,
              fontWeight: FontWeight.w500,
            ),
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
            bgColor = COLOR.white.withValues(alpha: 0.1);
          } else {
            child = Container(
              margin: EdgeInsets.only(top: 8.w),
              child: Stack(
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
                      width: 22.w,
                      height: 22.w,
                    ).onTap(_.onTapClear),
                  )
                ],
              ),
            );
          }
          return Container(
            height: 179.w,
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

  Widget _buildMakeRow(_Controller _) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Obx(
          //   () => AiCostTips(
          //     gold: stencil.amount,
          //     freeCount: null, // 没有次数
          //     // freeCount: Get.find<UserService>().user.aiMovie ?? 0,
          //   ),
          // ),
          AiCostTips(
            gold: stencil.amount,
            freeCount: null, // 没有次数
            // freeCount: Get.find<UserService>().user.aiMovie ?? 0,
          ),
          AiUtils.buildMakeButton(
            onTap: () => onTapMake?.call(
              _.pickedImage.value.isEmpty ? null : _.pickedImage.value,
            ),
          )
        ],
      );

  Widget _buildBody(_Controller _) {
    return Wrap(children: [
      Container(
        padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
        decoration: BoxDecoration(
          color: COLOR.color_090B16,
          borderRadius: Styles.borderRadius.all(8.w),
        ),
        constraints: BoxConstraints(maxHeight: 0.85.sh),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildStencil(),
              SizedBox(height: 10.w),
              _buildPicker(_),
              SizedBox(height: 29.w),
              const AiWxtsImageTips(),
              10.verticalSpaceFromWidth,
              _buildMakeRow(_),
              SizedBox(height: ScreenUtil().bottomBarHeight + 20.w)
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build() => LocalGetBuilder(
        init: _Controller(),
        builder: (_) => _buildBody(_),
      );
}
