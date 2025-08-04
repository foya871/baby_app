import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../model/video_actress_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/extension.dart';
import '../../image_view.dart';

class ContentVideoBaseCell extends StatelessWidget {
  static final double height = 199.w;
  final double width;
  final double imageHeight;
  final VideoContentModel model;

  ContentVideoBaseCell.small(this.model, {super.key})
      : width = 289.w,
        imageHeight = 165.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageView(
            src: model.cover,
            width: double.infinity,
            height: imageHeight,
            borderRadius: Styles.borderRadius.all(8.w),
          ),
          8.verticalSpace,
          Text(
            model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ).onTap(() => Get.toPlayVideo(videoId: model.videoId));
  }
}
