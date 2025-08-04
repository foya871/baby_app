import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/play/video_info_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class HomeHorizontalCell extends StatelessWidget {
  final VideoInfoModel model;
  final double width;
  HomeHorizontalCell({required this.model, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: model.coverImg ?? '',
                width: width,
                height: 85.h,
                borderRadius: BorderRadius.circular(5.r),
              ),
              Positioned(
                bottom: 5.h,
                left: 3.w,
                right: 3.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageView(
                          src: AppImagePath.home_ic_white_play,
                          width: 12.r,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          Utils.numFmt(model.watchNum ?? 0),
                          style: TextStyle(fontSize: 11.sp, color: COLOR.white),
                        ),
                      ],
                    ),
                    Text(
                      Utils.secondsToTime(model.playTime),
                      style: TextStyle(fontSize: 11.sp, color: COLOR.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            model.title ?? '',
            style: TextStyle(
              fontSize: 13.w,
              color: COLOR.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).onTap(() => Get.toPlayVideo(videoId: model.videoId ?? 0));
  }
}
