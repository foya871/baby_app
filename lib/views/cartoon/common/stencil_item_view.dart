import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/cartoon/common/stencil_make_dialog_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../../services/user_service.dart';

///AI 模板item
class StencilItemView extends StatelessWidget {
  static final width = 163.w;
  static final bigImageHeight = 238.w;
  static final smallImageHeight = 216.w;
  final bool isVideo;
  final String stencilId;
  final String title;
  final String coverImageUrl;
  final double price;
  final int useCount;
  final double imageWidth;
  final double imageHeight;

  StencilItemView.big({
    super.key,
    required this.isVideo,
    required this.stencilId,
    required this.title,
    required this.coverImageUrl,
    required this.price,
    required this.useCount,
  })  : imageWidth = width,
        imageHeight = bigImageHeight;

  StencilItemView.small({
    super.key,
    required this.isVideo,
    required this.stencilId,
    required this.title,
    required this.coverImageUrl,
    required this.price,
    required this.useCount,
  })  : imageWidth = width,
        imageHeight = smallImageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ImageView(
              src: coverImageUrl,
              width: imageWidth,
              height: imageHeight,
              borderRadius: BorderRadius.circular(8.w),
            ),
            Positioned(
              top: 5.w,
              left: 5.w,
              child: TextView(
                text: '$useCount人使用',
                fontSize: 10.w,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        6.verticalSpace,
        TextView(
          text: title,
          fontSize: 13.w,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        12.verticalSpace,
      ],
    ).onOpaqueTap(() {
      Get.bottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        Wrap(
          children: [
            StencilMakeDialogView(
              isVideo: isVideo,
              stencilId: stencilId,
              title: title,
              coverImageUrl: coverImageUrl,
              price: price,
            ),
          ],
        ),
      );
    });
  }
}
