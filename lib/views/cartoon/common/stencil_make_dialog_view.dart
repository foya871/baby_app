import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/rich_text_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:baby_app/views/cartoon/common/ai_tip_dialog_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../../services/user_service.dart';

class StencilMakeDialogView extends StatefulWidget {
  final bool isVideo;
  final String stencilId;
  final String title;
  final String coverImageUrl;
  final double price;

  const StencilMakeDialogView({
    super.key,
    required this.isVideo,
    required this.stencilId,
    required this.title,
    required this.coverImageUrl,
    required this.price,
  });

  @override
  State<StencilMakeDialogView> createState() => _StencilMakeDialogViewState();
}

class _StencilMakeDialogViewState extends State<StencilMakeDialogView> {
  final userService = Get.find<UserService>();
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.verticalSpace,
        _buildStencilTitle(title: widget.title),
        10.verticalSpace,
        _buildStencilCoverImage(),
        10.verticalSpace,
        _buildStencilTitle(title: "上传脸部信息", isShowClose: false),
        6.verticalSpace,
        15.verticalSpace,
        _buildMakeButton(),
        30.verticalSpace,
      ],
    ).paddingSymmetric(horizontal: 15.w);
  }

  Widget _buildStencilTitle({required String title, bool isShowClose = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: title,
          fontSize: 15.w,
          maxLines: 1,
        ),
        const Spacer(),
        isShowClose
            ? Icon(
                Icons.close,
                size: 20.w,
              ).onOpaqueTap(() {
                Get.back();
              })
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildStencilCoverImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: ImageView(
            src: widget.coverImageUrl,
            width: widget.isVideo ? double.infinity : null,
            height: 180.w,
            borderRadius: Styles.borderRadius.all(5.w),
          ),
        ),
      ],
    ).onOpaqueTap(() {
      if (widget.isVideo) {}
    });
  }

  Widget _buildMakeButton() {
    return SizedBox(
      height: 40.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichTextView(
            text: "金币价:${widget.price}免费次数:${userService.user.aiNum ?? 0}",
            specifyTexts: ["${widget.price}", "${userService.user.aiNum ?? 0}"],
            style: TextStyle(
              fontSize: 12.w,
            ),
            highlightStyle: TextStyle(
              fontSize: 18.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          AppBgView(
            height: 40.w,
            radius: 20.w,
            text: "立即制作",
            imagePath: AppImagePath.app_default_button_bg,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            textSize: 15.w,
            onTap: () {
              if (imageBytes != null && imageBytes!.isNotEmpty) {
                showAlertDialog(
                  context,
                  title: "请选择一张清晰人脸照",
                  content: const AiTipDialogView(),
                  leftText: "不同意",
                  rightText: "同意并上传",
                  onRightButton: () {},
                );
              } else {
                showAlertDialog(
                  context,
                  title: "温馨提示",
                  message: "先上传人脸照片才可以使用",
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
