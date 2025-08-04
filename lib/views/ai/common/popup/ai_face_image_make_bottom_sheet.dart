import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../components/get_builder.dart';
import '../../../../components/image_picker/easy_image_picker_file.dart';
import '../../../../components/image_view.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/ai/ai_models.dart';
import '../../../../services/user_service.dart';
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

class AiFaceImageMakeBottomSheet extends AbstractBottomSheet {
  final AiStencilModel stencil;
  final void Function(AiBytesImage? file)? onTapMake;

  AiFaceImageMakeBottomSheet({required this.stencil, this.onTapMake})
      : super(isScrolledControlled: true);

  Widget _buildStencil() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stencil.stencilName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset(
              AppImagePath.ai_home_close_popup,
              width: 22.w,
              height: 22.w,
            ).onTap(Get.back),
          ],
        ),
        SizedBox(height: 10.w),
        ImageView(src: stencil.originalImg, width: 128.w, height: 179.w),
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
              fontSize: 15.w,
              fontWeight: FontWeight.w600,
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
                  const SizedBox.expand(),
                  Positioned.fill(
                    child: Center(
                      child: Image.memory(
                        image.bytes,
                        width: 128.w,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.w,
                    top: 2.w,
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
          Obx(
            () => AiCostTips(
              gold: stencil.amount,
              freeCount: Get.find<UserService>().user.aiNum ?? 0,
            ),
          ),
          AiUtils.buildMakeButton(
            onTap: () => onTapMake?.call(
              _.pickedImage.value.isEmpty ? null : _.pickedImage.value,
            ),
          )
        ],
      );

  Widget _buildBody(_Controller _) {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
      decoration: BoxDecoration(
        color: COLOR.color_13141F,
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
    );
  }

  @override
  Widget build() => LocalGetBuilder(
        init: _Controller(),
        builder: (_) => _buildBody(_),
      );
}
